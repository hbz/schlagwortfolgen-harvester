default VERSION="test/";
default CATALOGUE="dnb";
default SYSTEM_ISIL="DE-101";
default AUTH ="";
default SRU_HARVEST=FLUX_DIR + VERSION + "/harvest/" + CATALOGUE + "-sru-records.xml";
default OUTFILE=FLUX_DIR + VERSION + "swk-" + CATALOGUE + ".xml";
default LOBID_HARVEST = FLUX_DIR + VERSION +"/harvest/"  + CATALOGUE + "-lobid-records-no-swk.jsonl";
default LOOKUP_FILE = FLUX_DIR + VERSION + "/maps/" + "almaMmsId2" + CATALOGUE + "Id.tsv";
default SRU_LINK_PART_1 = "https://services.dnb.de/sru/dnb?version=1.1&operation=searchRetrieve&query=dnb.idn=";
default SRU_LINK_PART_2 = "&recordSchema=MARC21-xml";
default SRU_QUERY_PATTERN = ".*dnb.idn=(.+)";
default TEST_LOBID_QUERY = "https://lobid.org/resources/search?q=_exists_%3AdnbId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gem%C3%BCse";
default FAILS_FILE = FLUX_DIR + VERSION + CATALOGUE + "failed.tsv";

// Outcommented to not harvest the data every time.

"SRU Harvest finished. Start extracting " + CATALOGUE + " subject data from SRU harvest."
| print;

// On the basis of the SRU harvest we extract the Schlagwortfolgen and create new minimal MARC XML records for importing them into ALMA.

SRU_HARVEST
| open-file
| as-records
| match(pattern="ERROR: (?:.|\n)*?</body></html>",replacement="")
| read-string
| decode-xml
| handle-marcxml
| batch-log(CATALOGUE + ": Total SRU proper records: ${totalRecords}", batchSize="10")
| fix(FLUX_DIR + "subject.fix",*)
| batch-log(CATALOGUE + ": Harvested Records with Schlagwortfolgen: ${totalRecords}", batchSize="100")
| encode-marcxml
| write(OUTFILE)
;
