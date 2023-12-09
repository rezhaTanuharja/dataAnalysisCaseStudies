<h1>Set Up COVID-19 MySQL Database</h1>
<p>
  <a href="../README.md">Back to home</a>
</p>

<div id="structure">
  <h3>Database Structure</h3>
  <p>
    This case study uses a database called '<strong>covid</strong>'.
    The database has four tables:
    <ul>
      <li>countries</li>
      <li>casesDeaths</li>
      <li>testing</li>
      <li>vaccinations</li>
    </ul>
  </p>
</div>

<div id="createDatabase">
  <h3>Create Database</h3>
  <p>
    To create the database, login to your server and execute the following query:
    <pre lang="sql">CREATE DATABASE `covid`;</pre>
    Note that using backticks is not necessary here but is considered a good practice to avoid unexpected behavior in case the database name is equal to MySQL's reserved keywords.
  </p>
</div>

<div>
  <h3>Create Tables and Load Data from CSV Files</h3>
  You need to execute queries inside <a href="../scripts/import.sql">import.sql</a> to create the tables and import data in <a href="../dataSources/">dataSources</a> folder into the tables.
  Note that you need to change the paths to csv files according to their respective location on your computer.
  The following provides a step-by-step explanation of the script:
  <div id="addTables">
    <h4>Add Tables to The Database</h4>
    <p>
      The following query create a new table `tableName` in the database `databaseName`.
      When creating a table, you need to specify the dataName and dataType.
      This tells the server what data is in the table and how much memory is required for each data entry.
      <pre lang="sql">
CREATE TABLE `databaseName`.`tableName` (
  `dataName` dataType,
  `dataName` dataType,
  ...
  );</pre>
      If there is an existing table with the same name in the database, an attempt to create a new table with that name leads to error.
      Therefore, it's common to remove any existing table with the desired name before creating the new table:
      <pre lang="sql">
DROP TABLE IF EXIST `databaseName`.`tableName`;
CREATE TABLE `databaseName`.`tableName` (
  `dataName` dataType,
  `dataName` dataType,
  ...
  );</pre>
    </p>
  </div>
  <div id="loadData">
    <h4>Load Data from CSV Files into Tables</h4>
    <p>
      After creating the database and tables, now we load the data from csv files in <a href="../dataSources/">dataSources</a> folder into the tables.
      First, we need to configure the server to allow interactions with local files with the following:
      <pre>SET GLOBAL local_infile=1;</pre>
      Subsequently, we can load our csv files' data into the table with the following query:
      <pre lang="sql">
LOAD DATA LOCAL INFILE 'path to csv file'
  INTO TABLE `databaseName`.`tableName`
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;</pre>
      Replace the path to csv file with the absolute path to the file on your computer and replace databaseName and tableName accordingly.
    </p>
  </div>
</div>

<p>
  <a href="../README.md">Back to home</a>
</p>
