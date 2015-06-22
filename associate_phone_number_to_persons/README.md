## The files manipulated by run.sh

/tmp/phone\_query.ttl (example) is gotten from the persons Turtle data by a SPARQL query :

    [ oxi:timeout  "20000" ;
      oxi:url      "http://www.my-phone-supplier.com" ;
      oxi:where    "01360" ;
      oxi:who      " VIA AAAA "
    ] .

/tmp/phone\_query.json (example) is sent to the phone directory tool .
The trick is that the JSON-LD is also a normal JSON with the "@context" added, but the "@context" can be ignored by non semantic apps.

    {
      "@id" : "_:b0",
      "timeout" : "20000",
      "url" : "http://www.my-phone-supplier.com",
      "where" : "01360",
      "who" : " VIA CUNY ",
      "@context" : {
        "who" : "http://omerxi.com/ontologies/core.owl.ttl#who",
        "where" : "http://omerxi.com/ontologies/core.owl.ttl#where",
        "url" : "http://omerxi.com/ontologies/core.owl.ttl#url",
        "timeout" : "http://omerxi.com/ontologies/core.owl.ttl#timeout",
        "afn" : "http://jena.hpl.hp.com/ARQ/function#",
        "dc" : "http://purl.org/dc/elements/1.1/",
        "foaf" : "http://xmlns.com/foaf/0.1/",
        "cob" : "http://cobusiness.fr/ontologies/barter.owl.n3#",
        "fn" : "http://www.w3.org/2005/xpath-functions#",
        "vcard" : "http://www.w3.org/2006/vcard/ns#",
        "oxi" : "http://omerxi.com/ontologies/core.owl.ttl#"
      }
    }

The command sent to the to the phone directory tool:

    node index.js '{"url": "http://www.directory.com/XXXX", "who": "Patrick XXXX", "where": "01600 Trévoux"}'


By default, the results are writen in : /tmp/output.json :

    [{
      "name": "XXXX Patrick",
      "address": "9999 Rue YYYY 01600 TREVOUX",
      "phones": ["04 ZZ ZZ ZZ ZZ", "05 ZZ ZZ ZZ ZZ" ]
    },
    {
      "name": "XXXX Charles",
      "address": "9999 Rue TTTT 07777 Angers",
      "phones": ["04 ZZ ZZ ZZ ZZ", "05 ZZ ZZ ZZ ZZ" ]
    }]

The JSON above must be supplied with a JSON-LD @context :

     "@context" : {
        "name": "http://omerxi.com/ontologies/core.owl.ttl#name",
        "address": "http://omerxi.com/ontologies/core.owl.ttl#address",
        "phones": "http://omerxi.com/ontologies/core.owl.ttl#phones",

        "foaf" : "http://xmlns.com/foaf/0.1/",
        "vcard" : "http://www.w3.org/2006/vcard/ns#",
        "oxi" : "http://omerxi.com/ontologies/core.owl.ttl#"
      }

giving :

    [{
      "name": "XXXX Patrick",
      "address": "9999 Rue YYYY 01600 TREVOUX",
      "phones": ["04 ZZ ZZ ZZ ZZ", "05 ZZ ZZ ZZ ZZ"],
     "@context" : { 
        "name": "http://omerxi.com/ontologies/core.owl.ttl#name", 
        "address": "http://omerxi.com/ontologies/core.owl.ttl#address", 
        "phones": "http://omerxi.com/ontologies/core.owl.ttl#phones", 

        "foaf" : "http://xmlns.com/foaf/0.1/", 
        "vcard" : "http://www.w3.org/2006/vcard/ns#", 
        "oxi" : "http://omerxi.com/ontologies/core.owl.ttl#" 
    }
      }]

## Links

https://www.assembla.com/wiki/show/silk/Silk_Single_Machine

