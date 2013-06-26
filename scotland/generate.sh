#!/bin/bash

rm -fr yha/
awk -f list.awk < syha.csv
cat kml1.part yha/*.part kml2.part > syha.kml

cat <(echo -n '<POI_Category Name="SYHA">') yha/*.meta <(echo -n '</POI_Category>') > syha.txt
zip -q0X syha.map syha.txt
rm -f syha.txt

tr -d '\n\t' < syha.kml > doc.kml
zip -9q syha.kmz doc.kml
rm -f doc.kml

