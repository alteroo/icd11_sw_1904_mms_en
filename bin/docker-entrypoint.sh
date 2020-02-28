#!/bin/bash

echo "API URL: $APIBASEDURL"
sed -i "s@\"apiBaseUrl\"\:\s\"http\:\/\/localhost\"@\"apiBaseUrl\": \"$APIBASEDURL\"@g"  /usr/share/icd11/codingtool/appsettings.Container.json

/startICDApps.sh