/**
  * @file deathsBreakdown.sql
  *
  * @brief 
  * SQL script to retrieve information about the deadliest day during COVID-19 pandemic.
  *
  * @note
  * This script only works with external Python script.
  * The aforementioned Python script defines the variable 'numCountries'.
  */

/**
  * @brief
  * Common Table Expression (CTE) to preprocess COVID-19 deaths data.
  */
WITH `countryData` AS (
  SELECT `location`, `newDeaths`, SUM(`newDeaths`) OVER (PARTITION BY `date`) AS `totalNewDeaths`
    FROM `covid`.`casesDeaths`
    WHERE
      `location` NOT IN (
        'World', 'Europe', 'Asia', 'North America', 'South America', 'European Union'
      )
      AND
      `location` NOT LIKE '%%income%%'
)
/**
  * @brief
  * Main query to retrieve death count by country in the deadliest day.
  */
SELECT `location`, `newDeaths`
  FROM `countryData`
  WHERE `totalNewDeaths` = (
    SELECT MAX(`totalNewDeaths`) FROM `countryData`
  )
  ORDER BY `newDeaths` DESC
  LIMIT numCountries;