#!/bin/bash

echo "API URL: $API_BASE_URL"
sed -i "s@\"apiBaseUrl\"\:\s\"http\:\/\/localhost\"@\"apiBaseUrl\": \"$API_BASE_URL\"@g"  /usr/share/icd11/codingtool/appsettings.Container.json

/startICDApps.sh
