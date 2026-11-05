#!/bin/sh

Metafacture_Runner=$1
Catalogue=$2
Sru_Link_Part_1=$3
Sru_Link_Part_2=$4
Sru_Query_Pattern=$5
System_Isil=$6
Test_Lobid_Query=$7

echo "Start" $Catalogue "Schlagwortfolgen Harvesting" && date
echo $Catalogue": Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE=$Catalogue TEST_LOBID_QUERY=$Test_Lobid_Query

echo $Catalogue": SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_test.flux CATALOGUE=$Catalogue SRU_LINK_PART_1=$Sru_Link_Part_1 SRU_LINK_PART_2=$Sru_Link_Part_2 SRU_QUERY_PATTERN=$Sru_Query_Pattern

echo $Catalogue": SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_test.flux CATALOGUE=$Catalogue SYSTEM_ISIL=$System_Isil

echo $Catalogue": Broken Id Extracting" && date 
$Metafacture_Runner extractBrokenUnionCatalogueIds_test.flux CATALOGUE=$Catalogue
