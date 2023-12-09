import os
from dotenv import load_dotenv
from sqlalchemy import create_engine, text
import pandas as pd
import plotly.express as px


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

with open('positiveRate.sql', 'r') as file:
    sqlScript = file.read()

queries = [query.strip() for query in sqlScript.split(';') if query.strip()]

with engine.connect() as connection:
    for query in queries:
        connection.execute(text(query))

    result = connection.execute(text(queries[-1]))

# store result as dataframe and pivot the data for postprocessing
# replace missing values with 0

df = pd.DataFrame(result.fetchall(), columns=result.keys())

df_pivot = df.pivot(index='location', columns='yearMonth', values='positiveRate')
df_pivot = df_pivot.fillna(0)

# visualize data using heatmap

fig = px.imshow(
    df_pivot,
    x=df_pivot.columns.format(),
    y=df_pivot.index,
    labels=dict(x='Time', y='Location', color='Positive Rate'),
    title='Positive Covid Test Heatmap',
    color_continuous_scale='Greys'
)

fig.update_layout(
    font=dict(size=8),
    margin=dict(l=50, r=50, t=50, b=50),
)

fig.show()
