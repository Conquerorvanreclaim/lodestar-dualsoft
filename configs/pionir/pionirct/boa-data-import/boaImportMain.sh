#!/bin/bash
option=$1 #koja operacija ce biti izvrsena nad import skriptom (start/stop/install)
shift
while [ "$*" != "" ]
do
  channelCode=$1
  shift
  channelType=$1
  shift
  if [ -z "$1" -o "$1" == " " ]; then
    configFileName="config.xml"
    jarFile="/usr/local/boaimport/data/boa-data-import-old.jar"
  elif [[ "$1" == *"config"* ]]; then
    configFileName=$1
    jarFile="/usr/local/boaimport/data/boa-data-import.jar"
    shift
  else
    configFileName="config.xml"
    jarFile="/usr/local/boaimport/data/boa-data-import-old.jar"
  fi

  /usr/local/boaimport/boaImportProcess.sh $jarFile $channelCode $channelType $configFileName $option
#echo  /data/boaimport/boaImportProcess.sh $jarFile $channelCode $channelType $configFileName $option


done
