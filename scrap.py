from bs4 import BeautifulSoup
import requests
import random
import re

def function(url):	
	# here, we fetch the content from the url, using the requests library
	page_response = requests.get(url, timeout=5)
	#we use the html parser to parse the url content and store it in a variable.
	soup = BeautifulSoup(page_response.content, "html.parser")
	#opening the output file
	f= open("List_of_hotels.txt","a", encoding="utf-8")
	#looping through all <ul> </ul> tag where class : none
	for ultag in soup.find_all('ul',attrs={'class': None}):
		#looping through all <li> </li> tag under each <ul> </ul> tag
		for litag in ultag.find_all('li'): 
			#passing hotel names with address from website to variable
			hotelsWithAddress = litag.text
			#replacing any "\n" in those addresses with "NULL"
			hotelsWithAddress= hotelsWithAddress.replace("\n", "")
			#replacing white spaces after ", " to ","
			hotelsWithAddress= hotelsWithAddress.replace(", ",",")
			#joining whole address split by ","
			hotelsWithAddress= ",".join(hotelsWithAddress.split(",")[:2])
			hotelsWithAddress= re.sub(r'\[.+\]','',hotelsWithAddress)
			if "," in hotelsWithAddress and not "." in hotelsWithAddress:
				#taking random ratings for every hotels in range (2.7 to 5) and taking upto 2 decimals 
				rating=str(round(random.uniform(2.7,5),2))
				#taking price and making it dependant upon rating
				price=float(rating)*1375
				#adding "Rs" before price value
				price="Rs "+str(int(price))
				#taking random if a hotel has AC or not
				AC=str(random.getrandbits(1))
				review="Not yet reviewed"
				if AC=="1":
					AC="AC included"
				else:
					AC="Non AC"
				#taking random if a hotel has parking or not
				parking=str(random.getrandbits(1))
				if parking=="1":
					parking="Free parking"
				else:
					parking="No parking"
				#taking random if a hotel has Wi-Fi or not
				wifi=str(random.getrandbits(1))
				if wifi=="1":
					wifi="Free wifi"
				else:
					wifi="No wifi"
				#taking random if a hotel has breakfast or not
				breakfast=str(random.getrandbits(1))
				if breakfast=="1":
					breakfast="Complementary breakfast"
				else:
					breakfast="No breakfast"
				#splitting hotelsWithAddresses and storing in two variables hotels and address
				hotels,address=hotelsWithAddress.split(',')
				#writing every line in output file
				f.write(hotels+"; "+address+"; "+price+"; "+rating+"; "+AC+"; "+parking+"; "+wifi+"; "+breakfast+"; "+review+";\n")
	#closing output file
	f.close()

#url='https://en.wikipedia.org/wiki/List_of_hotels:_Countries_A'
incompleteUrl='https://en.wikipedia.org/wiki/List_of_hotels:_Countries_'
#creating output file
f= open("List_of_hotels.txt","w+", encoding="utf-8")
#writing the headings in the output file
f.write("//hotelName;address;price;rating;AC;freeParking;freeWifi;complementaryBreakfast;review;\n\n")
#closing the file for now
f.close()
#here is the clever trick
#here is the incompleteUrl='https://en.wikipedia.org/wiki/List_of_hotels:_Countries_'
#and here the completeUrl='https://en.wikipedia.org/wiki/List_of_hotels:_Countries_A' for country that starts with 'A'
#so for every country from A-Z we have to add last character in the incompleteurl and save them in url
#but there are 2 special cases:
#case 1 : there is no country that starts with letter "X"
#case 2 : as there are less countries with starting letter N,O,P,Q,V,W,Y,Z, wikipedia saves them as N-O,P-Q,V-W,Y-Z.
#starting from "A" ASCII->65
letter=65
#loops till 91, ASCII of "Z" is 91
while (letter< 91):
	#handling case 1, by skipping "X"
	if(chr(letter)=="X"):
		letter+=1
		continue
	#handling case 2, by adding "N-O" instead of just "N" and for the rest of all
	elif(chr(letter)=="N"\
		or chr(letter)=="P"\
		or chr(letter)=="V"\
		or chr(letter)=="Y"):
		url=incompleteUrl+chr(letter)+"-"+chr(letter+1)
		letter+=1
	#for default case
	else:
		url=incompleteUrl+chr(letter)
	#passing the url through the function
	function(url)
	#incrementing letter by one
	letter+=1