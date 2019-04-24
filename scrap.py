from bs4 import BeautifulSoup
import requests
import random
import re

def unique_list(l):
	ulist = []
	[ulist.append(x) for x in l if x not in ulist]
	return ulist

def function(url):

	# page_link = 'https://en.wikipedia.org/wiki/List_of_hotels:_Countries_I'
	page_response = requests.get(url, timeout=5)
	# here, we fetch the content from the url, using the requests library
	soup = BeautifulSoup(page_response.content, "html.parser")
	#we use the html parser to parse the url content and store it in a variable.
	f= open("List_of_hotels.txt","a", encoding="utf-8")
	for ultag in soup.find_all('ul',attrs={'class': None}):
		for litag in ultag.find_all('li'): 
			hotelsWithAddress = litag.text
			hotelsWithAddress= hotelsWithAddress.replace("\n", "")
			hotelsWithAddress= hotelsWithAddress.replace(", ",",")
			hotelsWithAddress= ",".join(hotelsWithAddress.split(",")[:2])
			# hotelsWithAddress= hotelsWithAddress.replace(",", "; ")
			hotelsWithAddress= re.sub(r'\[.+\]','',hotelsWithAddress)
			# hotels=" ".join(unique_list(hotels.split()))
			if "," in hotelsWithAddress and not "." in hotelsWithAddress:
				# print(hotels+' ; '+country)
				rating=str(round(random.uniform(2.7,5),2))
				price=float(rating)*1375
				price="Rs "+str(int(price))
				AC=str(random.getrandbits(1))
				review="Not yet reviewed"
				if AC=="1":
					AC="AC included"
				else:
					AC="Non AC"
				parking=str(random.getrandbits(1))
				if parking=="1":
					parking="Free parking"
				else:
					parking="No parking"
				wifi=str(random.getrandbits(1))
				if wifi=="1":
					wifi="Free wifi"
				else:
					wifi="No wifi"
				breakfast=str(random.getrandbits(1))
				if breakfast=="1":
					breakfast="Complementary breakfast"
				else:
					breakfast="No breakfast"
				hotels,address=hotelsWithAddress.split(',')
				# f.write(hotels+" : ""\n")
				f.write(hotels+"; "+address+"; "+price+"; "+rating+"; "+AC+"; "+parking+"; "+wifi+"; "+breakfast+"; "+review+";\n")
				# textContent.append(hotels)
	#I loop through the paragraphs, and push them into an array.
	# print(textContent)
	f.close()


incompleteUrl='https://en.wikipedia.org/wiki/List_of_hotels:_Countries_'
# url='https://en.wikipedia.org/wiki/List_of_hotels:_Countries_A'
f= open("List_of_hotels.txt","w+", encoding="utf-8")
f.write("//hotelName;address;price;rating;AC;freeParking;freeWifi;complementaryBreakfast;review;\n\n")
f.close()
# function(url)
letter=65
while (letter< 91):
	if(chr(letter)=="X"):
		letter+=1
		continue
	elif(chr(letter)=="N"\
		or chr(letter)=="P"\
		or chr(letter)=="V"\
		or chr(letter)=="Y"):
		url=incompleteUrl+chr(letter)+"-"+chr(letter+1)
		letter+=1
	else:
		url=incompleteUrl+chr(letter)
	function(url)
	# print(url)
	letter+=1