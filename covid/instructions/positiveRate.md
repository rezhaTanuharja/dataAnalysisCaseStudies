<h1>Positive COVID-19 Test Rate in Europe</h1>
<a href="../README.md">Back to home</a>

<div id="background">
  <h3>Background</h3>
  <p>
    The number of new COVID-19 cases fluctuates over time and varies accross different countries.
    A high number of new cases does not necessarily equal to a high infection rate because, given the same infection rate:
    <ul>
      <li>Countries with larger population are going to have higher numbers of new cases.</li>
      <li>Countries with higher number of tests are going to report higher numbers of new cases.</li>
    </ul>
    An alternative metric to quantify infection rate is the positive test rate.
    It is a ratio between the number of positive test results and the total number of tests.
    While the metric is not perfect, it may provide better insights to the infection rate in each country at a given time.
  </p>
</div>

<div id="problem">
  <h3>Problem Statement</h3>
  <p>
    In this case study, we are going to explore and visualize the positive COVID-19 test rate in Europe.
    The data are available in the following three tables:
    <ul>
      <li>casesDeaths</li>
      <li>countries</li>
      <li>testing</li>
    </ul>
    The table `casesDeaths` contains information about the number of daily new cases in each country.
    The table `countries` lists countries with their respective continent and population.
    The table `testing` contains the number of daily COVID-19 tests in each country.
  </p>
</div>

<div id="solution">
  <h3>Solution Steps</h3>
  <p>
    The followings are necessary to synthesize the data and visualize them:
  </p>
  <details>
    <summary>
    Extract a list of countries that belong to Europe from `countries`
    </summary>
    <pre>
WITH `europe` AS (
  SELECT `country`
  FROM `covid`.`countries`
  WHERE `continent` = 'Europe'
)</pre>
  </details>
  <details>
    <summary>
    Pair the number of new cases from `casesDeaths` and tests from `testing` for each country and date
    </summary>
    <pre>
SELECT
  DATE_FORMAT(cd.`date`, '%Y-%m') AS `yearMonth`,
  cd.`location`,
  COALESCE(SUM(cd.`newCases`) / NULLIF(SUM()ct.`smoothedDailyChange`, 0), 0)
    AS `positiveRate`,
FROM `covid`.`casesDeaths` AS cd
  JOIN `covid`.`testing` AS ct
    ON ct.`entity` LIKE CONCAT(cd.`location`, '%') AND ct.`date` = cd.`date`
WHERE cd.`location` IN (SELECT `country` FROM `europe`)
  AND cd.`date` BETWEEN '2019-01-01' AND '2023-12-31'
GROUP BY `yearMonth`, `location`
HAVING `positiveRate` <= 1;</pre>
  </details>
</div>

<div id="results">
  <h3>Results</h3>
  <iframe src="../assets/images/positiveRateEurope.html"></iframe>
</div>
