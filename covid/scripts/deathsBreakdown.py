import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
import pandas as pd
import matplotlib.pyplot as plt

numCountries = 12

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

with open('deathsBreakdown.sql', 'r') as file:
    sqlScript = file.read()

sqlScript = sqlScript.replace("numCountries", str(numCountries))

queries = [query.strip() for query in sqlScript.split(';') if query.strip()]

with engine.connect() as connection:
    for query in queries:
        connection.execute(text(query))

    result = connection.execute(text(queries[-1]))

# store result as dataframe and pivot the data for postprocessing

df = pd.DataFrame(result.fetchall(), columns=result.keys())
df = df[::-1]

engine.dispose()

fig, ax = plt.subplots(figsize=(10,6))
ax.barh(df['location'], df['newDeaths'], color='black', zorder=2)
ax.set_xlabel('Deaths in The Day')
ax.set_xscale('log')
ax.grid(which='both', linestyle='-', linewidth=0.5, color='gray', axis='x', zorder=1)
ax.minorticks_on()
ax.grid(which='minor', linestyle=':', linewidth=0.5, color='gray', axis='x', zorder=1)
plt.tight_layout()
plt.show()
