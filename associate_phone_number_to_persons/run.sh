PERSON_DATA=../drivers_output.ttl
ln -s $PERSON_DATA persons.ttl

arq --data=$PERSON_DATA --query idlist.rq --results CSV > idlist.txt
for ID in `cat idlist.txt`
do
  echo "For person $ID"
  # replace string <ID> in person_to_phone_query.rq
  sed -e "1,\$s/<ID>/\"${ID}\"/" person_to_phone_query.param.rq > person_to_phone_query.rq
  arq --data=$PERSON_DATA --query person_to_phone_query.rq > /tmp/phone_query.ttl
  turtle --output=JSON-LD /tmp/phone_query.ttl >  /tmp/phone_query.json
  nodejs ../../semantize/fetch/vtc/phones/index.js `cat /tmp/phone_query.json`
  # turn /tmp/output.json phone results into JSON-LD : add context.frag.json between }]
  JSON_CONTEXT=`cat context.frag.json`
  sed -e "/{/s={={ $JSON_CONTEXT ,=" /tmp/output.json > /tmp/output2.json

  # TODO launch Silk ; exploit Silk result to add phone number to person RDF data.
done

# http://json-ld.org/spec/ED/json-ld-syntax/20120522/#named-graphs

