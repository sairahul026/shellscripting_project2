#!/bin/bash
################################
below if statement is used to check a condition that user should give atleast two parameters
i.e github token and rest api url $0 indicates the present script
################################

if [ ${#@} -lt 2 ]; then
    echo "usage: $0 [enter your github token] [provide REST api expression]"
    exit 1;
fi

#there vairables takes the user input values as parameters
GITHUB_TOKEN=$1
GITHUB_API_REST=$2

#thebekow expression is used to get information from github in json format
GITHUB_API_HEADER_ACCEPT="Accept: application/vnd.github.v3+json"

temp=`basename $0`
#below commands creates a temporary file to store the output details of this script
TMPFILE=`mktemp /tmp/${temp}.XXXXXX` || exit 1

#defining a function for api call
function rest_call {
    curl -s $1 -H "${GITHUB_API_HEADER_ACCEPT}" -H "Authorization: token $GITHUB_TOKEN" >> $TMPFILE
}

# single page result-s (no pagination), have no Link: section, the grep result is empty
last_page=`curl -s -I "https://api.github.com${GITHUB_API_REST}" -H "${GITHUB_API_HEADER_ACCEPT}" -H "Authorization: token $GITHUB_TOKEN" | grep '^Link:' | sed -e 's/^Link:.*page=//g' -e 's/>.*$//g'`


printing the output in tempfile using cat command

cat $TMPFILE
