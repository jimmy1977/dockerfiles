#!/bin/bash 
echo "Building a Release Docker image"

# Make it executable 
set -ex 

# Pull the latest 
git pull 

# Bump Version 
# docker run --rm -v "$PWD":/release ghrc.io/infra patch
version=`cat $PWD/infra/VERSION`
echo "version: $version"

# Actual building of the image 
# . ./$PWD/infra/infra_build.sh 
docker build -f $PWD/infra/infra.Dockerfile -t ghcr.io/infra:latest . 

# Tag the build 
git add -A 
git commit -m "version $version"
git tag -a "$version" -m "version $version"
git push 
git push --tags 

# Tag the image 
docker tag ghcr.io/infra:latest ghcr.io/infra:$version 

# Push it to github 
docker push ghcr.io/infra:$version 
