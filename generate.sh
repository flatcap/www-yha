#!/bin/bash

rm -fr tmp/
awk -f list.awk < yha.uk.csv
cat kml1.part tmp/*.part kml2.part > yha.uk.kml

#cat <(echo -n '<POI_Category Name="YHA">') tmp/*.meta <(echo -n '</POI_Category>') > yha.uk.txt
#zip -q0X yha.uk.map yha.uk.txt
#rm -f yha.uk.txt

tr -d '\n\t' < yha.uk.kml > doc.kml
zip -9q yha.uk.kmz doc.kml
rm -f doc.kml

