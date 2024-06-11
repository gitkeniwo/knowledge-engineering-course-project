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

// Query Countries that connect to a Socioeconomic Status which has property "socioeconomic_class="High(core)"
MATCH (n:Country) -[r]-> (s:`Socioeconomic Status`),
WHERE s.socioeconomic_class = 'High(core)'
RETURN n

// Query Countries that connect to a Socioeconomic Status which has property "socioeconomic_class="Middle(semi-per)",
// their employment outcomes and educational indicators that is an istance of "Gender Equality"
MATCH (n:Country) -[r]-> (s:`Socioeconomic Status`),(n:Country) -[r2]-> (e:`Employment Outcome`),
(n:Country) -[r3]-> (i:`Educational Indicator`) -[r4]-> (ic:`Educational Indicator Category` {category: "category: Gender Equality"})
WHERE s.socioeconomic_class = 'High(core)' RETURN n, e, i, ic

// Query Countries that connect to a Socioeconomic Status 
// which has property "socioeconomic_class="High(core)", 
// and add new relation "Similar Socioeconomic" between these countries 
// relation has property "socioeconomic_class" with value: "high(core)"
// without creating duplicate relations and bidirectional relations
MATCH (n:Country) -[r]-> (s:`Socioeconomic Status`)
WHERE s.socioeconomic_class = 'High(core)'
WITH n
MATCH (n2:Country) -[r2]-> (s2:`Socioeconomic Status`)
WHERE s2.socioeconomic_class = 'High(core)'
AND n <> n2
MERGE (n)-[r3:Similar_Socioeconomic {socioeconomic_class: 'high(core)'}]-(n2)

// Delete all relations beween countries
MATCH (n:Country) -[r]-> (m:Country)
DELETE r

// Match all countries that h