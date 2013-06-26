#!/bin/bash

rm -fr yha/
awk -f list.awk yha.csv
cat kml1.part yha/*.part kml2.part > yha.kml

cat <(echo -n '<POI_Category Name="YHA">') yha/*.meta <(echo -n '</POI_Category>') > yha.txt
zip -q0X yha.map yha.txt
rm -f yha.txt

tr -d '\n\t' < yha.kml > doc.kml
zip -9q yha.kmz doc.kml
rm -f doc.kml

