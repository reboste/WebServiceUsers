# WebServiceUsers
Get Info from a Json REST API from Web Services and put result on a custom BC365 Table (using only AL language)
REST Input is https://jsonplaceholder.typicode.com/users
On BC365 compile and run :
1. open the empty page number 505100 (list of users)
2. use Action -> Execute Import From WebServices
3. The list must be populated from the Service call (see codeunit for details)