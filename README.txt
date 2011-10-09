This is just a simple shell script for client authentication, requesting various Googla APIs with cURL and formatting output 

First authenticate   :  ./client.sh -a <email@example.com> <password> <service name>
Then send a request  :  ./client.sh [-v] "http://translate.google.com/toolkit/feeds/documents"

[OPTIONS]   -v : Verbose output - prints not only Response Body, but even request and Headers

 gtrans                        Google Translator Toolkit
 analytics                     Google Analytics Data APIs
 apps                          Google Apps APIs
 jotspot                       Google Sites Data API
 blogger                       Blogger Data API
 print                         Book Search Data API
 cl                            Calendar Data API
 codesearch                    Google Code Search Data API
 cp                            Contacts Data API
 structuredcontent             Content API for Shopping
 writely                       Documents List Data API
 finance                       Finance Data API
 mail                          Gmail Atom feed
 health                        Health Data API
 local                         Maps Data APIs
 lh2                           Picasa Web Albums Data API
 annotateweb                   Sidewiki Data API
 wise                          Spreadsheets Data API
 sitemaps                      Webmaster Tools API
 youtube                       YouTube Data API
