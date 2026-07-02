default VERSION="test/";
default CATALOGUE="dnb";
default SYSTEM_ISIL="DE-101";
default SRU_HARVEST=FLUX_DIR + VERSION + CATALOGUE + "_sru_records.xml";
default OUTFILE=FLUX_DIR + VERSION + CATALOGUE + "Subjects.xml";
default LOBID_HARVEST = FLUX_DIR + VERSION + CATALOGUE + "Subjects.jsonl";
default LOOKUP_FILE = FLUX_DIR + VERSION + "almaMmsId2" + CATALOGUE + "Id.tsv";
default SRU_LINK_PART_1 = "https://services.dnb.de/sru/dnb?version=1.1&operation=searchRetrieve&query=dnb.idn=";
default SRU_LINK_PART_2 = "&recordSchema=MARC21-xml";
default SRU_QUERY_PATTERN = ".*dnb.idn=(.+)";
default TEST_LOBID_QUERY = "https://lobid.org/resources/search?q=_exists_%3AdnbId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gem%C3%BCse";
default FAILS_FILE = FLUX_DIR + VERSION + CATALOGUE + "failed.tsv";

// Outcommented to not harvest the data every time.

//"Start harvesting lobid for " + CATALOGUE + " records without Schlagwortfolgen"
//| print;
//
////// We download all reacords that have CATALOGUE ids but no Schlagwortfolgen from lobid resources.
//
//TEST_LOBID_QUERY + "&format=jsonl"
//| open-http(header="User-Agent: hbz/" + CATALOGUE + "-schlagwortfolgen-harvester" )
//| as-lines
//| write(LOBID_HARVEST)
//;

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

//// On the basis of the CATALOGUE id in the lobid resources data we create links to harvest the CATALOGUEs SRU.

//LOBID_HARVEST
//| open-file
//| as-lines
//| decode-json
//| fix("retain('$[CATALOGUE]Id')",*)
//| literal-to-object
//| template(SRU_LINK_PART_1 + "${o}" + SRU_LINK_PART_2)
//| catch-object-exception
//| open-http(header="User-Agent: hbz/" + CATALOGUE + "-schlagwortfolgen-harvester", accept="application/xml")
//| as-records
//// The following two steps create a single xml file from the multiple incoming sru requests, saved into a harvest tag
//| match(pattern="<\\?xml version=.*?>", replacement="")
//| object-batch-log("SRU Queries: ${totalRecords}", batchSize="10")
//| write(SRU_HARVEST, header="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<harvest>", footer="</harvest>")
//;

"SRU Harvest finished. Start extracting " + CATALOGUE + " subject data from SRU harvest."
| print;

// On the basis of the SRU harvest we extract the Schlagwortfolgen and create new minimal MARC XML records for importing them into ALMA.

SRU_HARVEST
| open-file
| as-records
| match(pattern="ERROR: ((.|\n)*?)</body></html>",replacement="")
| read-string
| decode-xml
| handle-marcxml
| batch-log("Total SRU proper records: ${totalRecords}", batchSize="10")
| fix(FLUX_DIR + "subject.fix",*)
| batch-log("Harvested Records with Schlagwortfolgen: ${totalRecords}", batchSize="100")
| encode-marcxml
| write(OUTFILE)
;

"Create a list of broken " + CATALOGUE + "Ids."
| print;

// On the basis of the SRU harvest we create a list of broken CATALOGUE ids in lobid resources.

SRU_HARVEST
| open-file
| as-lines
// TODO: Filter pattern was "<records/>" this seems not to be always true.
| filter-strings(SRU_QUERY_PATTERN +"</(zs:|)query>.+$",passmatches="true")
// TODO: Adjust for all workflows
| match(pattern= SRU_QUERY_PATTERN +"</(zs:|)query>.+$",replacement="$1")
| decode-csv(separator="\t")
| fix(FLUX_DIR + "failed.fix",*)
| batch-log("Total broken ids: ${totalRecords}",batchSize="100")
| encode-csv(separator="\t",includeheader="true",noQuotes="true")
| write(FAILS_FILE)
;