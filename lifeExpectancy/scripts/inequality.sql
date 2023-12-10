SELECT 
  `gp`.`gdpPerCapita` AS `GDP Per Capita`,
  `gi`.`coefficient` AS `Gini Coefficient`
FROM `lifeExpectancy`.`gdpPerCapita` AS `gp` 
  JOIN `lifeExpectancy`.`giniIndex` AS `gi` 
    ON `gp`.`entity` = `gi`.`entity`AND `gp`.`year` = `gi`.`year`
ORDER BY `gp`.`gdpPerCapita`;