import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
import pandas as pd
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

with open('inequality.sql', 'r') as file:
    sqlScript = file.read()

queries = [query.strip() for query in sqlScript.split(';') if query.strip()]

with engine.connect() as connection:
    for query in queries:
        connection.execute(text(query))

    result = connection.execute(text(queries[-1]))

# store result as dataframe and pivot the data for postprocessing

df = pd.DataFrame(result.fetchall(), columns=result.keys())

engine.dispose()

numericalData = df.select_dtypes(include='number')

corrMatrix = numericalData.corr()

# Set up the matplotlib figure
plt.figure(figsize=(8, 6))
plt.scatter(df['GDP Per Capita'], df['Gini Coefficient'])

# Show the plot
plt.tight_layout()
plt.show()
