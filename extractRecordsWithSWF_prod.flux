default VERSION="prod/";
default CATALOGUE="dnb";
default SYSTEM_ISIL="DE-101";
default SRU_HARVEST=FLUX_DIR + VERSION + "/harvest/" + CATALOGUE + "-sru-records.xml.gz";
default OUTFILE=FLUX_DIR + VERSION + "swk-" + CATALOGUE + ".xml.gz";
default LOOKUP_FILE = FLUX_DIR + VERSION + "/maps/" + "almaMmsId2" + CATALOGUE + "Id.tsv";


"Start harvesting " + CATALOGUE + " subject data."
| print;

// On the basis of the SRU harvest we extract the Schlagwortfolgen and create new minimal MARC XML records for importing them into ALMA.
// Use a faster intermediate saved cleaned file.

SRU_HARVEST
| open-file
| as-lines
| filter-strings("ERROR:",passmatches="false")
| write(SRU_HARVEST + "_cleaned" )
;

SRU_HARVEST + "_cleaned"
| open-file
| decode-xml
| handle-marcxml
| batch-log(CATALOGUE + ": Total SRU proper records: ${totalRecords}", batchSize="1000")
| fix(FLUX_DIR + "subject.fix",*)
| batch-log(CATALOGUE + ": Harvested Records with Schlagwortfolgen: ${totalRecords}", batchSize="1000")
| encode-marcxml
| write(OUTFILE)
;
