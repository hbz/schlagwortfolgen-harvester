#!/bin/sh

Metafacture_Runner=$1

# DNB

echo "Start DNB SChlagwortfolgen Harvesting" && date
echo "DNB: Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_test.flux

echo "DNB: SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_test.flux

echo "DNB: SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_test.flux

echo "DNB: Broken Id Extracting" && date
$Metafacture_Runner extractBrokenUnionCatalogueIds_test.flux

# BVB

echo "Start BVB SChlagwortfolgen Harvesting" && date
echo "BVB: Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="bvb" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbvbId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse" 

echo "BVB: SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_test.flux CATALOGUE="bvb" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)"

echo "BVB: SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_test.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604"

echo "BVB: Broken Id Extracting" && date 
$Metafacture_Runner extractBrokenUnionCatalogueIds_test.flux CATALOGUE="bvb"

# BSZ

echo "Start BSZ SChlagwortfolgen Harvesting" && date
echo "BSZ: Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="bsz" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbszId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gartenbau"

echo "BSZ: SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_test.flux CATALOGUE="bsz" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)"

echo "BSZ: SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_test.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576"

echo "BSZ: Broken Id Extracting" && date
$Metafacture_Runner extractBrokenUnionCatalogueIds_test.flux CATALOGUE="bsz"
# GBV

echo "Start GBV SChlagwortfolgen Harvesting" && date
echo "GBV: Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="gbv" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AgbvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse"

echo "GBV: SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_test.flux CATALOGUE="gbv" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AgbvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse"

echo "GBV: SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_test.flux CATALOGUE="gbv" SYSTEM_ISIL="DE-627" 

echo "GBV: Broken Id Extracting" && date
$Metafacture_Runner extractBrokenUnionCatalogueIds_test.flux CATALOGUE="gbv" 

# K10Plus

echo "Start K10Plus SChlagwortfolgen Harvesting" && date
echo "K10Plus: Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="k10Plus" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3Ak10PlusId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Garten"

echo "K10Plus: SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_test.flux CATALOGUE="k10Plus" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"

echo "K10Plus: SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_test.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" 

echo "K10Plus: Broken Id Extracting" && date
$Metafacture_Runner extractBrokenUnionCatalogueIds_test.flux CATALOGUE="k10Plus" 


# KOBV

echo "Start KOBV SChlagwortfolgen Harvesting" && date
echo "KOBV: Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_test.flux CATALOGUE="kobv" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AkobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Garten"

echo "KOBV: SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_test.flux CATALOGUE="kobv" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)"

echo "KOBV: SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_test.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" 

echo "KOBV: Broken Id Extracting" && date
$Metafacture_Runner extractBrokenUnionCatalogueIds_test.flux CATALOGUE="kobv" 

# OBV

echo "Start OBV SChlagwortfolgen Harvesting" && date
echo "OBV: Lobid Harvesting" && date
$Metafacture_Runner harvestRecordsWithoutSWFFromLobid_test.flux  CATALOGUE="obv" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+philosophy"

echo "OBV: SRU Harvesting" && date
$Metafacture_Runner harvestRecordsFromSru_test.flux  CATALOGUE="obv" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)"

echo "OBV: SWF Exctracting" && date
$Metafacture_Runner extractRecordsWithSWF_test.flux  CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" 

echo "OBV: Broken Id Extracting" && date
$Metafacture_Runner extractBrokenUnionCatalogueIds_test.flux  CATALOGUE="obv"
