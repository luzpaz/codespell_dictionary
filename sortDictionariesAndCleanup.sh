#!/bin/bash
WORKINGDIR=$(dirname $(readlink -f $0))
# sort the english dictionary file
cat dictionary_en.txt > dictionary_tmp.txt
cat dictionary_tmp.txt | sort | uniq > dictionary_en.txt
# remove trailing blanks on each line
sed 's/[[:blank:]]*$//' -i dictionary_en.txt
# convert upper case to lower case letters
sed 's/\([A-Z]\)/\L\1/g' -i dictionary_en.txt
# remove duplicate lines
uniq dictionary_en.txt dictionary_tmp.txt
mv dictionary_tmp.txt dictionary_en.txt

# sort the german dictionary file
cat dictionary_de.txt > dictionary_tmp.txt
cat dictionary_tmp.txt | sort | uniq > dictionary_de.txt
# remove trailing blanks on each line
sed 's/[[:blank:]]*$//' -i dictionary_de.txt
rm dictionary_tmp.txt

# sort the generated dictionary file
cat dictionary_generated.txt > dictionary_tmp.txt
cat dictionary_tmp.txt | sort | uniq > dictionary_generated.txt
# remove trailing blanks on each line
sed 's/[[:blank:]]*$//' -i dictionary_generated.txt
# convert upper case to lower case letters
sed 's/\([A-Z]\)/\L\1/g' -i dictionary_generated.txt
uniq dictionary_generated.txt dictionary_tmp.txt
# remove duplicate lines
mv dictionary_tmp.txt dictionary_generated.txt

# Merge all dictionary files
cat ${WORKINGDIR}/dictionary_all.txt > ${WORKINGDIR}/dictionary_tmp.txt
cat ${WORKINGDIR}/dictionary_en.txt >> ${WORKINGDIR}/dictionary_tmp.txt
cat ${WORKINGDIR}/dictionary_generated.txt >> ${WORKINGDIR}/dictionary_tmp.txt
# include dictionary from codespell
cd ${WORKINGDIR}/codespell_git/codespell/
git stash
git pull
make sort-dictionary
cat ${WORKINGDIR}/codespell_git/codespell/codespell_lib/data/dictionary.txt >> ${WORKINGDIR}/dictionary_tmp.txt
cd ${WORKINGDIR}
cat ${WORKINGDIR}/dictionary_tmp.txt | sort | uniq > ${WORKINGDIR}dictionary_all.txt
# remove trailing blanks on each line
sed 's/[[:blank:]]*$//' -i ${WORKINGDIR}/dictionary_all.txt
# convert upper case to lower case letters
sed 's/\([A-Z]\)/\L\1/g' -i ${WORKINGDIR}/dictionary_all.txt
