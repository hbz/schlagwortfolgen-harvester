#!/bin/sh

Metafacture_Runner=$1

# DNB

echo "Start DNB SChlagwortfolgen Harvesting" && date
echo "DNB: Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_prod.flux

echo "DNB: SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_prod.flux

echo "DNB: SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_prod.flux

echo "DNB: Broken Id Extracting" && date
$Metafacture_Runner extractBrokenUnionCatalogueIds_prod.flux

# BVB

echo "Start BVB SChlagwortfolgen Harvesting" && date
echo "BVB: Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)" 

echo "BVB: SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_prod.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)" 

echo "BVB: SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_prod.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)" 

echo "BVB: Broken Id Extracting" && date 
$Metafacture_Runner extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)" 

# BSZ

echo "Start BSZ SChlagwortfolgen Harvesting" && date
echo "BSZ: Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)"
 
echo "BSZ: SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_prod.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)"
 
echo "BSZ: SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_prod.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)"
 
echo "BSZ: Broken Id Extracting" && date
$Metafacture_Runner extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)"
 
# GBV

echo "Start GBV SChlagwortfolgen Harvesting" && date
echo "GBV: Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)"

echo "GBV: SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_prod.flux CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)"

echo "GBV: SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_prod.flux CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)"

echo "GBV: Broken Id Extracting" && date
$Metafacture_Runner extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)"

# K10Plus

echo "Start K10Plus SChlagwortfolgen Harvesting" && date
echo "K10Plus: Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"

echo "K10Plus: SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_prod.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"

echo "K10Plus: SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_prod.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"

echo "K10Plus: Broken Id Extracting" && date
$Metafacture_Runner extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"


# KOBV

echo "Start KOBV SChlagwortfolgen Harvesting" && date
echo "KOBV: Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)"

echo "KOBV: SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_prod.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)"

echo "KOBV: SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_prod.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)"

echo "KOBV: Broken Id Extracting" && date
$Metafacture_Runner extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)"

# OBV

echo "Start OBV SChlagwortfolgen Harvesting" && date
echo "OBV: Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_prod.flux CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)"

echo "OBV: SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_prod.flux CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)"

echo "OBV: SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_prod.flux CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)"

echo "OBV: Broken Id Extracting" && date
$Metafacture_Runner extractBrokenUnionCatalogueIds_prod.flux CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)"
