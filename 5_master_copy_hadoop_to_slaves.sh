#!/bin/bash

echo "How many slaves?"
read SlavesNumber

echo "Enter Slaves hostname in a seperated line:"
for i in `seq 1 $SlavesNumber`;
do
	read SlaveHostName[i]
	echo "next:"
done


for i in `seq 1 $SlavesNumber`; 
do
	echo "i equals to $i"
	scp -r /usr/local/hadoop ${SlaveHostName[i]}:/usr/local
done

HADOOP_HOME=/usr/local/hadoop
JAVA_HOME=/usr/lib/jvm/java-7-oracle/jre

#$HADOOP_HOME/bin/hadoop namenode -format

echo "export HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_HOME}/lib/native" >> $HADOOP_HOME/etc/hadoop/yarn-env.sh
echo "export HADOOP_OPTS=\"-Djava.library.path=${HADOOP_HOME}/lib\"" >> $HADOOP_HOME/etc/hadoop/yarn-env.sh
echo "export HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_HOME}/lib/native" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
echo "export HADOOP_OPTS=\"-Djava.library.path=${HADOOP_HOME}/lib\"" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh
	
source ~/.bashrc
