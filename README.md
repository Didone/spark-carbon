# Spark for Huawei cloud

## Build
```sh
docker build -t didone/spark-carbon -f Dockerfile .
```

## Run

```sh
docker run -it --rm \
        --env-file .env \
        -p 8888:8888 \
        -p 4040:4040 \
        -v $(pwd)/demo:/home \
        didone/spark-carbon
```

```log
[C 2021-01-07 14:34:37.021 ServerApp]
    To access the server, open this file in a browser:
        file:///root/.local/share/jupyter/runtime/jpserver-1-open.html
    Or copy and paste one of these URLs:
        http://084b502fc1c8:8888/lab?token=18a178a9eddaccd0d994116ef7bd3295bb28418f95308855
     or http://127.0.0.1:8888/lab?token=18a178a9eddaccd0d994116ef7bd3295bb28418f95308855
```

### Environment File

In your current directory, create a `.env` with your cloud storage credentials

```conf
# Storage
BUCKET=bucket_name
REGION=la-south-2
ACCESS_KEY=XXXXXXXXXXXXXXXXXXXX
SECRET_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```