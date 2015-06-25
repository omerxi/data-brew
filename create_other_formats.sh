TTL=associate_phone_number_to_persons/$PERSON_DATA

sort associate_phone_number_to_persons/drivers-phones.nt | uniq > /tmp/drivers-phones.nt
cp --force /tmp/drivers-phones.nt drivers-phones.nt

arq --data $TTL \
  --data associate_phone_number_to_persons/drivers-phones.nt \
  --query drivers.rq --results CSV > drivers_output.csv
java -cp $JENAPATH riotcmd.riot --output=json-ld $TTL \
  associate_phone_number_to_persons/drivers-phones.nt \
  > drivers_output.jsonld
cat $TTL \
  associate_phone_number_to_persons/drivers-phones.nt \
  > /tmp/$TTL
rapper -i turtle -o rdfxml /tmp/$TTL \
  > drivers_output.rdf
