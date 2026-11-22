#!/bin/bash
echo
echo "Executing $0"
mkdir --parents lib
(cd lib; jar xvf ../kiosk-lib.jar)
java -Dloader.path=lib -Xdebug -Xrunjdwp:transport=dt_socket,address=8800,server=y,suspend=n -jar kiosk.jar
