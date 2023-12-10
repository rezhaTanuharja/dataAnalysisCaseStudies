import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.decomposition import PCA
from sklearn.preprocessing import StandardScaler

# create engine to establish connection to database
# database and login information are in .env file

load_dotenv()

host = os.getenv("DB_HOST")
user = os.getenv("DB_USER")
password = os.getenv("DB_PASSWORD")
database = os.getenv("DB_DATABASE")

engine = create_engine(f"mysql://{user}:{password}@{host}/{database}")

# read SQL queries from a separate .sql file
# semicolons separate the queries
# execute all queries but the last query gives the final data

with open('correlation.sql', 'r') as file:
    sqlScript = file.read()

queries = [query.strip() for query in sqlScript.split(';') if query.strip()]

with engine.connect() as connection:
    for query in queries:
        connection.execute(text(query))

    result = connection.execute(text(queries[-1]))

# store result as dataframe and pivot the data for postprocessing

df = pd.DataFrame(result.fetchall(), columns=result.keys())

engine.dispose()

# perform PCA on numerical data except year

numericalData = df.select_dtypes(include='number')
numericalData = numericalData.drop('year', axis=1)

scaler = StandardScaler()
scaled_data = scaler.fit_transform(numericalData)

pca = PCA()
principal_components = pca.fit_transform(scaled_data)

# Create a DataFrame with principal components

pc_df = pd.DataFrame(
    data=principal_components,
    columns=[f'PC{i+1}' for i in range(scaled_data.shape[1])]
    )

# scatter plot using the first two principal components

plt.figure(figsize=(12, 6))
plt.scatter(pc_df['PC1'], pc_df['PC2'], alpha=0.2, facecolors='black', s=10)
plt.xlim([-5.0, 12.0])
plt.ylim([-2.0, 6.0])
plt.xlabel('Principal Component 1 (PC1)')
plt.ylabel('Principal Component 2 (PC2)')

# plot vectors of loadings

loadings = pca.components_[:2, :].T
for i, (x, y) in enumerate(loadings):
    plt.quiver(0, 0, x, y, angles='xy', scale_units='xy', scale=0.2, color='red', width=0.002)
    plt.text(x / 0.19, y / 0.19, f'{numericalData.columns[i]}', color='black', ha='left', va='bottom', fontsize=8, bbox=dict(facecolor='white', alpha=0.9, edgecolor='black', boxstyle='round,pad=0.5'))

# Set aspect ratio to 'equal' for a more accurate representation

plt.gca().set_aspect('equal', adjustable='box')

plt.tight_layout()
plt.show()
