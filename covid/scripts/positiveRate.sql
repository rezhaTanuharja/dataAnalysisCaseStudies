/**
  * @file positiveRate.sql
  *
  * @brief 
  * SQL script to synthesize positive covid test rate data from several SQL tables.
  *
  * @note
  * This script only works with external Python script.
  */

/**
  * @brief
  * Common Table Expression (CTE) to retrieve list of countries in the defined continent.
  */
WITH `cont` AS (
  SELECT `country`
    FROM `covid`.`countries`
    WHERE `continent` = 'Europe'
)
/**
  * @brief
  * Main query to synthesize positive covid test rate data.
  */
SELECT 
  DATE_FORMAT(cd.`date`, '%Y-%m') AS `yearMonth`, 
  cd.`location`, 
  COALESCE(SUM(cd.`newCases`) / NULLIF(SUM(ct.`smoothedDailyChange`), 0), 0) as `positiveRate`
FROM `covid`.`casesDeaths` AS cd
  JOIN `covid`.`testing` AS ct
    ON ct.`entity` LIKE CONCAT(cd.`location`, '%') AND ct.`date` = cd.`date`
WHERE cd.`location` IN (
  SELECT `country` FROM `cont`
  )
  AND
  cd.`date` BETWEEN '2019-01-01' AND '2023-12-31'
GROUP BY yearMonth, location
HAVING `positiveRate` <= 1;