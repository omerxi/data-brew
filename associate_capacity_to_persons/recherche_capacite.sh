
HTMLDIR_CAPACITE="$HOME/src/semantize/registre/www2.transports.equipement.gouv.fr/registres/voyageurs"

PREFPERSON="oxid"
echo "@prefix oxi: <http://omerxi.com/ontologies/core.owl.ttl#> ." >> capacite.ttl
echo "@prefix oxid: <http://omerxi.com/resource/> ." >> capacite.ttl

arq --data=$PERSON_DATA --query ../idlist_all.rq --results CSV > idlist.txt
echo idlist.txt populated;   wc idlist.txt

for ID in `cat idlist.txt`
do
  echo "For person $ID"
  # remove end of line:
  ID=${ID:0:`expr length $ID - 1`}
  if test $ID = "ID" ; then continue ; fi
  echo "For person <$ID>"

  echo "prefix oxi: <http://omerxi.com/ontologies/core.owl.ttl#>  CONSTRUCT { ?S ?P ?O . } WHERE { ?S oxi:id \"$ID\" ; ?P ?O . }" > /tmp/extractbyid.rq
  arq --data=$PERSON_DATA --query /tmp/extractbyid.rq --results TURTLE > /tmp/extractbyid.ttl
  SIREN=`grep "cob:siren" /tmp/extractbyid.ttl | sed 's/ *cob:siren *"//'  | sed 's/" *;//'`
  echo "SIREN <$SIREN>"
  if test -n "$SIREN" ; then
    REP=`grep -l "$SIREN" $HTMLDIR_CAPACITE/*htm | sed "s=$HTMLDIR_CAPACITE/==;s=\.htm=="`
    IDVTC=`grep "oxi:id" /tmp/extractbyid.ttl | sed 's/ *oxi:id *"//'  | sed 's/" *;//'`
    IDRDF=`grep "oxi:Ride-hailing-driver" /tmp/extractbyid.ttl | sed 's/ *a *oxi:Ride-hailing-driver *;//' `
# oxid:driver5137  a            oxi:Ride-hailing-driver ;
    if test -n "$REP" ; then
      echo "$IDRDF oxi:capacityDepartment \"$REP\" ." >> capacite.ttl
    fi
    echo "$IDRDF $IDVTC SIREN $SIREN Départment <$REP>"
  else
    echo pas de SIREN
  fi
  
done
