#!/bin/sh

Metafacture_Runner=$1
Catalogue=$2
Sru_Link_Part_1=$3
Sru_Link_Part_2=$4
Sru_Query_Pattern=$5
System_Isil=$6

echo "Start" $Catalogue "Schlagwortfolgen Harvesting" && date
echo $Catalogue": Lobid Harvesting" && date
$Metafacture_Runner -f harvestRecordsWithoutSWFFromLobid_prod.flux -v CATALOGUE=$Catalogue

echo $Catalogue": SRU Harvesting" && date
$Metafacture_Runner -f harvestRecordsFromSru_prod.flux -v CATALOGUE=$Catalogue -v SRU_LINK_PART_1=$Sru_Link_Part_1 -v SRU_LINK_PART_2=$Sru_Link_Part_2 -v SRU_QUERY_PATTERN=$Sru_Query_Pattern

echo $Catalogue": SWF Exctracting" && date
$Metafacture_Runner -f extractRecordsWithSWF_prod.flux -v CATALOGUE=$Catalogue -v SYSTEM_ISIL=$System_Isil

echo $Catalogue": Broken Id Extracting" && date 
$Metafacture_Runner -f extractBrokenUnionCatalogueIds_prod.flux -v CATALOGUE=$Catalogue
