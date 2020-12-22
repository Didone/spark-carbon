import org.apache.spark.sql.SparkSession
import org.apache.spark.sql.CarbonSession._

val carbon = SparkSession.builder().config(sc.getConf).enableHiveSupport.config("spark.sql.extensions","org.apache.spark.sql.CarbonExtensions").getOrCreate()
carbon.sql("show tables in default").show()
carbon.sql("create table hive_carbon(id int, name string) STORED AS carbon")
carbon.sql("show tables in default").show()
