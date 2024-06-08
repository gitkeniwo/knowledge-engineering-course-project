import neo4j 

def close_driver(driver):
    """ Close the driver """
    driver.close()


def create_node(tx, label, properties):
    cypher_query = f"CREATE (n:{label} {{name: $name, age: $age}})"
    tx.run(cypher_query, properties)

def create_relationship(tx, label1, name1, label2, name2, relationship_type):
    cypher_query = (
        f"MATCH (a:{label1} {{name: $name1}}), (b:{label2} {{name: $name2}}) "
        f"CREATE (a)-[r:{relationship_type}]->(b)"
    )
    tx.run(cypher_query, name1=name1, name2=name2)
