#!/bin/sh

Metafacture_Runner=$1

# DNB

bash schlagwortfolgen_harvesting_single_test.sh $Metafacture_Runner "dnb" "https://services.dnb.de/sru/dnb?version=1.1&operation=searchRetrieve&query=dnb.idn=" "&recordSchema=MARC21-xml" ".*dnb.idn=(.+)" "DE-101" "https://lobid.org/resources/search?q=_exists_%3AdnbId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gem%C3%BCse"

# BVB

bash schlagwortfolgen_harvesting_single_test.sh $Metafacture_Runner "bvb" "http://bvbr.bib-bvb.de:5661/bvb01sru?version=1.1&recordSchema=marcxml&operation=searchRetrieve&query=marcxml.idn=" "&maximumRecords=1" ".*marcxml.idn=(.+)" "DE-604" "https://lobid.org/resources/search?q=_exists_%3AbvbId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse"

# BSZ

bash schlagwortfolgen_harvesting_single_test.sh $Metafacture_Runner "bsz" "https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.swn=" "&maximumRecords=1&recordSchema=marcxml" ".*pica.swn=(.+)" "DE-576" "https://lobid.org/resources/search?q=_exists_%3AbszId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gartenbau"

# GBV

bash schlagwortfolgen_harvesting_single_test.sh $Metafacture_Runner "gbv" "https://sru.k10plus.de/opac-de-627?version=1.2&operation=searchRetrieve&query=pica.ppn=" "&maximumRecords=1&recordSchema=marcxml" "<zs:searchRetrieveResponse.*pica.ppn=(.+)" "DE-627" "https://lobid.org/resources/search?q=_exists_%3AgbvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Gemüse"

# K10Plus

bash schlagwortfolgen_harvesting_single_test.sh $Metafacture_Runner "k10Plus" "https://sru.k10plus.de/opac-de-627?version=1.1&operation=searchRetrieve&query=pica.ppn=" "&maximumRecords=1&recordSchema=marcxml" ".*pica.ppn=(.+)" "DE-627" "https://lobid.org/resources/search?q=_exists_%3Ak10PlusId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Garten"


# KOBV

bash schlagwortfolgen_harvesting_single_test.sh $Metafacture_Runner "kobv" "https://sru.kobv.de/k2?version=1.1&operation=searchRetrieve&query=rec.id%3D" "&startRecord=1&maximumRecords=10&recordSchema=marcxml&recordSchema=marcxml" ".*rec.id=(.+)" "DE-602" "https://lobid.org/resources/search?q=_exists_%3AkobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+Garten"

# OBV

bash schlagwortfolgen_harvesting_single_test.sh $Metafacture_Runner "obv" "https://services.obvsg.at/sru/OBV-PARTNER?operation=searchRetrieve&query=alma.other_system_number_035_a_exact=" "&maximumRecords=10" ".*alma.other_system_number_035_a_exact=(.+)" "AT-OBV" "https://lobid.org/resources/search?q=_exists_%3AobvId+AND+NOT+subject.type%3A%22ComplexSubject%22+AND+inCollection.id%3A%22http%3A%2F%2Flobid.org%2Forganisations%2FDE-655%23%21%22+AND+NOT+_exists_%3AzdbId+AND+philosophy"
