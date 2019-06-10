#!/bin/bash

echo "setting geo json on es: $1 "

curl -XPUT "$1/geojson" -H 'Content-Type: application/json' -d'
{
  "settings": {
    "index.mapping.ignore_malformed": true,
    "index.mapping.coerce": true
  },
  "mappings": {
    "numeric_detection": true 
  }
}'

for ((i=1; i<=5; i++)); do
    curl -H "Content-Type: application/x-ndjson" -XPOST "$1/geojson/_bulk?pretty" --data-binary @part$i.json
done
