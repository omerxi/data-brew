TTL=$PERSON_DATA

sort associate_phone_number_to_persons/drivers-phones.nt | uniq > /tmp/drivers-phones.nt
cp --force /tmp/drivers-phones.nt drivers-phones.nt

echo Creating CSV drivers_output.csv
arq --data $TTL \
  --data associate_phone_number_to_persons/drivers-phones.nt \
  --data associate_capacity_to_persons/capacite.ttl \
  --query drivers.rq --results CSV > drivers_output.csv

echo Creating JSON-LD drivers_output.jsonld
java -cp $JENAPATH riotcmd.riot --output=json-ld $TTL \
  associate_phone_number_to_persons/drivers-phones.nt \
  associate_capacity_to_persons/capacite.ttl \
  > drivers_output.jsonld

echo Creating RDF/XML drivers_output.rdf
cat $TTL \
  associate_phone_number_to_persons/drivers-phones.nt \
  associate_capacity_to_persons/capacite.ttl \
  > /tmp/TTL
rapper -i turtle -o rdfxml /tmp/TTL \
  > drivers_output.rdf
rapper -i turtle -o turtle /tmp/TTL \
  > drivers_output_all.ttl
