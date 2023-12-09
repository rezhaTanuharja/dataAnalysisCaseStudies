/**
  * @file import.sql
  *
  * @brief 
  * SQL script to create table and import csv files' data into them.
  *
  * @note
  * Change the path to csv files according to their respective location on your computer!
  */

SET GLOBAL local_infile=1;

DROP TABLE IF EXISTS casesDeaths;
CREATE TABLE casesDeaths (
    `date` DATE,
    `location` VARCHAR(20),
    `newCases` INT,
    `newDeaths` INT,
    `totalCases` INT,
    `totalDeaths` INT,
    `weeklyCases` INT,
    `weeklyDeaths` INT,
    `biweeklyCases` INT,
    `biweeklyDeaths` INT
);
LOAD DATA LOCAL INFILE '/Users/rezhadrian/Works/dataAnalysisCaseStudies/covid/dataSources/casesDeaths.csv'
INTO TABLE covid.casesDeaths
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

DROP TABLE IF EXISTS vaccinations;
CREATE TABLE vaccinations (
    `location` VARCHAR(20),
    `isoCode` VARCHAR(3),
    `date` DATE,
    `totalVaccinations` INT,
    `peopleVaccinated` INT,
    `peopleFullyVaccinated` INT,
    `totalBoosters` INT,
    `dailyVaccinationsRaw` INT,
    `dailyVaccinations` INT,
    `totalVaccinationsPerHundred` INT,
    `peopleVaccinatedPerHundred` INT,
    `peopleFullyVaccinatedPerHundred` INT,
    `totalBoostersPerHundred` INT,
    `dailyVaccinationsPerMillion` INT,
    `dailyPeopleVaccinated` INT,
    `dailyPeopleVaccinatedPerHundred` INT
);
LOAD DATA LOCAL INFILE '/Users/rezhadrian/Works/dataAnalysisCaseStudies/covid/dataSources/vaccinations.csv'
INTO TABLE covid.vaccinations
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
    `country` VARCHAR(20),
    `location` VARCHAR(20),
    `continent` VARCHAR(20),
    `year` INT,
    `population` INT
);
LOAD DATA LOCAL INFILE '/Users/rezhadrian/Works/dataAnalysisCaseStudies/covid/dataSources/locations.csv'
INTO TABLE covid.countries
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;

DROP TABLE IF EXISTS `covid`.`testing`;
CREATE TABLE testing (
    `entity` VARCHAR(20),
    `isoCode` VARCHAR(3),
    `date` DATE,
    `source` VARCHAR(50),
    `label` VARCHAR(50),
    `notes` VARCHAR(50),
    `cumulativeTotal` INT,
    `dailyChange` INT,
    `cumulativeTotalPerThousand` FLOAT(5,3),
    `dailyChangePerThousand` FLOAT(5,4),
    `smoothedDailyChange` INT,
    `smoothedDailyChangePerThousand` FLOAT(4,3),
    `positiveRate` FLOAT(5,4),
    `testPerCase` FLOAT(2,1)
);
LOAD DATA LOCAL INFILE '/Users/rezhadrian/Works/dataAnalysisCaseStudies/covid/dataSources/covid-testing-all-observations.csv'
INTO TABLE covid.testing
    FIELDS TERMINATED BY ','
    ENCLOSED BY '"'
    LINES TERMINATED BY '\n'
    IGNORE 1 ROWS;