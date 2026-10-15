#!/bin/sh

Metafacture_Runner=$1
Catalogue=$2
Sru_Link_Part_1=$3
Sru_Link_Part_2=$4
Sru_Query_Pattern=$5
System_Isil=$6

echo "Start" $Catalogue "Schlagwortfolgen Harvesting" && date
echo $Catalogue": Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE=$Catalogue

echo $Catalogue": SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_prod.flux CATALOGUE=$Catalogue SRU_LINK_PART_1=$Sru_Link_Part_1 SRU_LINK_PART_2=$Sru_Link_Part_2 SRU_QUERY_PATTERN=$Sru_Query_Pattern

echo $Catalogue": SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_prod.flux CATALOGUE=$Catalogue SYSTEM_ISIL=$System_Isil

echo $Catalogue": Broken Id Extracting" && date 
$Metafacture_Runner extractBrokenUnionCatalogueIds_prod.flux CATALOGUE=$Catalogue
