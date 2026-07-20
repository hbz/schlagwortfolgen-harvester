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

"Create a list of broken " + CATALOGUE + "Ids."
| print;

// On the basis of the SRU harvest we create a list of broken CATALOGUE ids in lobid resources.

SRU_HARVEST
| open-file
| as-lines
// Should work for all SRU with echoedSearchRetrieveRequest in their response.
| filter-strings("<(?:zs:|)searchRetrieveResponse" + SRU_QUERY_PATTERN +"</(?:zs:|)query>.+$",passmatches="true")
| match(pattern="<(?:zs:|)searchRetrieveResponse" + SRU_QUERY_PATTERN +"</(?:zs:|)query>.+$",replacement="$1")
| decode-csv(separator="\t")
| fix(FLUX_DIR + "failed.fix",*)
| batch-log(CATALOGUE + ": Total broken ids: ${totalRecords}",batchSize="1000")
| encode-csv(separator="\t",includeheader="true",noQuotes="true")
| write(FAILS_FILE)
;