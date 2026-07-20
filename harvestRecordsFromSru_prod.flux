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
| catch-object-exception(logprefix=CATALOGUE, logstacktrace="true")
| open-http(header="User-Agent: hbz/" + CATALOGUE + "-schlagwortfolgen-harvester\nAuthorization: Basic " + AUTH, accept="application/xml")
| sleep(sleepTime=SLEEP_TIME, timeUnit="MILLISECONDS")
| as-records
// The following two steps create a single xml file from the multiple incoming sru requests, saved into a harvest tag
| match(pattern="<\\?xml version=.*?>", replacement="")
| object-batch-log(CATALOGUE + ": SRU Queries: ${totalRecords}", batchSize="1000")
| write(SRU_HARVEST, header="<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<harvest>", footer="</harvest>", compression="gzip")
;
