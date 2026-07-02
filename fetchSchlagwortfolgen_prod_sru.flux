default VERSION="prod/";
default CATALOGUE="dnb";
default SYSTEM_ISIL="DE-101";
default AUTH ="";
default SRU_HARVEST=FLUX_DIR + VERSION + CATALOGUE + "_sru_records.xml.gz";
default OUTFILE=FLUX_DIR + VERSION + CATALOGUE + "Subjects.xml.gz";
default LOBID_HARVEST = FLUX_DIR + VERSION + CATALOGUE + "LobidWithoutSchlagwortfolge.jsonl.gz";
default LOOKUP_FILE = FLUX_DIR + VERSION + "almaMmsId2" + CATALOGUE + "Id.tsv";
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
| object-batch-log("lobid records: ${totalRecords}", batchSize="100")
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

"Map finished. Start harvesting " + CATALOGUE + " sru."
| print;

// On the basis of the CATALOGUE id in the lobid resources data we create links to harvest the CATALOGUEs SRU.

LOBID_HARVEST
| open-file
| as-lines
| decode-json
| fix("retain('$[CATALOGUE]Id')",*)
| literal-to-object
| template(SRU_LINK_PART_1 + "${o}" + SRU_LINK_PART_2)
| catch-object-exception
| open-http(header="User-Agent: hbz/" + CATALOGUE + "-schlagwortfolgen-harvester\nAuthorization: Basic " + AUTH, accept="application/xml")
| sleep(sleepTime=SLEEP_TIME, timeUnit="MILLISECONDS")
| as-records
// The following two steps create a single xml file from the multiple incoming sru requests, saved into a harvest tag
| match(pattern="<\\?xml version=.*?>", replacement="")
| object-batch-log("SRU Queries: ${totalRecords}", batchSize="100")
| write(SRU_HARVEST, header="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<harvest>", footer="</harvest>", compression="gzip")
;


"SRU Harvest finished. Start harvesting " + CATALOGUE + " subject data."
| print;

// On the basis of the SRU harvest we extract the Schlagwortfolgen and create new minimal MARC XML records for importing them into ALMA.

SRU_HARVEST
| open-file
| as-records
| match(pattern="ERROR: (?:.|\n)*?</body></html>",replacement="")
| read-string
| decode-xml
| handle-marcxml
| batch-log("Total SRU proper records: ${totalRecords}", batchSize="100")
| fix(FLUX_DIR + "subject.fix",*)
| batch-log("Harvested Records with Schlagwortfolgen: ${totalRecords}", batchSize="100")
| encode-marcxml
| write(OUTFILE, compression="gzip") // compression is better for big file
;

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
| batch-log("Total broken ids: ${totalRecords}",batchSize="100")
| encode-csv(separator="\t",includeheader="true",noQuotes="true")
| write(FAILS_FILE)
;