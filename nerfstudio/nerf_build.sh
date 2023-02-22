#!/bin/bash 
echo "Building Nerf Docker image"

# Make it executable 
set -ex 

# Actual building of the image 
docker build -f nerf.Dockerfile -t ghcr.io/nerf:latest . 