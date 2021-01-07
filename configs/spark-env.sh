echo -e "
spark.hadoop.fs.s3a.endpoint obs.${REGION}.myhuaweicloud.com
spark.sql.warehouse.dir s3a://${BUCKET}/warehouse
" >> ${SPARK_HOME}/conf/spark-defaults.conf
export SPARK_CLASSPATH="$SPARK_CLASSPATH:$SPARK_HOME/carbonlib"
export HIVE_SERVER2_THRIFT_BIND_HOST=0.0.0.0
export HIVE_SERVER2_THRIFT_PORT=10001
export AWS_ACCESS_KEY_ID=$ACCESS_KEY
export AWS_SECRET_ACCESS_KEY=$SECRET_KEY
export ALL_MEMORY=$(vmstat -s -S m | grep "total memory" | grep -E [0-9]+ -o)
export SPARK_OPTS=$(echo "--driver-java-options=-Xms${ALL_MEMORY}M \
                          --driver-java-options=-Xmx${ALL_MEMORY}M \
                          --driver-java-options=-Dlog4j.logLevel=info")
