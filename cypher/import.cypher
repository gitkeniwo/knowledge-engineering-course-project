:param {
  // Define the file path root and the individual file names required for loading.
  // https://neo4j.com/docs/operations-manual/current/configuration/file-locations/
  file_path_root: 'file:///', // Change this to the folder your script can access the files at.
  file_0: 'country.csv',
  file_1: 'employment.csv',
  file_2: 'educational_index.csv',
  file_3: 'socioecono.csv',
  file_4: 'categories.csv',
  file_5: 'education_country.csv'
};

// CONSTRAINT creation
// -------------------
//
// Create node uniqueness constraints, ensuring no duplicates for the given node label and ID property exist in the database. This also ensures no duplicates are introduced in future.
//
// NOTE: The following constraint creation syntax is generated based on the current connected database version 5.20-aura.
CREATE CONSTRAINT `country_code_Country_uniq` IF NOT EXISTS
FOR (n: `Country`)
REQUIRE (n.`country_code`) IS UNIQUE;
CREATE CONSTRAINT `indicator_code_Educational_Indicator_uniq` IF NOT EXISTS
FOR (n: `Educational Indicator`)
REQUIRE (n.`indicator_code`) IS UNIQUE;
CREATE CONSTRAINT `category_Educational_Indictor Category_uniq` IF NOT EXISTS
FOR (n: `Educational Indictor Category`)
REQUIRE (n.`category`) IS UNIQUE;
CREATE CONSTRAINT `employment_id_Employment_Outcome_uniq` IF NOT EXISTS
FOR (n: `Employment Outcome`)
REQUIRE (n.`employment_id`) IS UNIQUE;
CREATE CONSTRAINT `socioeconomic_id_Socioeconomic_Status_uniq` IF NOT EXISTS
FOR (n: `Socioeconomic Status`)
REQUIRE (n.`socioeconomic_id`) IS UNIQUE;

:param {
  idsToSkip: []
};

// NODE load
// ---------
//
// Load nodes in batches, one node label at a time. Nodes will be created using a MERGE statement to ensure a node with the same label and ID property remains unique. Pre-existing nodes found by a MERGE statement will have their other properties set to the latest values encountered in a load file.
//
// NOTE: Any nodes with IDs in the 'idsToSkip' list parameter will not be loaded.
LOAD CSV WITH HEADERS FROM ($file_path_root + $file_0) AS row
WITH row
WHERE NOT row.`country_code` IN $idsToSkip AND NOT row.`country_code` IS NULL
CALL {
  WITH row
  MERGE (n: `Country` { `country_code`: row.`country_code` })
  SET n.`country_code` = row.`country_code`
  SET n.`country_name` = row.`country_name`
  SET n.`country_id` = row.`country_id`
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_2) AS row
WITH row
WHERE NOT row.`indicator_code` IN $idsToSkip AND NOT row.`indicator_code` IS NULL
CALL {
  WITH row
  MERGE (n: `Educational Indicator` { `indicator_code`: row.`indicator_code` })
  SET n.`indicator_code` = row.`indicator_code`
  SET n.`indicator_name` = row.`indicator_name`
  SET n.`value` = toFloat(trim(row.`value`))
  SET n.`educational_index_id` = row.`educational_index_id`
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_4) AS row
WITH row
WHERE NOT row.`category` IN $idsToSkip AND NOT row.`category` IS NULL
CALL {
  WITH row
  MERGE (n: `Educational Indictor Category` { `category`: row.`category` })
  SET n.`category` = row.`category`
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_1) AS row
WITH row
WHERE NOT row.`employment_id` IN $idsToSkip AND NOT row.`employment_id` IS NULL
CALL {
  WITH row
  MERGE (n: `Employment Outcome` { `employment_id`: row.`employment_id` })
  SET n.`employment_id` = row.`employment_id`
  SET n.`indicator_name` = row.`indicator_name`
  SET n.`Indicator Code` = row.`Indicator Code`
  SET n.`unemployment_rate` = toFloat(trim(row.`unemployment_rate`))
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_3) AS row
WITH row
WHERE NOT row.`socioeconomic_id` IN $idsToSkip AND NOT row.`socioeconomic_id` IS NULL
CALL {
  WITH row
  MERGE (n: `Socioeconomic Status` { `socioeconomic_id`: row.`socioeconomic_id` })
  SET n.`socioeconomic_id` = row.`socioeconomic_id`
  SET n.`unid` = toInteger(trim(row.`unid`))
  SET n.`year` = toInteger(trim(row.`year`))
  SET n.`ses` = toFloat(trim(row.`ses`))
  SET n.`socioeconomic_class` = row.`socioeconomic_class`
  SET n.`gdppc` = toFloat(trim(row.`gdppc`))
  SET n.`yrseduc` = toFloat(trim(row.`yrseduc`))
  SET n.`region5` = row.`region5`
  SET n.`regionUN` = row.`regionUN`
} IN TRANSACTIONS OF 10000 ROWS;


// RELATIONSHIP load
// -----------------
//
// Load relationships in batches, one relationship type at a time. Relationships are created using a MERGE statement, meaning only one relationship of a given type will ever be created between a pair of nodes.
LOAD CSV WITH HEADERS FROM ($file_path_root + $file_5) AS row
WITH row 
CALL {
  WITH row
  MATCH (source: `Country` { `country_code`: row.`country_code` })
  MATCH (target: `Educational Indicator` { `indicator_code`: row.`indicator_code` })
  MERGE (source)-[r: `Has Educational Indicator`]->(target)
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_4) AS row
WITH row 
CALL {
  WITH row
  MATCH (source: `Educational Indicator` { `indicator_code`: row.`indicator_code` })
  MATCH (target: `Educational Indictor Category` { `category`: row.`category` })
  MERGE (source)-[r: `Is Instance Of`]->(target)
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_1) AS row
WITH row 
CALL {
  WITH row
  MATCH (source: `Country` { `country_code`: row.`country_code` })
  MATCH (target: `Employment Outcome` { `employment_id`: row.`employment_id` })
  MERGE (source)-[r: `Has Employment Rate`]->(target)
} IN TRANSACTIONS OF 10000 ROWS;

LOAD CSV WITH HEADERS FROM ($file_path_root + $file_3) AS row
WITH row 
CALL {
  WITH row
  MATCH (source: `Country` { `country_code`: row.`country_code` })
  MATCH (target: `Socioeconomic Status` { `socioeconomic_id`: row.`socioeconomic_id` })
  MERGE (source)-[r: `Has Socioeconomic Status`]->(target)
} IN TRANSACTIONS OF 10000 ROWS;
