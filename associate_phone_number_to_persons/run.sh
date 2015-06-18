arq --data=../drivers_output.ttl --query idlist.rq --results CSV > idlist.txt
for ID in `cat idlist.txt`
do
  echo "For person $ID"
  # replace string <ID> in person_to_phone_query.rq
  sed -e "1,\$s/<ID>/\"${ID}\"/" person_to_phone_query.param.rq > person_to_phone_query.rq
  arq --data=../drivers_output.ttl --query person_to_phone_query.rq > /tmp/phone_query.ttl
  turtle --output=JSON-LD /tmp/phone_query.ttl >  /tmp/phone_query.json
  nodejs ../../semantize/fetch/vtc/phones/index.js `cat /tmp/phone_query.json`
  # TODO turn /tmp/output.json phone results into JSON-LD ; launch Silk ; exploit Silk result to add phone number to person RDF data.
done

