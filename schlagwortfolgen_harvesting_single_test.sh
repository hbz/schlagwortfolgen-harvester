#!/bin/sh

Metafacture_Runner=$1
Catalogue=$2
Combined_Ids=$3
Sru_Link_Part_1=$4
Sru_Link_Part_2=$5
Sru_Query_Pattern=$6
System_Isil=$7
Test_Lobid_Query=$8

echo "Start" $Catalogue "Schlagwortfolgen Harvesting" && date
echo $Catalogue": Lobid Harvesting" && date
$Metafacture_Runner -f harvestRecordsWithoutSWFFromLobid_test.flux -v CATALOGUE=$Catalogue -v TEST_LOBID_QUERY=$Test_Lobid_Query

echo $Catalogue": SRU Harvesting" && date
$Metafacture_Runner -f harvestRecordsFromSru_test.flux -v CATALOGUE=$Catalogue -v SRU_LINK_PART_1=$Sru_Link_Part_1 -v SRU_LINK_PART_2=$Sru_Link_Part_2 -v SRU_QUERY_PATTERN=$Sru_Query_Pattern -v COMBINED_IDS=$Combined_Ids

echo $Catalogue": SWF Exctracting" && date
$Metafacture_Runner -f extractRecordsWithSWF_test.flux -v CATALOGUE=$Catalogue -v SYSTEM_ISIL=$System_Isil