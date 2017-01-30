#!/bin/bash

cd ~;
home_path=`pwd`;
cd - >/dev/null;

chrome_db="${home_path}/Library/Application Support/Google/Chrome/Default/History";
ff_db="${home_path}/Library/Application Support/Firefox/Profiles/i314wrhh.default/places.sqlite"

#echo "chrome_db: ${chrome_db}";
#echo "ff_db: ${ff_db}";

function check_query_return_val(){
    browser=$1;
    return_code=$2;

    if [ "${return_code}" -eq "0" ]; then
        echo "Succesfully pulled ${browser} history...";
    elif [ "${return_code}" -eq "5" ]; then
        echo "ERROR: The chrome db was locked, please kill all running ${browser} applications!  (You have to quit the app, not just close it)."
        exit;
    else
        echo "Something broke dick on the query. nuts.";
        end;
    fi
}

if [ -e "${chrome_db}" ]; then
   
    sqlite3 "${chrome_db}" "SELECT url FROM urls ORDER BY last_visit_time DESC" | awk '!x[$0]++' > "data/chrome_default_history.data"
    return_code="$?";
    check_query_return_val "Chrome" "${return_code}";
fi

if [ -e "${ff_db}" ]; then

    sqlite3 "${ff_db}" "SELECT url FROM moz_places JOIN moz_historyvisits ON place_id=moz_historyvisits.id" 2>/dev/null | awk '!x[$0]++' > "data/ff_default_history.data"
    return_code="$?";
    check_query_return_val "Fire Fox" "${return_code}";
fi