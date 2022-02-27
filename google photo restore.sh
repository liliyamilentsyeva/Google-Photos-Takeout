#!/bin/bash
mkdir ./restored

find . -name '*json' | while read line; do
	basepath=$(basename "$line")
	size=${#basepath}
	echo "----------------------------------------"
	echo "Processing file '$line'"
	
	# handling that google truncates filename including extension to 51 characters
	if [ "$size" == 51 ]; then
		basepathwithoutjsonextension="${basepath%.*}"
		real=$(find . -name "*${basepathwithoutjsonextension}*" ! -name '*json')
	else
		real="${line%.*}"
	fi
	
	echo "Actual file '$real'"
	folder=$(./jq -r .googlePhotosOrigin.mobileUpload.deviceFolder.localFolderName "$line")
	echo "result is $folder"
	
	empstr=""
	if [ "$folder" == "$empstr" ]; then
		folder=Empty
	fi

	mkdir -p ./restored/"$folder"
	cp "$real" ./restored/"$folder"
done