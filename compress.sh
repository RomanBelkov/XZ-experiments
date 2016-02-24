#!/bin/bash

LOG_FILE=compress_log-$(date +%Y-%m-%d-%H-%M-%S).txt 
# input_file=latest-trik-image-langs-trikboard.sdimg


images="latest-trik-image-langs-trikboard.sdimg raspbian-jessie.img WIN10_RPi.ISO WIN10_MinnowBoard.ISO"
mem="128 256 512"
binary_chain=("" --x86 --arm --armthumb)
fours="0 1 2 3 4"
mfs="bt4" #"hc3 hc4 bt2 bt3 bt4"

# exec 1> $LOG_FILE

log() {
	echo "$*</>" 1>> $LOG_FILE
}

for input_file in $images
do
	log "$input_file"
	OUTPUT_FILE=$input_file.xz
	for m in $mem 
	do
		log "$m"
		#for preset in {0..9..1} 
		#do
			#log "preset: $preset"
			for bin_ch in "${binary_chain[@]}"
			do
				log "$bin_ch"
				for lc in $fours
				do
					log "$lc"
					for lp in $fours
					do
						log "$lp"
						for pb in $fours
						do
							log "$pb"
							for mf in $mfs
							do
								log "$mf"
								for nice in 192 273
								do
									log "$nice"
									for depth in 0 512 1024
									do 
										log "$depth"
										timeout -k 1m -s 9 90m\
										 xz -zckvv "$bin_ch" \
										 --lzma2=mode=normal,dict="$m"M,lc="$lc",lp="$lp",pb="$pb",mf="$mf",nice="$nice",depth="$depth" \
										  $input_file > /dev/null 2>>$LOG_FILE

										rm -f $OUTPUT_FILE
										echo "<->" >> $LOG_FILE
									done
								done
							done
						done
					done
				done
			done
		#done
	done
done
