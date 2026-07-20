default VERSION="prod/";
default CATALOGUE="dnb";
default SYSTEM_ISIL="DE-101";
default AUTH ="";
default SRU_HARVEST=FLUX_DIR + VERSION + "/harvest/" + CATALOGUE + "-sru-records.xml.gz";
default OUTFILE=FLUX_DIR + VERSION + "swk-" + CATALOGUE + ".xml";
default LOBID_HARVEST = FLUX_DIR + VERSION +"/harvest/"  + CATALOGUE + "-lobid-records-no-swk.jsonl.gz";
default LOOKUP_FILE = FLUX_DIR + VERSION + "/maps/" + "almaMmsId2" + CATALOGUE + "Id.tsv";
default SRU_LINK_PART_1 = "https://services.dnb.de/sru/dnb?version=1.1&operation=searchRetrieve&query=dnb.idn=";
default SRU_LINK_PART_2 = "&recordSchema=MARC21-xml";
default SRU_QUERY_PATTERN = ".*dnb.idn=(.+)";
default SLEEP_TIME = "500";
default FAILS_FILE = FLUX_DIR + VERSION + CATALOGUE + "failed.tsv";


"Start harvesting lobid for " + CATALOGUE + " records without Schlagwortfolgen"
| print;

// We download all reacords that have CATALOGUE ids but no Schlagwortfolgen from lobid resources.

"https://lobid.org/resources/search?q=_exists_%3A" + CATALOGUE + "Id+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId&format=jsonl"
| open-http(header="User-Agent: hbz/" + CATALOGUE + "-schlagwortfolgen-harvester\\nAccept-Encoding: gzip" )
| as-lines
| object-batch-log(CATALOGUE + ": lobid records: ${totalRecords}", batchSize="1000")
| write(LOBID_HARVEST, compression="gzip")
;

"Harvesting lobid finished. Start creating dnbId2" + CATALOGUE + "Id map."
| print;

// On the basis of the CATALOGUE id in the lobid resources data we create links to harvest the CATALOGUEs SRU.

LOBID_HARVEST
| open-file
| as-lines
| decode-json
| fix("retain('almaMmsId','$[CATALOGUE]Id')",*)
| encode-csv(noQuotes="true", separator="\t")
| write(LOOKUP_FILE)
;