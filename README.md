# schlagwortfolgen-harvester
Script that fetches the subjects 6XX from dnb and other union catalogue records for NZ records that are missing subjects.

By default the script currently searches for all records with dnbId, from the NZ and without zdbId and without complexSubjects in lobid-resources. Then checks DNB for the marcxml and creates reduced marcxml with only `001` and `689`.

With the help of variables the workflow that can be provided when running the metafacture workflow the workflow can be configured that it harvests records from other union catalogues.

To be determined if other subjects should be kept.

## Requirements

Metafacture 8.0.1 or higher

## Run tests

### DNB

`path/to/metafacture/flux.sh fetchSchlagwortfolgen_test_sru.flux` (Is the default setting of the workflow.)

In order to upate or adjust the test data basis undo the outcomment in the test workflow.

### Other Verbundkatalog

`path/to/metafacture/flux.sh fetchSchlagwortfolgen_test_sru.flux catalogue="..." systemIsil="..." sruLinkPart1="..." sruLinkPart2="..." sruQueryPattern="..." testLobidQuery="..."`

#### hebis

`path/to/metafacture/flux.sh fetchSchlagwortfolgen_test_sru.flux catalogue="hebis" systemIsil="DE-603" sruLinkPart1="http://sru.hebis.de/sru/DB=2.1?query=pica.ppn+%3D+%22" sruLinkPart2="%22&version=1.1&operation=searchRetrieve&stylesheet=http%3A%2F%2Fsru.hebis.de%2Fsru%2F%3Fxsl%3DsearchRetrieveResponse&recordSchema=marc21&maximumRecords=10&startRecord=1&recordPacking=xml&sortKeys=LST_Y%2Cpica%2C0%2C%2C" sruQueryPattern=".*pica.ppn=(.+)"
testLobidQuery="https://lobid.org/resources/search?q=_exists_%3AhebisId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gem%C3%BCse"`


TODO: Adjust query for all union catalogue.

## Create prod dump

### DNB

`path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux`  (Is the default setting of the workflow.)

### Other Verbundkatalog

`path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux catalogue="..." systemIsil="..." sruLinkPart1="..." sruLinkPart2="..." sruQueryPattern="..."`

#### hebis

`path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux catalogue="hebis" systemIsil="DE-603" sruLinkPart1="http://sru.hebis.de/sru/DB=2.1?query=pica.ppn+%3D+%22" sruLinkPart2="%22&version=1.1&operation=searchRetrieve&stylesheet=http%3A%2F%2Fsru.hebis.de%2Fsru%2F%3Fxsl%3DsearchRetrieveResponse&recordSchema=marc21&maximumRecords=10&startRecord=1&recordPacking=xml&sortKeys=LST_Y%2Cpica%2C0%2C%2C" sruQueryPattern=".*pica.ppn=(.+)"`
`

TODO: Adjust query for all union catalogue.