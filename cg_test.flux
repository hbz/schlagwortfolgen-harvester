default VERSION="test/";
default CG_AGGREGATION=FLUX_DIR + VERSION + "/harvest/cgTest.xml";
default CG_SWK_OUTPUT=FLUX_DIR + VERSION + "swk-cg.xml";
default TIMESTAMP = "0";

CG_AGGREGATION
| open-file
| decode-xml
| handle-marcxml
| batch-log("CG TOTAL: ${totalRecords}", batchSize="10")
| fix(FLUX_DIR + "cg-swk-extract.fix",*)
| batch-log("HBZ CG RECORDS: ${totalRecords}", batchSize="10")
| encode-marcxml
| write(CG_SWK_OUTPUT)
;