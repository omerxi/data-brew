# run with:	source config.sh

# set URL of server in variable SERVER, etc
source secret.sh

PERSON_DATA=$PWD/../drivers_output.ttl
SPARQL_COMMAND="arq --data=$PERSON_DATA"
SPARQL_ENDPOINT=http://localhost:9999/bigdata/namespace/omerxi1/sparql
SPARQL_COMMAND="rsparql --service=$SPARQL_ENDPOINT"

# for download:
SILKVERSION=silk-singlemachine-2.6.1-20150616
SILKZIP=$SILKVERSION.zip
# local:
SILK=$HOME/apps/silk-singlemachine-2.6.1

JENA=~/apps/apache-jena-2.13.0
# Jena cf https://registry.hub.docker.com/u/webratio/ant/dockerfile/
# cf https://github.com/inutano/bh14-docker-recipes/issues/1
PATH=$JENA/bin:$PATH

for f in $JENA/lib/*.jar
do
JENAPATH=$JENAPATH:$f
done

RESULTS=phone_results

