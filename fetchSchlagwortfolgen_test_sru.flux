default version="test/";
default catalogue="dnb";
default systemIsil="DE-101";
default sruHarvest=FLUX_DIR + version + catalogue + "_sru_records.xml";
default outfile=FLUX_DIR + version + catalogue + "Subjects.xml";
default lobidHarvest = FLUX_DIR + version + catalogue + "Subjects.jsonl";
default lookupFile = FLUX_DIR + version + "almaMmsId2" + catalogue + "Id.tsv";
default sruLinkPart1 = "https://services.dnb.de/sru/dnb?version=1.1&operation=searchRetrieve&query=dnb.idn=";
default sruLinkPart2 = "&recordSchema=MARC21-xml";
default sruQueryPattern = ".*dnb.idn=(.+)";
default testLobidQuery = "https://lobid.org/resources/search?q=_exists_%3AdnbId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gem%C3%BCse";

// Outcommented to not harvest the data every time.

// "Start harvesting lobid for " + catalogue + " records without Schlagwortfolgen"
// | print;

//// We download all reacords that have catalogue ids but no Schlagwortfolgen from lobid resources.

// testLobidQuery
// | open-http(header="User-Agent: hbz/" + catalogue + "-schlagwortfolgen-harvester\\nAccept-Encoding: gzip" )
// | as-lines
// | write(lobidHarvest)
// ;

"Harvesting lobid finished. Start creating dnbId2" + catalogue + "Id map."
| print;

// On the basis of the catalogue id in the lobid resources data we create links to harvest the catalogues SRU.

lobidHarvest
| open-file
| as-lines
| decode-json
| fix("retain('almaMmsId','$[catalogue]Id')",*)
| encode-csv(noQuotes="true", separator="\t")
| write(lookupFile)
;

"Map finished. Start harvesting " + catalogue + " sru."
| print;

//// On the basis of the catalogue id in the lobid resources data we create links to harvest the catalogues SRU.

//lobidHarvest
//| open-file
//| as-lines
//| decode-json
//| fix("retain('$[catalogue]Id')",*)
//| literal-to-object
//| template(sruLinkPart1 + "${o}" + sruLinkPart2)
//| catch-object-exception
//| open-http(header="User-Agent: hbz/" + catalogue + "-schlagwortfolgen-harvester", accept="application/xml")
//| as-records
//// The following two steps create a single xml file from the multiple incoming sru requests, saved into a harvest tag
//| match(pattern="<\\?xml version=.*?>", replacement="")
//| object-batch-log("SRU Queries: ${totalRecords}", batchSize="10")
//| write(sruHarvest, header="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<harvest>", footer="</harvest>")
//;

"SRU Harvest finished. Start extracting " + catalogue + " subject data from SRU harvest."
| print;

// On the basis of the SRU harvest we extract the Schlagwortfolgen and create new minimal MARC XML records for importing them into ALMA.

sruHarvest
| open-file
| as-records
| match(pattern="ERROR: ((.|\n)*?)</body></html>",replacement="")
| read-string
| decode-xml
| handle-marcxml
| batch-log("Total SRU proper records: ${totalRecords}", batchSize="10")
| fix(FLUX_DIR + "subject.fix",*)
| encode-marcxml
| object-batch-log("Harvested Records with Schlagwortfolgen: ${totalRecords}", batchSize="100")
| write(outfile)
;

"Create a list of broken " + catalogue + "Ids."
| print;

// On the basis of the SRU harvest we create a list of broken catalogue ids in lobid resources.

//sruHarvest
//| open-file
//| as-lines
//| filter-strings("<records/>",passmatches="true")
//// TODO: Adjust for all workflows
//| match(pattern= sruQueryPattern +"</query>.+$",replacement="$1")
//| decode-csv(separator="\t")
//| fix(FLUX_DIR + "failed.fix",*)
//| batch-log("Total broken ids: ${totalRecords}",batchSize="100")
//| encode-csv(separator="\t",includeheader="true",noQuotes="true")
//| write(FLUX_DIR + version + catalogue + "failed.tsv")
//;