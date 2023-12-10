import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

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

# compute correlation matrix using only the numerical data except year

numericalData = df.select_dtypes(include='number')
numericalData = numericalData.drop('year', axis=1)
corrMatrix = numericalData.corr()

# postprocessing

plt.figure(figsize=(8, 6))
sns.heatmap(corrMatrix, annot=True, cmap='vlag', fmt=".2f", linewidths=.5)
plt.tick_params(axis='x', top=True, labeltop=True, bottom=False, labelbottom=False)
plt.xticks(rotation=45, ha='left')
plt.tight_layout()
plt.show()
