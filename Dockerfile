ARG V_JAVA="8"
FROM openjdk:$V_JAVA
LABEL   maintainer="didone@live.com"\
        os-release="Debian 10"\
        python3="3.7"\
        jdk="1.8"
ENV SPARK_HOME="/usr/local/spark"
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash - && \
    apt-get update && apt-get upgrade -y && \
    apt-get install curl wget -y && \
    apt-get install python3 python3-pip python3-pandas nodejs -y && \
    update-alternatives --install /usr/bin/python python /usr/bin/python3.7 1
RUN curl --retry 3 "https://archive.apache.org/dist/spark/spark-2.3.4/spark-2.3.4-bin-hadoop2.7.tgz" | gunzip | tar -x -C /usr/local/ && \
    ln -s /usr/local/spark-2.3.4-bin-hadoop2.7 ${SPARK_HOME}
RUN wget --quiet "https://archive.apache.org/dist/carbondata/2.1.0/apache-carbondata-2.1.0-bin-spark2.3.4-hadoop2.7.2.jar" \
    -O ${SPARK_HOME}/apache-carbondata.jar && \
    wget --quiet "https://repo1.maven.org/maven2/com/amazonaws/aws-java-sdk/1.7.4.2/aws-java-sdk-1.7.4.2.jar" \
    -O ${SPARK_HOME}/jars/aws-java-sdk.jar && \
    wget --quiet "https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-aws/2.7.2/hadoop-aws-2.7.2.jar" \
    -O ${SPARK_HOME}/jars/hadoop-aws.jar && \
    wget --quiet "https://jdbc.postgresql.org/download/postgresql-42.2.18.jar" \
    -O ${SPARK_HOME}/jars/postgresql.jar && \
    wget --quiet "https://repo1.maven.org/maven2/com/databricks/spark-avro_2.11/4.0.0/spark-avro_2.11-4.0.0.jar" \
    -O ${SPARK_HOME}/jars/spark-avro_2.jar
RUN pip3 install -U jupyterlab==3.0.0
ADD configs/*.* ${SPARK_HOME}/conf/
ENV SPARK_CONF_DIR=${SPARK_HOME}/conf\
    PATH=$PATH:${SPARK_HOME}/bin\
    PYSPARK_DRIVER_PYTHON=jupyter\
    PYSPARK_DRIVER_PYTHON_OPTS="lab --ip='*' --allow-root"
WORKDIR /home
CMD [ "pyspark" ]