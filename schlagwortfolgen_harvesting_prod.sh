#!/bin/sh

Metafacture_Runner=$1

echo "Start DNB SChlagwortfolgen Harvesting" && date
$Metafacture_Runner fetchSchlagwortfolgen_prod_sru.flux

echo "Start BVB SChlagwortfolgen Harvesting" && date
$Metafacture_Runner fetchSchlagwortfolgen_prod_sru.flux CATALOGUE="bvb" SYSTEM_ISIL="DE-604" SRU_LINK_PART_1="http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" SRU_LINK_PART_2="&maximumRecords=1" SRU_QUERY_PATTERN=".*marcxml.idn=(.+)" 

echo "Start BSZ SChlagwortfolgen Harvesting" && date
$Metafacture_Runner fetchSchlagwortfolgen_prod_sru.flux CATALOGUE="bsz" SYSTEM_ISIL="DE-576" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.swn=(.+)"
 
echo "Start GBV SChlagwortfolgen Harvesting" && date
$Metafacture_Runner fetchSchlagwortfolgen_prod_sru.flux  CATALOGUE="gbv" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN="<zs:searchRetrieveResponse.*pica.ppn=(.+)"

echo "Start K10Plus SChlagwortfolgen Harvesting" && date
$Metafacture_Runner fetchSchlagwortfolgen_prod_sru.flux CATALOGUE="k10Plus" SYSTEM_ISIL="DE-627" SRU_LINK_PART_1="https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" SRU_LINK_PART_2="&maximumRecords=1&recordSchema=marcxml" SRU_QUERY_PATTERN=".*pica.ppn=(.+)"

echo "Start kobv SChlagwortfolgen Harvesting" && date
$Metafacture_Runner fetchSchlagwortfolgen_prod_sru.flux CATALOGUE="kobv" SYSTEM_ISIL="DE-602" SRU_LINK_PART_1="https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" SRU_LINK_PART_2="&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" SRU_QUERY_PATTERN=".*rec.id=(.+)"

echo "Start kobv SChlagwortfolgen Harvesting" && date
$Metafacture_Runner fetchSchlagwortfolgen_prod_sru.flux CATALOGUE="obv" SYSTEM_ISIL="AT-OBV" SRU_LINK_PART_1="https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" SRU_LINK_PART_2="&maximumRecords=10" SRU_QUERY_PATTERN=".*alma.other_system_number_035_a_exact=(.+)"
