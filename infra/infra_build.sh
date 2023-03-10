#!/bin/bash 
echo "Building Docker image"

# Make it executable 
set -ex 

# Actual building of the image 
docker build -f infra.Dockerfile -t ghcr.io/infra:latest . 
