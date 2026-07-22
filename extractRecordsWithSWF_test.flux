default VERSION="test/";
default CATALOGUE="dnb";
default SYSTEM_ISIL="DE-101";
default SRU_HARVEST=FLUX_DIR + VERSION + "/harvest/" + CATALOGUE + "-sru-records.xml";
default OUTFILE=FLUX_DIR + VERSION + "swk-" + CATALOGUE + ".xml";
default LOOKUP_FILE = FLUX_DIR + VERSION + "/maps/" + "almaMmsId2" + CATALOGUE + "Id.tsv";

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
