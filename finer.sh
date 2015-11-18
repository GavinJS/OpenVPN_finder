#!/opt/local/bin/bash
FTIME=1000
HOST=NULL
FHOST=NULL

for f in *.ovpn; do
	#echo $f
	#echo ""
	HOST=$(grep --ignore-case --word-regexp "remote" "$f" | grep -v 'remote-' | cut -d\  -f 2)
	TIME=$(ping -c 10 -ni 0.3 -Qq $HOST | grep "round-trip" | cut -d\  -f 4 | cut -d\/ -f 2)

	echo "----- Testing: "$HOST" -----"
	echo "Average Response Time: "$TIME
	echo "Fastest Response Time: "$FTIME
	echo "Fastest Host: "$FHOST
	#echo $TIME
	#awk -v n1=100 -v n2=1000 'BEGIN { n1 < n2 }'
	if [[ $(awk -v n1=$TIME -v n2=$FTIME 'BEGIN { print (n1<n2)?1:0 }') -eq 1 ]]; then
		#echo "Awk*** " $(awk -v n1=$TIME -v n2=$FTIME 'BEGIN { print (n1<n2)?1:0 }')
		FTIME=$TIME
		FHOST=$HOST
	fi
	#if (($TIME < $FTIME )); then
	#	FHOST=$HOST
	#fi
	#echo "Host: "$HOST" - "$TIME" \n Fastest Host: "$FHOST
	echo
	echo
done