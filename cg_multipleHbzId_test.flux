default VERSION="test/";
default CG_AGGREGATION=FLUX_DIR + VERSION + "/harvest/cgTest.xml";
default CG_DUB_OUTPUT=FLUX_DIR + VERSION + "cgTestDub.txt";
default TIMESTAMP = "0";

CG_AGGREGATION
| open-file
| decode-xml
| handle-marcxml
| batch-log("CG TOTAL: ${totalRecords}", batchSize="10")
| fix(FLUX_DIR + "cg-multiple-hbzId.fix",*)
| batch-log("HBZ CG RECORDS: ${totalRecords}", batchSize="10")
| encode-csv(noQuotes="true")
| write(CG_DUB_OUTPUT)
;