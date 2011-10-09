#!/bin/bash

clientLoginUrl="https://www.google.com/accounts/ClientLogin"
first=$1
second=$2
third=$3
service=$4
tmpFile="/tmp/google-translator-toolkit-auth-token"

printHelp() {
	printf "\n%s\n" "First authenticate   :  ./client.sh -a <email@example.com> <password> <service name>"
	printf "%s\n\n" "Then send a request  :  ./client.sh [-v] \"http://translate.google.com/toolkit/feeds/documents\""
	
	printf "%s\n\n" "[OPTIONS]   -v : Verbose output - prints not only Response Body, but even request and Headers"

	printf  "%-30s %s\n" \
	" gtrans" "Google Translator Toolkit" \
	" analytics" "Google Analytics Data APIs" \
	" apps" "Google Apps APIs" \
	" jotspot" "Google Sites Data API" \
	" blogger" "Blogger Data API" \
	" print" "Book Search Data API" \
	" cl" "Calendar Data API" \
	" codesearch" "Google Code Search Data API" \
	" cp" "Contacts Data API" \
	" structuredcontent" "Content API for Shopping"\
	" writely" "Documents List Data API" \
	" finance" "Finance Data API" \
	" mail" "Gmail Atom feed" \
	" health" "Health Data API" \
	" local" "Maps Data APIs" \
	" lh2" "Picasa Web Albums Data API" \
	" annotateweb" "Sidewiki Data API" \
	" wise" "Spreadsheets Data API" \
	" sitemaps" "Webmaster Tools API" \
	" youtube" "YouTube Data API" 
}

auth() {
	authStatusCode=$(curl --write-out %{http_code} --silent --output "$tmpFile" "$clientLoginUrl" --data-urlencode Email="$second" --data-urlencode Passwd="$third" -d accountType=GOOGLE -d source=GTT-BUG -d service="$service")
	authResponse=$(<$tmpFile) 
	authToken="${authResponse##*=}"
	echo "$authToken" > "$tmpFile"
	if [ "$authStatusCode" == 200 ]
	then
		printf "%s\n" "Http Status Code : $authStatusCode" "We're good to go !"
	else
		printf "%s\n\n" "Http Status Code : $authStatusCode" "What the hell ?"
		printf "%s\n" "$authResponse"
	fi
}

checkArgs() {
	if [[ "$first" = "-a" && -n "$second" && -n "$third" && -n "$service" ]] 
	then
		authentication=1
	elif [[ "$first" == http* || "$second" == http* ]]
	then
		[[ "$second" == http* ]] && [[ "$first" == "-v" ]] && verbose=1 && url="$second"
		[[ "$first" == http* ]] && [[ "$second" == "-v" ]] && verbose=1 && url="$first"
		[[ "$first" == http* ]] && [[ -z "$second" ]] && verbose=0 && url="$first"
		[[ "$url" != http* ]] && printHelp
		request=1
	else
		printHelp
		exit 1
	fi
}

checkArgs

if [[ -n "$authentication" && "$authentication" -eq 1 ]]
then
	auth
elif [[ -n "$request" && "$request" -eq 1 ]]
then
	if [ ! -f "$tmpFile" ]
	then
		printHelp
	else
    	authToken=$(<$tmpFile)
		if [[ "$verbose" -eq 1 ]]
		then
			curl --silent --verbose --header "Authorization: GoogleLogin auth=${authToken}" "$url" | tidy -xml -indent -quiet
		else
			curl --silent --header "Authorization: GoogleLogin auth=${authToken}" "$url" | tidy -xml -indent -quiet
		fi
	fi
else
	echo "you are on your own !"
fi
