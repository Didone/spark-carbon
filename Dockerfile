ARG V_JAVA="8"
FROM openjdk:$V_JAVA
LABEL   maintainer="didone@live.com"\
        os-release="Debian 10"\
        python2="2.7"\
        python3="3.7"\
        jdk="1.8"
ARG SPARK_REPO="https://archive.apache.org/dist/spark/spark-2.4.5/spark-2.4.5-bin-hadoop2.7.tgz"
ARG MAVEN_REPO="https://downloads.apache.org/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.tar.gz"
ARG THRIFT_REPO="http://archive.apache.org/dist/thrift/0.9.3/thrift-0.9.3.tar.gz"
ENV SPARK_HOME="/usr/local/spark"\
    MAVEN_HOME="/usr/local/maven"\
    THRIFT_HOME="/usr/local/thrift"
ENV SPARK_CONF_DIR=${SPARK_HOME}/conf\
    PATH=$PATH:${SPARK_HOME}/bin:${MAVEN_HOME}/bin
RUN apt-get update && apt-get upgrade -y &&\
    apt-get install curl wget -y &&\
    apt-get install python3 python3-pip -y &&\
    curl --retry 3 "${SPARK_REPO}" | gunzip | tar -x -C /usr/local/ &&\
    ln -s /usr/local/spark-2.4.5-bin-hadoop2.7 ${SPARK_HOME} &&\
    curl --retry 3 "${MAVEN_REPO}" | gunzip | tar -x -C /usr/local/ &&\
    ln -s /usr/local/apache-maven-3.6.3 ${MAVEN_HOME} &&\
    curl --retry 3 "${THRIFT_REPO}" | gunzip | tar -x -C /usr/local/ &&\
    cd /usr/local/thrift-0.9.3 &&\
    ./configure && make &&\
    make install
WORKDIR /usr/local/carbondata
RUN git clone https://github.com/apache/carbondata.git /usr/local/ &&\
    ./build/carbondata-build-info.sh 2.0.1 &&\
    mvn -DskipTests -Pspark-2.4.5 clean package &&\
    mkdir -p $SPARK_HOME/carbonlib &&\
    cp assembly/target/scala-2.11/apache-carbondata-2.1.1*.jar $SPARK_HOME/carbonlib
# RUN conf/carbon.properties.template $SPARK_HOME/conf/carbon.properties
# RUN cp $SPARK_HOME/conf/spark-defaults.conf.template $SPARK_HOME/conf/spark-defaults.conf
# RUN echo "spark.driver.extraJavaOptions -Dcarbon.properties.filepath = $SPARK_HOME/conf/carbon.properties"   >> $SPARK_HOME/conf/spark-defaults.conf
# RUN echo "spark.executor.extraJavaOptions -Dcarbon.properties.filepath = $SPARK_HOME/conf/carbon.properties" >> $SPARK_HOME/conf/spark-defaults.conf
# RUN cp $SPARK_HOME/conf/spark-env.sh.template $SPARK_HOME/conf/spark-env.sh
# RUN echo "SPARK_CLASSPATH=$SPARK_HOME/carbonlib/*" >> $SPARK_HOME/conf/spark-env.sh