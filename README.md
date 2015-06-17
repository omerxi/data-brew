# data-brew

Mix our data (already RDFized with companion project [semantize](../semantize) ) with Linked Open Data, SPARQL queries and algorithms

## Starting a SPARQL server (Fuseki)

You can use [Fuseki](http://jena.apache.org/documentation/serving_data/) web manager.
Download [Apache Jena Fuseki](https://jena.apache.org/download/) .

Edit the script `fuseki-server` and change like this:
    JVM_ARGS=${JVM_ARGS:--Xmx3200M}

Start the server:
    ./fuseki-server

See the [Apache Jena Fuseki page](https://jena.apache.org/documentation/fuseki2/index.html)

Within the Fuseki installed directory $FUSEKI, the data are in run/ , and within run/, with the default configuration, the databases are in databases/ .

Knowing where the data are, one can use another Jena TDB based application, [semantic\_forms](https://github.com/jmvanel/semantic_forms/blob/master/scala/forms_play/README.md) : in [semantic\_forms] directory, type:
    ln -s $FUSEKI/run/databases/myDatabaseName TDB

## Starting a SPARQL server (Blazegraph)
See [Deploying Nano Sparql Server](http://wiki.blazegraph.com/wiki/index.php/NanoSparqlServer#Deploying_NanoSparqlServer)

## Loading RDF content

Just basic dbPedia data for a start;
See [Preloading RDF content](https://github.com/pixelhumain/cityData/tree/master/cityData_server_scala_jena#preloading-rdf-content)

See [Setting up a DBPedia SPARQL mirror with Jena](http://svn.code.sf.net/p/eulergui/code/trunk/eulergui/html/server-sparql-dbpedia.html)

Then each data set should be added in a separate named graph, to be able to easily update 
by replacing the corresponding named graph.

Recommended is :
- put dbpedia in named graph "dbpedia"
- put other data in named graph with a name easy to understand like "persons" or "drivers"


## Basic SPARQL queries

Find all items with first name, last name, and postal code "75015", and print first Name, last name, and phone if present.

    prefix foaf: <http://xmlns.com/foaf/0.1/>
    prefix cob:  <http://cobusiness.fr/ontologies/barter.owl.n3#>
    prefix oxi:  <http://omerxi.co/ontologies/core.owl.ttl#>
    prefix dc: <http://purl.org/dc/elements/1.1/>
    prefix vcard: <http://www.w3.org/2006/vcard/ns#>
  
     SELECT ?FIRSTNAME ?NAME ?TEL
     WHERE {
       GRAPH ?G {
         ?X vcard:postal-code "75015" ;
           foaf:lastName ?NAME ;
           foaf:firstName ?FIRSTNAME
           OPTIONAL { ?X foaf:phone ?TEL }
      }
    } ORDER BY ?TEL


List all items with id, first name, last name, or company name :
[names.rq](names.rq)

The same with also manager and representative:
[names2.rq](names2.rq)

Select persons by first name, ignoring case, allowing "-" in the middle or something else
[first-name.rq](first-name.rq)


To run such a query, $FUSEKI being the Fuseki distribution directory, type:
    $FUSEKI/bin/s-query --service http://localhost:3030/omerxi/query --output=text --query names.rq

There are other SPARQL clients, like EulerGUI.


# Using SilK for linking person and telephone directory

Background: [ Silk - The Linked Data Integration Framework ](http://silk-framework.com/)
is useful to create links between URI resources by looking at their textual values.

Its source is here :
[https://github.com/silk-framework/silk](https://github.com/silk-framework/silk)
.

To run the Silk server from sources:

You can download the zip from github,
[https://github.com/silk-framework/silk/releases](https://github.com/silk-framework/silk/releases)

then run SBT ( http://www.scala-sbt.org/ )
then inside sbt :

    project workbench
    run

Then one must either use the web UI interface,
and / or edit an XML file, like :
[linkSpec.xml](https://github.com/omerxi/data-brew/blob/master/silk/foaf_name.vcard_street-adress/linkSpec.xml)


In linkSpec.xml there is a reference to the 2 input files : "chauffeurs" and "phones" :
 
```xml
   <SourceDataset dataSource="chauffeurs" var="a">
   ...
   <TargetDataset dataSource="phones" var="b">
```

These 2 files should be in directory :
$HOME/.silk/workspace/$PROJECT/resources

The file  linkSpec.xml should be in directory :
    $HOME/.silk/workspace/$PROJECT/linking/foaf_name.vcard_street-adress

Running Silk in command line:
inside sbt :
    project workbench
    runMain de.fuberlin.wiwiss.silk.Silk -DconfigFile=<Silk-LSL file> [-DlinkSpec=<Interlink ID>] [-Dthreads=<threads>]  [-DlogQueries=(true/false)] [-Dreload=(true/false)]


or with a jar, see:
[Silk Single Machine](https://www.assembla.com/spaces/silk/wiki/Silk_Single_Machine)



