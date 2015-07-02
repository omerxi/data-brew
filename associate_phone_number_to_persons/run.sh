
SPARQL_COMMAND="arq --data=$PERSON_DATA"

# PENDING bug in BlazeGraph : https://jira.blazegraph.com/browse/BLZG-1356
# source ../start_bigdata.sh


$SPARQL_COMMAND --query idlist.rq --results CSV > idlist.txt
echo idlist.txt populated;   wc idlist.txt
mkdir $RESULTS
PHONE_JSON=/tmp/output.json

NUM=0
for ID in `cat idlist.txt`	# "EVTC001100001" # "EVTC075140343"
do
  NUM=`expr $NUM + 1`
  echo "For person $ID"
  # remove end of line:
  ID=${ID:0:`expr length $ID - 1`}
  if test $ID = "ID" ; then continue ; fi
  echo "For person <$ID> , n° $NUM - `date`"
  RESULT=$RESULTS/$ID.ttl
  RESULTJSON=$RESULTS/$ID.json
  if test -f $RESULTJSON ; then echo $ID already done; continue; fi

  # replace string <ID> in person_to_phone_query.rq
  sed -e "/<ID>/s/<ID>/\"${ID}\"/;/<SERVER>/s=<SERVER>=\"${SERVER}\"=" person_to_phone_query.param.rq > person_to_phone_query.rq
  $SPARQL_COMMAND --query person_to_phone_query.rq > /tmp/phone_query.ttl
  turtle --output=JSON-LD /tmp/phone_query.ttl >  /tmp/phone_query.json
  echo before index.js
  PHONE_QUERY=`cat /tmp/phone_query.json | tr '\n' ' ' | sed 's/\\\n//g' `
  echo PHONE_QUERY "$PHONE_QUERY"
  rm -f $PHONE_JSON
  nodejs ../../semantize/fetch/vtc/phones/index.js "$PHONE_QUERY"
  RESULT_LENGTH=`wc -c < $PHONE_JSON`
  if test $RESULT_LENGTH -lt 10 ; then continue ; fi
  cp $PHONE_JSON $RESULTJSON

  # launch Silk
  java -cp $JENAPATH riotcmd.riot --syntax=JSON-LD --output=turtle $PHONE_JSON > /tmp/output.ttl
  if test -s  /tmp/output.ttl ; then cp /tmp/output.ttl $RESULT ; fi
  echo "prefix oxi: <http://omerxi.com/ontologies/core.owl.ttl#>  CONSTRUCT { ?S ?P ?O . } WHERE { ?S oxi:id \"$ID\" ; ?P ?O . }" > /tmp/extractbyid.rq
  $SPARQL_COMMAND --query /tmp/extractbyid.rq --results TURTLE > /tmp/extractbyid.ttl
  java -jar -DconfigFile=../silk/foaf_name.vcard_street-adress/configFile.xml -DlogQueries=false $SILK/silk.jar
  head ../silk/foaf_name.vcard_street-adress/accepted_links.nt
  # exploit Silk result to add phone number to person RDF data.
  arq --data=/tmp/output.ttl --data=../silk/foaf_name.vcard_street-adress/accepted_links.nt \
    --query transfer_phones.rq --results N-TRIPLES >> drivers-phones.nt
  
done

