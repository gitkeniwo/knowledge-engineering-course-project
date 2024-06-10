MATCH n:Country
WHERE n.name = 'Netherlands'
RETURN


MATCH (n:Country {country_name: 'Austria'}) -[r]-> (i:`Educational Indicator`) -[r2]-> (ic:`Educational Indictor Category`),
(n:Country {country_name: 'Austria'}) -[r3]-> (e:`Employment Outcome`),
(n:Country {country_name: 'Austria'}) -[r4]-> (s:`Socioeconomic Status`)
return *

// Query on a single country
MATCH (n:Country {country_name: 'Austria'}) -[r]-> (i:`Educational Indicator`) -[r2]-> (ic:`Educational Indictor Category`),
(n:Country {country_name: 'Austria'}) -[r3]-> (e:`Employment Outcome`),
(n:Country {country_name: 'Austria'}) -[r4]-> (s:`Socioeconomic Status`)
return *

