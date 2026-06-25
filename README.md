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

`path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux catalogue="..." sruLinkPart1="..." sruLinkPart2="..." sruQueryPattern="..." testLobidQuery="..."`

TODO: Adjust query for all union catalogue.

## Create prod dump

### DNB

`path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux`  (Is the default setting of the workflow.)

### Other Verbundkatalog

`path/to/metafacture/flux.sh fetchSchlagwortfolgen_prod_sru.flux catalogue="..." sruLinkPart1="..." sruLinkPart2="..." sruQueryPattern="..."`

TODO: Adjust query for all union catalogue.