-- Active: 1701138149306@@127.0.0.1@3306@lifeExpectancy
SELECT 
  `le`.`entity`, `le`.`year`, `le`.`expectancy` AS `Life Expectancy`,
  `gp`.`gdpPerCapita` AS `GDP Per Capita`,
  `br`.`birthRate` AS `Crude Birth Rate`,
  `li`.`mortalityRate` AS `Infant Mortality`,
  `lc`.`mortalityRate` AS `Child Mortality`,
  `ly`.`mortalityRate` AS `Youth Mortality`,
  `ln`.`mortalityRate` AS `Neonatal Mortality`
FROM `lifeExpectancy`.`lifeExpectancy` AS `le`
  JOIN `lifeExpectancy`.`gdpPerCapita` AS `gp` 
    ON `le`.`entity` = `gp`.`entity`AND `le`.`year` = `gp`.`year`
  JOIN `lifeExpectancy`.`crudeBirthRate` AS `br`
    ON `le`.`entity` = `br`.`entity`AND `le`.`year` = `br`.`year`
  JOIN `lifeExpectancy`.`infant` AS `li`
    ON `le`.`entity` = `li`.`entity`AND `le`.`year` = `li`.`year`
  JOIN `lifeExpectancy`.`child` AS `lc`
    ON `le`.`entity` = `lc`.`entity`AND `le`.`year` = `lc`.`year`
  JOIN `lifeExpectancy`.`youth` AS `ly`
    ON `le`.`entity` = `ly`.`entity`AND `le`.`year` = `ly`.`year`
  JOIN `lifeExpectancy`.`neonatal` AS `ln`
    ON `le`.`entity` = `ln`.`entity`AND `le`.`year` = `ln`.`year`
ORDER BY `le`.`expectancy`;
