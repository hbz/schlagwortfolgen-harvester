# schlagwortfolgen-harvester
Scripts that fetches the subjects 6XX from dnb and other union catalogue records for NZ records that are missing subjects.

Provides two mechanism one via SRU and one via Culturegraph Manifestation dumps.

Culturegraph Manifestation Dumps:

Checks for records from hbz without hbz-Schlagwortfolgen 689 in Culturegraph Manifestation Dump. Selects one of the following Schlwagwortfolgen-packages by source DNB, BVB, K10Plus or OBV as long as `035` and a matching `689 Ind5` is provided. Creates a simple reduced marcxml with only `001`, `035`, `689`, `883`.

SRU: 

By default the sru scripts currently searches for all records with dnbId or other union catalogue ids, from the hbz ALMA NZ and without zdbId and without complexSubjects in lobid-resources. Then checks DNB for the marcxml and creates reduced marcxml with only `001`, `035` and `689`.

With the help of variables the workflow that can be provided when running the metafacture workflow the workflow can be configured that it harvests records from other union catalogues.

To be determined if other subjects should be kept.

## Requirements

Metafacture 8.0.1 or higher

## Culturegrap Harvesting

### Run tests

```bash
path/to/metafacture/flux.sh cg_test.flux
```

### Run full dump

```bash
path/to/metafacture/flux.sh cg_prod.flux
```

## SRU Harvesting

### Run tests

> [!IMPORTANT]
> The harvesting processes are outcommented in the test, if you want to update a certain workflow, you have to undo the outcommenting and run a single workflow.


To run all test workflows at once:

```bash
bash schlagwortfolgen_harvesting_test.sh 'path/to/metafacture/flux.sh'
```

#### DNB

```bash
echo "DNB: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_test.flux

echo "DNB: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_test.flux

echo "DNB: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_test.flux

echo "DNB: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_test.flux
```

(Is the default setting of the workflow.)

In order to upate or adjust the test data basis undo the outcomment in the test workflow.

#### Other Verbundkatalog

```bash
echo "...: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE=".." TEST_LOBID_QUERY="..." 

echo "...: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_test.flux CATALOGUE="..." [AUTH="..."] SRU_LINK_PART_1="..." SRU_LINK_PART_2="..." SRU_QUERY_PATTERN="..."

echo "...: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_test.flux CATALOGUE="..." SYSTEM_ISIL="..." 

echo "...: Broken Id Extracting" && date 
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_test.flux CATALOGUE="..." 
```

##### hebis

has no SWF

##### bvb

```bash
echo "BVB: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="bvb" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbvbId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse" 

echo "BVB: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_test.flux CATALOGUE="bvb" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)"

echo "BVB: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_test.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" 

echo "BVB: Broken Id Extracting" && date 
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_test.flux CATALOGUE="bvb" 
```

##### bzs

via k10Plus

```bash
echo "BSZ: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="bsz"  TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbszId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gartenbau"

echo "BSZ: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_test.flux CATALOGUE="bsz" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)"

echo "BSZ: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_test.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" 

echo "BSZ: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_test.flux CATALOGUE="bsz" 

```

##### gbv

via k10Plus

```bash
echo "GBV: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="gbv" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AgbvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse"

echo "GBV: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_test.flux CATALOGUE="gbv" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)"

echo "GBV: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_test.flux CATALOGUE="gbv" SYSTEM_ISIL="DE-627" 

echo "GBV: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_test.flux CATALOGUE="gbv" 

```

##### k10Plus

```bash
echo "K10Plus: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="k10Plus"  TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3Ak10PlusId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Garten"

echo "K10Plus: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_test.flux CATALOGUE="k10Plus" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"

echo "K10Plus: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_test.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" 

echo "K10Plus: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_test.flux CATALOGUE="k10Plus" 

```

##### kobv

```bash
echo "KOBV: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="kobv" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AkobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Garten"

echo "KOBV: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_test.flux CATALOGUE="kobv" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)" 

echo "KOBV: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_test.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" 

echo "KOBV: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_test.flux CATALOGUE="kobv" 

```

##### obv

```bash
echo "OBV: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_test.flux  CATALOGUE="obv" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+philosophy"

echo "OBV: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_test.flux  CATALOGUE="obv" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)"

echo "OBV: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_test.flux  CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" 

echo "OBV: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_test.flux  CATALOGUE="obv" 

```

for harvesting needs auth credential with the variable `AUTH= "[BASE64 of User:Password]"`


### Create prod dumps

Productive script for monthly harvested of DNB, BVB and K10Plus. To run all these prod workflows at once:

```bash
bash schlagwortfolgen_harvesting_prod.sh 'path/to/metafacture/flux.sh'
```


#### DNB

```bash
echo "DNB: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_prod.flux

echo "DNB: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_prod.flux

echo "DNB: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_prod.flux

echo "DNB: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_prod.flux
```

(Is the default setting of the workflow.)

#### Other Verbundkatalog

```bash
echo "...: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="..." 

echo "...: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_prod.flux CATALOGUE="..." SRU_LINK_PART_1="..." SRU_LINK_PART_2="..." SRU_QUERY_PATTERN="..." [SLEEP_TIME="..." AUTH="..."]

echo "...: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_prod.flux CATALOGUE="..." SYSTEM_ISIL="..." 

echo "...: Broken Id Extracting" && date 
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="..." 
```

##### bvb

```bash
echo "BVB: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="bvb" 

echo "BVB: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_prod.flux CATALOGUE="bvb" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)" 

echo "BVB: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_prod.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" 

echo "BVB: Broken Id Extracting" && date 
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="bvb" 
```

##### k10Plus

```bash
echo "K10Plus: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="k10Plus" 

echo "K10Plus: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_prod.flux CATALOGUE="k10Plus" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"

echo "K10Plus: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_prod.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" 

echo "K10Plus: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="k10Plus" 
```

#### hebis

has no SWF

#### bzs

via k10Plus

```bash
echo "BSZ: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="bsz" 
 
echo "BSZ: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_prod.flux CATALOGUE="bsz" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)"
 
echo "BSZ: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_prod.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" 
 
echo "BSZ: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="bsz" 
```

##### gbv

via k10Plus

```bash
echo "GBV: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="gbv" 

echo "GBV: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_prod.flux CATALOGUE="gbv" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)"

echo "GBV: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_prod.flux CATALOGUE="gbv" SYSTEM_ISIL="DE-627" 

echo "GBV: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="gbv" 
```

##### kobv

```bash
echo "KOBV: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="kobv" 

echo "KOBV: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_prod.flux CATALOGUE="kobv" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)"

echo "KOBV: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_prod.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" 

echo "KOBV: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="kobv" 
```

##### obv

```bash
echo "OBV: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="obv" 

echo "OBV: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_prod.flux CATALOGUE="obv" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)"

echo "OBV: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_prod.flux CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" 

echo "OBV: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="obv" 

```

for harvesting needs auth credential with the variable `AUTH= "[BASE64 of User:Password]"`

