default VERSION="test/";
default CATALOGUE="dnb";
default LOBID_HARVEST = FLUX_DIR + VERSION +"/harvest/"  + CATALOGUE + "-lobid-records-no-swk.jsonl";
default LOOKUP_FILE = FLUX_DIR + VERSION + "/maps/" + "almaMmsId2" + CATALOGUE + "Id.tsv";
default TEST_LOBID_QUERY = "https://lobid.org/resources/search?q=_exists_%3AdnbId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gem%C3%BCse";


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
