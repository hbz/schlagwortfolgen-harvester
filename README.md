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
path/to/metafacture/flux.sh fetchSchlagwortfolgen_test_sru.flux
```

(Is the default setting of the workflow.)

In order to upate or adjust the test data basis undo the outcomment in the test workflow.

### Other Verbundkatalog

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_test_sru.flux CATALOGUE="..." SYSTEM_ISIL="..." SRU_LINK_PART_1="..." SRU_LINK_PART_2="..." SRU_QUERY_PATTERN="..." TEST_LOBID_QUERY="..." SLEEP_TIME="..."
```

#### hebis

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_test_sru.flux CATALOGUE="hebis" SYSTEM_ISIL="DE-603" SRU_LINK_PART_1="http://sru.hebis.de/sru/DB=2.1?query=pica.ppn+%3D+%22" SRU_LINK_PART_2="%22&version=1.1&operation=searchRetrieve&stylesheet=http%3A%2F%2Fsru.hebis.de%2Fsru%2F%3Fxsl%3DsearchRetrieveResponse&recordSchema=marc21&maximumRecords=10&startRecord=1&recordPacking=xml&sortKeys=LST_Y%2Cpica%2C0%2C%2C" SRU_QUERY_PATTERN=".*pica.ppn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AhebisId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gem%C3%BCse"
```

#### bvb

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_test_sru.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)"  TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbvbId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse"
```

#### bzs

via k10Plus

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_test_sru.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbszId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gartenbau"
```

#### gbv

via k10Plus

```bash
path/to/metafacture/flux.sh  fetchSchlagwortfolgen_test_sru.flux  CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AgbvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse"
```

#### k10Plus

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_test_sru.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3Ak10PlusId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gem%C3%BCse"
```

#### kobv

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_test_sru.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AkobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Garten"
```

#### obv

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_test_sru.flux CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+philosophy"
```

for harvesting needs auth credential with the variable `AUTH= "[BASE64 of User:Password]"`


## Create prod dumps

To run all test workflows at once:

```bash
bash schlagwortfolgen_harvesting_prod.sh 'path/to/metafacture/flux.sh'
```


### DNB

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux
```

(Is the default setting of the workflow.)

### Other Verbundkatalog

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux CATALOGUE="..." SYSTEM_ISIL="..." SRU_LINK_PART_1="..." SRU_LINK_PART_2="..." SRU_QUERY_PATTERN="..." SLEEP_TIME="..."
```

#### hebis

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux CATALOGUE="hebis" SYSTEM_ISIL="DE-603" SRU_LINK_PART_1="http://sru.hebis.de/sru/DB=2.1?query=pica.ppn+%3D+%22" SRU_LINK_PART_2="%22&version=1.1&operation=searchRetrieve&stylesheet=http%3A%2F%2Fsru.hebis.de%2Fsru%2F%3Fxsl%3DsearchRetrieveResponse&recordSchema=marc21&maximumRecords=10&startRecord=1&recordPacking=xml&sortKeys=LST_Y%2Cpica%2C0%2C%2C" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"
```

#### bvb

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)"
```

#### bzs

via k10Plus

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)"
```

#### gbv

via k10Plus

```bash
path/to/metafacture/flux.sh  fetchSchlagwortfolgen_prod_sru.flux  CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"
```

#### k10Plus

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="hhttps://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"
```

#### kobv

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)"
```

#### obv

```bash
path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)" AUTH= "[BASE64 of User:Password]
```

for harvesting needs auth credential with the variable `AUTH= "[BASE64 of User:Password]"`

