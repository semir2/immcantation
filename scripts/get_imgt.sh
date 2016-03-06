#!/bin/bash

# IMGT Gapped Germlines
REPERTOIRE="IMGT"

# Associative array where keys are species folder names and values are query strings
declare -A SPECIES_QUERY
SPECIES_QUERY[Human]="Homo+sapiens"
SPECIES_QUERY[Mouse]="Mus"

# Associative a
declare -A SPECIES_REPLACE
SPECIES_REPLACE[Human]='s/Homo sapiens/Homo_sapiens/g'
SPECIES_REPLACE[Mouse]='s/Mus musculus/Mus_musculus/g'

# For each species
for KEY in ${!SPECIES_QUERY[@]}
do
	echo "Downloading ${KEY} repertoires..."

	# Download VDJ
	echo "|- VDJ regions"
    FILE_PATH="${REPERTOIRE}/${KEY}/VDJ"
    mkdir -p $FILE_PATH

    # VDJ Ig
    echo "|---- Ig"
    for CHAIN in IGHV IGHD IGHJ IGKV IGKJ IGLV IGLJ
    do
        URL="http://www.imgt.org/IMGT_GENE-DB/GENElect?query=7.14+${CHAIN}&species=${SPECIES_QUERY[${KEY}]}"
        FILE_NAME="${FILE_PATH}/${REPERTOIRE}_${KEY}_${CHAIN}.fasta"
        TMP_FILE="${FILE_NAME}.tmp"
        #echo $URL
        wget $URL -O $TMP_FILE -q
        awk '/<pre>/{i++}/<\/pre>/{j++}{if(j==2){exit}}{if(i==2 && j==1 && $0!="<pre>"){print}}' $TMP_FILE > $FILE_NAME
        sed -i "${SPECIES_REPLACE[${KEY}]}" $FILE_NAME
        rm $TMP_FILE
    done

    # VDJ TCR
    echo "|---- TCR"
    for CHAIN in TRAV TRAJ TRBV TRBD TRBJ TRDV TRDD TRDJ TRGV TRGJ
    do
        URL="http://www.imgt.org/IMGT_GENE-DB/GENElect?query=7.14+${CHAIN}&species=${SPECIES_QUERY[${KEY}]}"
        FILE_NAME="${FILE_PATH}/${REPERTOIRE}_${KEY}_${CHAIN}.fasta"
        TMP_FILE="${FILE_NAME}.tmp"
        #echo $URL
        wget $URL -O $TMP_FILE -q
        awk '/<pre>/{i++}/<\/pre>/{j++}{if(j==2){exit}}{if(i==2 && j==1 && $0!="<pre>"){print}}' $TMP_FILE > $FILE_NAME
        sed -i "${SPECIES_REPLACE[${KEY}]}" $FILE_NAME
        rm $TMP_FILE
    done


	# Download leaders
    echo "|- Spliced leader regions"
    FILE_PATH="${REPERTOIRE}/${KEY}/Leader"
    mkdir -p $FILE_PATH

    # Leader Ig
    echo "|---- Ig"
    for CHAIN in IGH IGK IGL
    do
        URL="http://www.imgt.org/IMGT_GENE-DB/GENElect?query=8.1+${CHAIN}V&species=${SPECIES_QUERY[${KEY}]}&IMGTlabel=L-PART1+L-PART2"
        FILE_NAME="${FILE_PATH}/${REPERTOIRE}_${KEY}_${CHAIN}L.fasta"
        TMP_FILE="${FILE_NAME}.tmp"
        #echo $URL
        wget $URL -O $TMP_FILE -q
        awk '/<pre>/{i++}/<\/pre>/{j++}{if(j==2){exit}}{if(i==2 && j==1 && $0!="<pre>"){print}}' $TMP_FILE > $FILE_NAME
        sed -i "${SPECIES_REPLACE[${KEY}]}" $FILE_NAME
        rm $TMP_FILE
    done

    # Leader TCR
    echo "|---- TCR"
    for CHAIN in TRA TRB TRG TRD
    do
        URL="http://www.imgt.org/IMGT_GENE-DB/GENElect?query=8.1+${CHAIN}V&species=${SPECIES_QUERY[${KEY}]}&IMGTlabel=L-PART1+L-PART2"
        FILE_NAME="${FILE_PATH}/${REPERTOIRE}_${KEY}_${CHAIN}L.fasta"
        TMP_FILE="${FILE_NAME}.tmp"
        #echo $URL
        wget $URL -O $TMP_FILE -q
        awk '/<pre>/{i++}/<\/pre>/{j++}{if(j==2){exit}}{if(i==2 && j==1 && $0!="<pre>"){print}}' $TMP_FILE > $FILE_NAME
        sed -i "${SPECIES_REPLACE[${KEY}]}" $FILE_NAME
        rm $TMP_FILE
    done


	# Download constant regions
    echo "|- Spliced constant regions"
    FILE_PATH="${REPERTOIRE}/${KEY}/Constant/"
    mkdir -p $FILE_PATH

    # Constant Ig
    echo "|---- Ig"
    for CHAIN in IGHC IGKC IGLC
    do
        URL="http://www.imgt.org/IMGT_GENE-DB/GENElect?query=14.1+${CHAIN}&species=${SPECIES_QUERY[${KEY}]}"
        FILE_NAME="${FILE_PATH}/${REPERTOIRE}_${KEY}_${CHAIN}.fasta"
        TMP_FILE="${FILE_NAME}.tmp"
        #echo $URL
        wget $URL -O $TMP_FILE -q
        awk '/<pre>/{i++}/<\/pre>/{j++}{if(j==2){exit}}{if(i==2 && j==1 && $0!="<pre>"){print}}' $TMP_FILE > $FILE_NAME
        sed -i "${SPECIES_REPLACE[${KEY}]}" $FILE_NAME
        rm $TMP_FILE
    done

    # Constant for TCR
    echo "|---- TCR"
    for CHAIN in TRAC TRBC TRGC TRDC
    do
        URL="http://www.imgt.org/IMGT_GENE-DB/GENElect?query=14.1+${CHAIN}&species=${SPECIES_QUERY[${KEY}]}"
        FILE_NAME="${FILE_PATH}/${REPERTOIRE}_${KEY}_${CHAIN}.fasta"
        TMP_FILE="${FILE_NAME}.tmp"
        #echo $URL
        wget $URL -O $TMP_FILE -q
        awk '/<pre>/{i++}/<\/pre>/{j++}{if(j==2){exit}}{if(i==2 && j==1 && $0!="<pre>"){print}}' $TMP_FILE > $FILE_NAME
        sed -i "${SPECIES_REPLACE[${KEY}]}" $FILE_NAME
        rm $TMP_FILE
    done

    echo ""

done
