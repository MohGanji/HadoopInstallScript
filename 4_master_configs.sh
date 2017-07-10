#!/bin/bash

### Set up environment variables
echo "export JAVA_HOME=/usr/lib/jvm/java-7-oracle/jre" >> ~/.bashrc
JAVA_HOME=/usr/lib/jvm/java-7-oracle/jre
echo "export PATH=$PATH:$JAVA_HOME/bin" >> ~/.bashrc
echo "export HADOOP_HOME=/usr/local/hadoop" >> ~/.bashrc
HADOOP_HOME=/usr/local/hadoop
echo "export PATH=$PATH:${HADOOP_HOME}/bin" >> ~/.bashrc
echo "export PATH=$PATH:${HADOOP_HOME}/sbin" >> ~/.bashrc
echo "export HADOOP_MAPRED_HOME=${HADOOP_HOME}" >> ~/.bashrc
HADOOP_MAPRED_HOME=${HADOOP_HOME}
echo "export HADOOP_COMMON_HOME=${HADOOP_HOME}" >> ~/.bashrc
HADOOP_COMMON_HOME=${HADOOP_HOME}
echo "export HADOOP_HDFS_HOME=${HADOOP_HOME}" >> ~/.bashrc
HADOOP_HDFS_HOME=${HADOOP_HOME}
echo "export YARN_HOME=${HADOOP_HOME}" >> ~/.bashrc
YARN_HOME=${HADOOP_HOME}
echo "export HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_HOME}/lib/native" >> ~/.bashrc
HADOOP_OPTS="$HADOOP_OPTS -Djava.library.path=${HADOOP_HOME}/lib/native"
echo "export HADOOP_OPTS=\"$HADOOP_OPTS -Djava.library.path=${HADOOP_HOME}/lib/native\"" >> ~/.bashrc

HADOOP_COMMON_LIB_NATIVE_DIR=${HADOOP_HOME}/lib/native
echo "export HADOOP_OPTS=\"-Djava.library.path=${HADOOP_HOME}/lib\"" >> ~/.bashrc
echo "export CLASSPATH=$CLASSPATH:/usr/local/hadoop/lib/*:." >> ~/.bashrc
CLASSPATH=$CLASSPATH:/usr/local/hadoop/lib/*:.
echo "export HADOOP_OPTS=\"${HADOOP_OPTS} -Djava.security.egd=file:/dev/../dev/urandom\"" >> ~/.bashrc
HADOOP_PREFIX=/usr/local/hadoop
echo "export HADOOP_PREFIX=/usr/local/hadoop" >> ~/.bashrc

source ~/.bashrc



hadoop_core_xml_conf="<?xml version=\"1.0\" encoding=\"UTF-8\"?>
	<?xml-stylesheet type=\"text/xsl\" href=\"configuration.xsl\"?>
	<configuration>
	<property>
	<name>fs.defaultFS</name>
	<value>hdfs://NameNode:8020/</value>
	</property>
	<property>
	<name>io.file.buffer.size</name>	
	<value>131072</value>
	</property>
	</configuration>"
#touch $HADOOP_HOME/etc/hadoop/core-site.xml
echo $hadoop_core_xml_conf > ${HADOOP_HOME}/etc/hadoop/core-site.xml
## hdfs-site.xml
hadoop_hdfs_site_xml="<?xml version=\"1.0\"?>
	<!-- hdfs-site.xml -->
	<configuration>
	<property>
	<name>dfs.namenode.name.dir</name>
	<value>file:/usr/local/hadoop_work/hdfs/namenode</value>
	</property>
	<property>
	<name>dfs.datanode.data.dir</name>
	<value>file:/usr/local/hadoop_work/hdfs/datanode</value>
	</property>
	<property>
	<name>dfs.namenode.checkpoint.dir</name>
	<value>file:/usr/local/hadoop_work/hdfs/namesecondary</value>
	</property>
	<property>
	<name>dfs.replication</name>
	<value>2</value>
	</property>
	<property>
	<name>dfs.block.size</name>
	<value>134217728</value>
	</property>
	</configuration>"
#touch $HADOOP_HOME/etc/hadoop/hdfs-site.xml
echo $hadoop_hdfs_site_xml > ${HADOOP_HOME}/etc/hadoop/hdfs-site.xml
## mapred-site.xml
cp $HADOOP_HOME/etc/hadoop/mapred-site.xml.template $HADOOP_HOME/etc/hadoop/mapred-site.xml
hadoop_mapred_site_xml="<?xml version=\"1.0\"?>
	<!-- mapred-site.xml -->
	<configuration>
	<property>
	<name>mapreduce.framework.name</name>
	<value>yarn</value>
	</property>
	<property>
	<name>mapreduce.jobhistory.address</name>
	<value>NameNode:10020</value>
	</property>
	<property>
	<name>mapreduce.jobhistory.webapp.address</name>
	<value>NameNode:19888</value>
	</property>
	<property>
	<name>yarn.app.mapreduce.am.staging-dir</name>
	<value>/user/app</value>
	</property>
	<property>
	<name>mapred.child.java.opts</name>
	<value>-Djava.security.egd=file:/dev/../dev/urandom</value>
	</property>
	</configuration>"
echo $hadoop_mapred_site_xml > ${HADOOP_HOME}/etc/hadoop/mapred-site.xml
## yarn-site.xml
hadoop_yarn_site_xml="<?xml version=\"1.0\"?>
	<!-- yarn-site.xml -->
	<configuration>
	<property>
	<name>yarn.resourcemanager.hostname</name>
	<value>NameNode</value>
	</property>
	<property>
	<name>yarn.resourcemanager.bind-host</name>
	<value>0.0.0.0</value>
	</property>
	<property>
	<name>yarn.nodemanager.bind-host</name>
	<value>0.0.0.0</value>
	</property>
	<property>
	<name>yarn.nodemanager.aux-services</name>
	<value>mapreduce_shuffle</value>
	</property>
	<property>
	<name>yarn.nodemanager.aux-services.mapreduce_shuffle.class</name>
	<value>org.apache.hadoop.mapred.ShuffleHandler</value>
	</property>
	<property>
	<name>yarn.log-aggregation-enable</name>
	<value>true</value>
	</property>
	<property>
	<name>yarn.nodemanager.local-dirs</name>
	<value>file:/usr/local/hadoop_work/yarn/local</value>
	</property>
	<property>
	<name>yarn.nodemanager.log-dirs</name>
	<value>file:/usr/local/hadoop_work/yarn/log</value>
	</property>
	<property>
	<name>yarn.nodemanager.remote-app-log-dir</name>
	<value>hdfs://NameNode:8020/var/log/hadoop-yarn/apps</value>
	</property>
	</configuration>"
echo $hadoop_yarn_site_xml > ${HADOOP_HOME}/etc/hadoop/yarn-site.xml

hadoop_env_conf=""
cat ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh > hadoop_env_conf
echo "JAVA_HOME=/usr/lib/jvm/java-7-oracle/jre" > ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh
cat hadoop_env_conf >> ${HADOOP_HOME}/etc/hadoop/hadoop-env.sh

### Set up master
touch $HADOOP_HOME/etc/hadoop/masters
echo "${NAME}" > $HADOOP_HOME/etc/hadoop/masters
