#!/bin/sh

Metafacture_Runner=$1

echo "Start DNB SChlagwortfolgen Harvesting" && date
$Metafacture_Runner fetchSchlagwortfolgen_test_sru.flux

echo "Start BVB SChlagwortfolgen Harvesting" && date
$Metafacture_Runner fetchSchlagwortfolgen_test_sru.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)"  TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbvbId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse" 

echo "Start BSZ SChlagwortfolgen Harvesting" && date
$Metafacture_Runner fetchSchlagwortfolgen_test_sru.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AbszId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gartenbau"
 
echo "Start GBV SChlagwortfolgen Harvesting" && date
$Metafacture_Runner fetchSchlagwortfolgen_test_sru.flux  CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AgbvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse"

echo "Start K10Plus SChlagwortfolgen Harvesting" && date
$Metafacture_Runner fetchSchlagwortfolgen_test_sru.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3Ak10PlusId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gem%C3%BCse"

echo "Start kobv SChlagwortfolgen Harvesting" && date
$Metafacture_Runner fetchSchlagwortfolgen_test_sru.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AkobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Garten"

echo "Start kobv SChlagwortfolgen Harvesting" && date
$Metafacture_Runner fetchSchlagwortfolgen_test_sru.flux CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)" TEST_LOBID_QUERY="https://lobid.org/resources/search?q=_exists_%3AobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+philosophy"


