#!/bin/bash

i=0
out_dir="";
time_out=0;
seperator="\t";
while getopts ":o:t:s:" opt; do
  case $opt in
    o)
      out_dir=$OPTARG"/" >&2
      ;;
    t)
      time_out=$OPTARG >&2
      ;;
    s)
      seperator=$OPTARG >&2
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      ;;
  esac
done
shift $((OPTIND-1))

mkdir -p "imgs/ff/"
mkdir -p "imgs/chrome/"

while read url; do
	echo -e "${url}${seperator}${out_dir}${i}.png"

	#xvfb-run -a cutycapt --url=${line} --out="./imgs/"${i}".png"

    if [ "${time_out}" -gt "0" ]; then
        curl -s --max-time "${time_out}" "${url}" >/dev/null \
        && wkhtmltoimage -q "${url}" "${out_dir}${i}.png" 2>/dev/null
    else
        wkhtmltoimage -q "${url}" "${out_dir}${i}.png" 2>/dev/null
    fi
	
    i=$((i+1))
done < "${1:-/dev/stdin}"