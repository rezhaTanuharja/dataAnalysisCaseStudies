-- Active: 1701138149306@@127.0.0.1@3306@lifeExpectancy
DROP TABLE IF EXISTS `lifeExpectancy`;
CREATE TABLE `lifeExpectancy` (
  `entity` VARCHAR(20),
  `code` VARCHAR(3),
  `year` INT,
  `expectancy` FLOAT(6,4)
);
LOAD DATA LOCAL INFILE '/Users/rezhadrian/Works/dataAnalysisCaseStudies/lifeExpectancy/dataSources/life-expectancy-hmd-unwpp.csv'
INTO TABLE `lifeExpectancy`.`lifeExpectancy`
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS;

DROP TABLE IF EXISTS `gdpPerCapita`;
CREATE TABLE `gdpPerCapita` (
  `entity` VARCHAR(20),
  `code` VARCHAR(3),
  `year` INT,
  `gdpPerCapita` FLOAT(10,4)
);
LOAD DATA LOCAL INFILE '/Users/rezhadrian/Works/dataAnalysisCaseStudies/lifeExpectancy/dataSources/gdp-per-capita-worldbank.csv'
INTO TABLE `lifeExpectancy`.`gdpPerCapita`
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS;

DROP TABLE IF EXISTS `crudeBirthRate`;
CREATE TABLE `crudeBirthRate` (
  `entity` VARCHAR(20),
  `code` VARCHAR(3),
  `year` INT,
  `birthRate` FLOAT(5,3)
);
LOAD DATA LOCAL INFILE '/Users/rezhadrian/Works/dataAnalysisCaseStudies/lifeExpectancy/dataSources/crude-birth-rate.csv'
INTO TABLE `lifeExpectancy`.`crudeBirthRate`
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS;

DROP TABLE IF EXISTS `giniIndex`;
CREATE TABLE `giniIndex` (
  `entity` VARCHAR(20),
  `code` VARCHAR(3),
  `year` INT,
  `coefficient` FLOAT(9,8)
);
LOAD DATA LOCAL INFILE '/Users/rezhadrian/Works/dataAnalysisCaseStudies/lifeExpectancy/dataSources/economic-inequality-gini-index.csv'
INTO TABLE `lifeExpectancy`.`giniIndex`
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS;

DROP TABLE IF EXISTS `extremePoverty`;
CREATE TABLE `extremePoverty` (
  `entity` VARCHAR(20),
  `code` VARCHAR(3),
  `year` INT,
  `population` INT
);
LOAD DATA LOCAL INFILE '/Users/rezhadrian/Works/dataAnalysisCaseStudies/lifeExpectancy/dataSources/total-population-living-in-extreme-poverty-by-world-region.csv'
INTO TABLE `lifeExpectancy`.`extremePoverty`
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS;

DROP TABLE IF EXISTS `neonatal`;
CREATE TABLE `neonatal` (
  `entity` VARCHAR(20),
  `code` VARCHAR(3),
  `year` INT,
  `mortalityRate` FLOAT(7,6)
);
LOAD DATA LOCAL INFILE '/Users/rezhadrian/Works/dataAnalysisCaseStudies/lifeExpectancy/dataSources/neonatal-mortality-wdi.csv'
INTO TABLE `lifeExpectancy`.`neonatal`
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS;

DROP TABLE IF EXISTS `youth`;
CREATE TABLE `youth` (
  `entity` VARCHAR(20),
  `code` VARCHAR(3),
  `year` INT,
  `mortalityRate` FLOAT(8,6)
);
LOAD DATA LOCAL INFILE '/Users/rezhadrian/Works/dataAnalysisCaseStudies/lifeExpectancy/dataSources/youth-mortality-rate.csv'
INTO TABLE `lifeExpectancy`.`youth`
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS;

DROP TABLE IF EXISTS `infant`;
CREATE TABLE `infant` (
  `entity` VARCHAR(20),
  `code` VARCHAR(3),
  `year` INT,
  `mortalityRate` FLOAT(8,6)
);
LOAD DATA LOCAL INFILE '/Users/rezhadrian/Works/dataAnalysisCaseStudies/lifeExpectancy/dataSources/infant-mortality.csv'
INTO TABLE `lifeExpectancy`.`infant`
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS;

DROP TABLE IF EXISTS `child`;
CREATE TABLE `child` (
  `entity` VARCHAR(20),
  `code` VARCHAR(3),
  `year` INT,
  `mortalityRate` FLOAT(8,6)
);
LOAD DATA LOCAL INFILE '/Users/rezhadrian/Works/dataAnalysisCaseStudies/lifeExpectancy/dataSources/child-mortality-igme.csv'
INTO TABLE `lifeExpectancy`.`child`
  FIELDS TERMINATED BY ','
  ENCLOSED BY '"'
  LINES TERMINATED BY '\n'
  IGNORE 1 ROWS;