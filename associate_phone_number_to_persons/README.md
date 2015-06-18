## The files in run.sh

/tmp/phone\_query.ttl

    [ oxi:timeout  "20000" ;
      oxi:url      "http://www.my-phone-supplier.com" ;
      oxi:where    "01360" ;
      oxi:who      " VIA AAAA "
    ] .

/tmp/phone\_query.json : the trick is that the JSON-LD is also a normal JSON with the "@context" added, but the "@context" can be ignored by non semantic apps.

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


    node index.js '{"url": "http://www.directory.com/XXXX", "who": "Patrick XXXX", "where": "01600 Trévoux"}'

By default, les results are writen in : /tmp/output.json :

    [{
      "name": "XXXX Patrick",
      "address": "9999 Rue YYYY 01600 TREVOUX",
      "phones": ["04 ZZ ZZ ZZ ZZ", "04 ZZ ZZ ZZ ZZ",]
    }]

This must be supplied with a JSON-LD @context :

     "@context" : {
        "name": "http://omerxi.com/ontologies/core.owl.ttl#name",
        "address": "http://omerxi.com/ontologies/core.owl.ttl#address",
        "phones": "http://omerxi.com/ontologies/core.owl.ttl#address",

        "foaf" : "http://xmlns.com/foaf/0.1/",
        "vcard" : "http://www.w3.org/2006/vcard/ns#",
        "oxi" : "http://omerxi.com/ontologies/core.owl.ttl#"
      }
    }


