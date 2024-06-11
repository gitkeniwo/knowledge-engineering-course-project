# Knowledge Engineering

## Create a knowledge graph from relational dataset

Ti initiate your own [neo4j](https://neo4j.com/) server, you can either choose to create a free aura instance, or set up a neo4j server locally.

### Create a free-tier aura instance

Visit https://neo4j.com/cloud/platform/aura-graph-database/ and start a free instance.
After you register your instance, you may either work with it using neo4j web workspace or use the credentials to work with local clients and python drivers.

*Attention* Aura does not support CSV import by cypher scripts. However, it does offers a GUI import interface `https://workspace-preview.neo4j.io/workspace/import`, but you need to configure every field of the mapping each time when you import, so it could be unhandy at times.

### Set up a local neo4j server

For mac users, install neo4j with homebrew
```bash
$brew install neo4j
```

See the usage of `neo4j`. 
```ps
$neo4j --help
```

Start a your server with
```ps
$neo4j console
➜ neo4j console
Directories in use:
home:         /opt/homebrew/Cellar/neo4j/5.20.0/libexec
config:       /opt/homebrew/Cellar/neo4j/5.20.0/libexec/conf
logs:         /opt/homebrew/var/log/neo4j
plugins:      /opt/homebrew/Cellar/neo4j/5.20.0/libexec/plugins
import:       /opt/homebrew/Cellar/neo4j/5.20.0/libexec/import
data:         /opt/homebrew/var/neo4j/data
certificates: /opt/homebrew/Cellar/neo4j/5.20.0/libexec/certificates
licenses:     /opt/homebrew/Cellar/neo4j/5.20.0/libexec/licenses
run:          /opt/homebrew/Cellar/neo4j/5.20.0/libexec/run
Starting Neo4j.
2024-06-11 10:50:58.232+0000 INFO  Logging config in use: File '/opt/homebrew/Cellar/neo4j/5.20.0/libexec/conf/user-logs.xml'
2024-06-11 10:50:58.240+0000 INFO  Starting...
2024-06-11 10:50:58.791+0000 INFO  This instance is ServerId{dbfd79ad} (dbfd79ad-83cf-4993-8378-0968dc277caf)
2024-06-11 10:50:59.387+0000 INFO  ======== Neo4j 5.20.0 ========
2024-06-11 10:51:00.533+0000 INFO  Anonymous Usage Data is being sent to Neo4j, see https://neo4j.com/docs/usage_data/
2024-06-11 10:51:00.556+0000 INFO  Bolt enabled on localhost:7687.
2024-06-11 10:51:00.948+0000 INFO  HTTP enabled on localhost:7474.
2024-06-11 10:51:00.949+0000 INFO  Remote interface available at http://localhost:7474/
2024-06-11 10:51:00.950+0000 INFO  id: E12165B84B1D179932D4B042EB3788806E7407CCC76A922F198F42E4C31F59C0
2024-06-11 10:51:00.950+0000 INFO  name: system
2024-06-11 10:51:00.951+0000 INFO  creationDate: 2024-06-10T23:52:45.176Z
2024-06-11 10:51:00.951+0000 INFO  Started.
```
The server will listen on `localhost:7687` for neo4j [bolt](https://neo4j.com/docs/bolt/current/bolt/) request, which is also the port you should fill in when using neo4j python driver. Web console is enable on `localhost:7474` through HTTP.

Take note of where the `import` directory is located. This is the place to drop your CSV if you need to import CSV by cypher queries. See https://neo4j.com/docs/getting-started/data-import/csv-import/#import-load-csv 

The neo4j formula also comes with `cypher-shell` for executing commandline interface cypher queries.
```ps
❯ cypher-shell
username: neo4j
password:
Connected to Neo4j using Bolt protocol version 5.4 at neo4j://localhost:7687 as user neo4j.
Type :help for a list of available commands or :exit to exit the shell.
Note that Cypher queries must end with a semicolon.
neo4j@neo4j>
```

### Start neo4j docker container

Use official docker image https://hub.docker.com/_/neo4j 
Use together with dockerfile to create more advanced images, and docker-compose more complicated data pipelines with python.

### Use neo4j Desktop

Of course, you can directly download neo4j desktop to quickly start a graph DB service.
See https://neo4j.com/download/