# schlagwortfolgen-harvester
Script that fetches the subjects 6XX from dnb and other union catalogue records for NZ records that are missing subjects.

By default the script currently searches for all records with dnbId, from the NZ and without zdbId and without complexSubjects in lobid-resources. Then checks DNB for the marcxml and creates reduced marcxml with only `001` and `689`.

With the help of variables the workflow that can be provided when running the metafacture workflow the workflow can be configured that it harvests records from other union catalogues.

To be determined if other subjects should be kept.

## Requirements

Metafacture 8.0.1 or higher

## Run tests

> [!IMPORTANT]
> The harvesting processes are outcommented in the test, if you want to update a certain workflow, you have to undo the outcommenting and run a single workflow.

To run all test workflows at once:

```bash
bash schlagwortfolgen_harvesting_test.sh 'path/to/metafacture/flux.sh'
```

### DNB

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

### Other Verbundkatalog

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_test_sru.flux CATALOGUE="..." SYSTEM_ISIL="..." SRU_LINK_PART_1="..." SRU_LINK_PART_2="..." SRU_QUERY_PATTERN="..." TEST_LOBID_QUERY="..." SLEEP_TIME="..."
```

#### hebis

has no SWF

#### bvb

```bash
echo "BVB: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)"  TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbvbId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse" 

echo "BVB: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_test.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)"  TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbvbId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse" 

echo "BVB: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_test.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)"  TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbvbId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse" 

echo "BVB: Broken Id Extracting" && date 
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_test.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)"  TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbvbId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse" 
```

#### bzs

via k10Plus

```bash
echo "BSZ: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbszId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gartenbau"

echo "BSZ: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_test.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbszId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gartenbau"

echo "BSZ: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_test.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbszId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gartenbau"

echo "BSZ: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_test.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbszId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gartenbau"

```

#### gbv

via k10Plus

```bash
echo "GBV: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AgbvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse"

echo "GBV: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_test.flux CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AgbvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse"

echo "GBV: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_test.flux CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AgbvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse"

echo "GBV: Broken Id Extracting" && date
$Metafact
```

#### k10Plus

```bash
echo "K10Plus: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3Ak10PlusId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gem%C3%BCse"

echo "K10Plus: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_test.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3Ak10PlusId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gem%C3%BCse"

echo "K10Plus: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_test.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3Ak10PlusId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gem%C3%BCse"

echo "K10Plus: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_test.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3Ak10PlusId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gem%C3%BCse"

```

#### kobv

```bash
echo "KOBV: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AkobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Garten"

echo "KOBV: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_test.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AkobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Garten"

echo "KOBV: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_test.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AkobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Garten"

echo "KOBV: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_test.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AkobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Garten"

```

#### obv

```bash
echo "OBV: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_test.flux  CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+philosophy"

echo "OBV: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_test.flux  CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+philosophy"

echo "OBV: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_test.flux  CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+philosophy"

echo "OBV: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_test.flux  CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+philosophy"

```

for harvesting needs auth credential with the variable `AUTH= "[BASE64 of User:Password]"`


## Create prod dumps

To run all test workflows at once:

```bash
bash schlagwortfolgen_harvesting_prod.sh 'path/to/metafacture/flux.sh'
```


### DNB

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

### Other Verbundkatalog

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux CATALOGUE="..." SYSTEM_ISIL="..." SRU_LINK_PART_1="..." SRU_LINK_PART_2="..." SRU_QUERY_PATTERN="..." SLEEP_TIME="..."
```

#### hebis

has no SWF

#### bvb

```bash
echo "BVB: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)" 

echo "BVB: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_prod.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)" 

echo "BVB: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_prod.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)" 

echo "BVB: Broken Id Extracting" && date 
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)" 
```

#### bzs

via k10Plus

```bash
echo "BSZ: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)"
 
echo "BSZ: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_prod.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)"
 
echo "BSZ: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_prod.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)"
 
echo "BSZ: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)"
```

#### gbv

via k10Plus

```bash
echo "GBV: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)"

echo "GBV: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_prod.flux CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)"

echo "GBV: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_prod.flux CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)"

echo "GBV: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)"
```

#### k10Plus

```bash
echo "K10Plus: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"

echo "K10Plus: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_prod.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"

echo "K10Plus: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_prod.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"

echo "K10Plus: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"
```

#### kobv

```bash
echo "KOBV: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)"

echo "KOBV: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_prod.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)"

echo "KOBV: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_prod.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)"

echo "KOBV: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)"
```

#### obv

```bash
echo "OBV: Lobid Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)"

echo "OBV: SRU Harvesting" && date
path/to/metafacture/flux.sh harvestRecordsFromSru_prod.flux CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)"

echo "OBV: SWF Exctracting" && date
path/to/metafacture/flux.sh extractRecordsWithSWF_prod.flux CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)"

echo "OBV: Broken Id Extracting" && date
path/to/metafacture/flux.sh extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)"

```

for harvesting needs auth credential with the variable `AUTH= "[BASE64 of User:Password]"`

