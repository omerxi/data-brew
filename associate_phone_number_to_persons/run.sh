# TODO download & install Apache Jena, Silk
PATH=~/apps/apache-jena-2.13.0/bin:$PATH

arq --data=../drivers_output.ttl --query idlist.rq --results CSV > idlist.txt
for ID in `cat idlist.txt`
do
  echo "For person $ID"
  # TODO replace string <ID> in person_to_phone_query.rq
  arq --data=../drivers_output.ttl --query person_to_phone_query.rq > /tmp/phone_query.ttl
  turtle --output=JSON-LD /tmp/phone_query.ttl >  /tmp/phone_query.json
  nodejs ../../semantize/fetch/vtc/phones/index.js `cat /tmp/phone_query.json` > /tmp/phone_result.json
  # TODO launch Silk
done

