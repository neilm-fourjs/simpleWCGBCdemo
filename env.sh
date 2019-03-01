#!/bin/bash

GVER=$(fglrun -V 2> /dev/null | head -1 | cut -d' ' -f2 | cut -d'.' -f1-2)
case $GVER in
3.10)
  GENVER=310
  ;;
3.20)
  GENVER=320
  ;;
*)
	echo "ERROR: Genero not found or invalid version $GVER !"
esac

export GENVER

JAVAVER=$(javac -version 2> /dev/null 2>&1)
if [ $? -ne 0 ]; then
	echo "ERROR: Java compiler not found!"
fi

NODEJS=$(nodejs -v 2> /dev/null)
if [ $? -ne 0 ]; then
	echo "ERROR: NODEJS not found!"
fi

GRUNT=$(grunt -V 2> /dev/null)
if [ $? -ne 0 ]; then
	echo "ERROR: Grunt not found!"
fi

export JAVA_HOME=${JAVA_HOME:-/usr/lib/jvm/java-8-openjdk-amd64}
JVM=$(find $JAVA_HOME -name libjvm.so)
if [ $? -ne 0 ]; then
	echo "ERROR: Java VM not found!"
else
	export LD_LIBRARY_PATH=$(dirname $JVM)
fi

if [ ! -d gbc/gbc-current ]; then
	echo "Enter full path to current gbc project extract folder ?"
	read GBCDIR
	if [ ! -d $GBCDIR ] || [ ! -e $GBCDIR/VERSION ]; then
		echo "ERROR: GBC Project folder not found or invalid!"
	else
		ln -s $GBCDIR gbc/gbc-current
	fi	
fi

echo Genero is $GVER
echo Java $JAVAVER JVM is $JVM
echo GBC $(cat gbc/gbc-current/VERSION)
echo NODEJS $NODEJS + $GRUNT
