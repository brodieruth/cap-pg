# cap-pg

### Step 1:

Create a new cap project with command `cds init`

### Step 2:

Add Schema.cds undr db and Service.cds under srv folder respectively

### Step 3:

Add some mock data as csv format under db/data folder. The file format should be <namespace_entity.csv>

### Step 4:

Test the service using `cds watch`

### Step 5:

Add user authorization to Service.cds file

### Step 6:

Add local test user to .cdsrc.json

### Step 7:

Add docker-compose.yml under cap-pg -> This will create a docker image. The following command `docker compose up` will create the container within which Postgresql will run as a db server

### Step 8:

Open http://localhost:8080 and login to Postgresql Server and create a database 'Student'

### Step 9:

Add db deployment configuration under package.json

A. `cds add postgres` -> will add new cap service as dependency

```josn
"@cap-js/postgres": "^1"'
```

Execute `npm install`

B. Add local database information in Package.json or .cdsrc.json

C. `cds deploy` which will create underlined views and tables in PG.

### Step 10:

Make the app ready for cf deployment.

A. Add passport -> `npm add passport`

B. Add xssecurity - > `npm add @sap./xssec`

C. Add xsuaa -> `cds add xsuaa` , will create xs-security.json

### Step 11:
Build the app -> 
`cds build`

### Step 12:
Add MTA to the project -> `cds add mta`

### Step 13:
Create two files under cap-app
1. pg-package.json
2. pg-build.sh


### Step 14:
A few corrections are required for mta.yaml file.

1. As the app I am planning to deploy in BTP trial (AWS). So the service plan should be 'Trial'.
2. rename the postgres instance name to 'cpapp-postgres' - done becuase I already create Postgresql instance in BTP with this name.
3. Under mta.yaml -> Builder section, Add pg-build.sh
4. Finally run `mbt build` to create mtar file

### Step 15:

Deploy previously generated mtar file into cloud foundry
1. `cf login`
2. `cf deploy mta_archives/cap-app_1.0.0.mtar`

Backend service will be successfuly uploaded to BTP

### Step 16:

Add role for user in BTP

A. Go to Trial Sub Account -> Security -> Role Collection -> Create new role collection

B. Edit the role collection and add the required roles as mainatined under xs-security.json (StudentAdmin & StudentViewer)

C.Add user ID and finally save

### Step 17:

Test Service ==>
using POSTMAN with oAuth2.0 authentication 

### Step 18:
Enable SSH to access BTP DB from 

1. Execute command `cf enable-ssh cap-app-srv`
2. Restart the App `cf restart cap-app-srv`
3. Create a service key for Postgresql instance - `cf create-service-key cap-app-postgres srv_key`
4. Display service key details - `cf service-key cap-app-postgres srv_key`
5. Create the SSH Tunnel - `cf ssh -L 63306:<postgress-instance-host-name>:<pg-instance-port-name> <app-name>`
6. You need to install Postgresql cli client - `choco insall postgres14`
7. Finally access the database service locally from command prompt - `psql -d <dbname> -U <user name> -p 63306 -h localhost`

### Step 19:

psql commands to check database entries

* psql number of database available 
> select datname from pg_catalog.pg_database; 

* to switch to table
> \c 'db name' 

* To check available tables
>\dt; 

* fetch records

> select * from 'table';

* insert new record

> insert into 'table' (field1, field2, field3) values ('val1', 'val2', 'val3');
