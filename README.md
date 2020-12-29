# Spark for Huawei cloud

## Build
```sh
docker build -t didone/spark-carbon -f Dockerfile .
```

## Run

```sh
docker run -p 8888:8888 -v $(pwd)/data:/usr/local/spark/spark-warehouse \
    -e "AWS_ACCESS_KEY_ID=XXXXXXXXXXXXXXXXXXXX" \
    -e "AWS_SECRET_ACCESS_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" \
    -it --rm didone/spark-carbon spark-sql
```
