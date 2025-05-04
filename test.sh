#!/usr/bin/env sh
TOKEN=$1
REGID=$2
MAXDAYS=$3
MAXSIZE=$4

if [ "$MAXSIZE"=="" ]; then 
	MAXSIZE=1024
fi

if [ "$MAXDAYS"=="" ]; then
	MAXDAYS=7
fi


RESP=$(curl -sfSL https://container-registry.api.cloud.yandex.net/container-registry/v1/images?registryId=$REGID -H "Authorization: Bearer $TOKEN" | jq '.images[]| {id: .id, size: .compressedSize, time: .createdAt}')
if [ "$?" -ne 0 ]; then
	echo "no image exists"
	exit 1 
fi
IFS=$'\n'
IDS=( $(echo $RESP | jq -r '.id') )
TIMES=( $(echo $RESP | jq -r '.time') )
SIZES=( $(echo $RESP | jq -r '.size') )
IMGAMOUNT=${#IDS[@]}
if [ $IMGAMOUNT -eq 1 ]; then 
	echo "In registory only one image"
	exit 0
fi
IFS=$' '
SUM=0
SUM="${SUM//[$'\t\r\n ']}"
GB=$((MAXSIZE*1024*1024))
EXPIRE=$((60*60*24*MAXDAYS))
for t in ${!IDS[@]}; do
	S=${SIZES[t]}
	S="${S//[$'\t\r\n ']}"
	SUM=$((SUM+S))
	time=$(date -d ${TIMES[t]} +%s)
	now=$(date +%s)
	dif=$((now-time))
	if [ "$SUM" -gt "$GB" ] || [ "$dif" -gt "$EXPIRE" ]; then
		curl -fsSL -XDELETE https://container-registry.api.cloud.yandex.net/container-registry/v1/images/${IDS[t]} -H "Authorization: Bearer $TOKEN"
		if [ "$?" -ne 0 ]; then
			echo "image with id: ${IDS[t]} still alive"	
		else
			echo "deleted image with id: ${IDS[t]}"
		fi
	fi
done
