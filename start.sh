#!/bin/bash

# Build Docker image
docker build -t "jupyter:typescript" .

# Run Docker container and bind port 8888
docker run -p 8888:8888 -v ./notes:/home/jovyan/notes -d "jupyter:typescript"

echo "Retriving Jupyter Notebook token..."
sleep 2

# Get container ID
container_id=$(docker ps -lq)

# Get Jupyter token
jupyter_url=$(docker logs $container_id 2>&1 | grep -o 'http://[0-9.]*:8888/lab?token=[^"]*')
jupyter_token=$(echo $jupyter_url | sed -n 's/.*token=\([^&]*\).*/\1/p')

echo "Container Id: $container_id"
echo "Jypyter Notebook is running on: http://127.0.0.1:8888"
echo "Jupyter Notebook is running with token: $jupyter_token"