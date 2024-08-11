#!/bin/bash

# 检查是否提供了镜像名称
if [ -z "$1" ]; then
  echo "Usage: $0 <image_name>"
  exit 1
fi

ORIGINAL_IMAGE=$1
param2=$2
NEW_IMAGE=${param2%-*}
TAG="2024-6-5"
# 运行容器并安装 protobuf
CONTAINER_ID=$(docker run -d $ORIGINAL_IMAGE sleep infinity)
docker exec $CONTAINER_ID sh -c "pip install protobuf && pip cache purge"
if [ $? != 0 ];then
	echo "The update failed!!!"
	docker stop $CONTAINER_ID
	echo "The container has been stopped"
	docker rm $CONTAINER_ID
	echo "The container has been deleted"
	exit 1
fi 

# 提交容器为新的镜像
docker commit $CONTAINER_ID $NEW_IMAGE:$TAG

# 停止并删除容器
docker stop $CONTAINER_ID
echo "The container has been stopped"
docker rm $CONTAINER_ID
echo "The container has been deleted"

docker save -o nginx.tar $NEW_IMAGE:$TAG
echo "The new image has been saved"

# 删除原始镜像
docker rmi roderickchan/debug_pwn_env:$2
echo "The container has been deletedi"

docker load -i ./nginx.tar

rm -f ./nginx.tar

echo "New image created: $NEW_IMAGE"
echo "Original image $ORIGINAL_IMAGE has been deleted."

