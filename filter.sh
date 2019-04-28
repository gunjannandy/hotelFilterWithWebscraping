#!/bin/bash
#specifying the database file
file="List_of_hotels.txt"
#making a heading to be used later while saving filtered out hotels
heading="sed -e '1i\
		-Hotel Name- ; -Location- ; -Price- ; -Rating- ; -AC- ; -Parking- ; -WiFi- ; -Breakfast- ; -Review- ;' "
#menu driven program
while [[ true ]]; do
	read -p "Enter if you want to Edit or Search [E/S/Q(Quit)]: " temp2
	#editing part
	if [[ $temp2 == [E] ||  $temp2 == [e] ]]; then
		#searching for the hotel
		#loops until a hotel name is found uniquely
		while [[ true ]]; do
			#taking the user input in name variable, it can be any part of the total hotel name
			read -p "Enter hotel name: " name
			#hotel name uniqueness checker
			temp3=0
			#comparing the input from hotel database
			temp3=$(cut -d ";" -f 1 "$file" | egrep -ci "$name")
			#if the entered name matches uniquely with the database hotel name then temp3 will be exactly 1
			#to illustrate, if the input is Taj, and there is exactly one 1 hotel which contain the word Taj, then this condition will occur
			if [[ $temp3 == 1 ]]; then
				name=$(cut -d ";" -f 1 "$file" | sort -u | egrep -i "$name")
				echo " Hotel found:"
				echo
				grep -i "$name" "$file" | eval "$heading" |column -t -s $';';
				echo
				break
			#if the entered name matches partly but not uniquely with the database hotel name then temp3 will be greater than 1
			#to illustrate, if the input is Taj, and there are more than 1 hotels which contains the word Taj, then this condition will occur
			elif [[ $temp3 > 1 ]]; then
				echo " Did you mean:"
				cut -d ";" -f 1 "$file" | grep -ih "$name"
			#if the entered name does not match even partly with the database hotel name then temp3 will be 0
			#to illustrate, if the input is Taj, and there is no hotel which contains the word Taj, then this condition will occur
			else
				echo " No hotels found. Try again!"
			fi
		done
		#add rating
		while [[ true ]]; do
			read -p "Do you want to add rating? [Y/N]: " temp
			#if you want to add rating
			if [[ $temp == [Y] ||  $temp == [y] ]]; then
				#taking rating from user
				read -p "Enter your rating [0-5]: " rat
				#checking if the input contains only numbers
				if [[ $rat =~ ^[0-9]+$ ]]; then
					#checking if the input lies between 0 and 5
					if (( $rat < 6 )) && (( $rat > -1 )); then
						#taking current rating if the hotel from the database
						currentRate=$(grep -i "$name" "$file" | cut -d ";" -f 4)
						#here is a clever part
						#you should not be the only one who is giving rating to the hotels
						#to bypass this, current rating gets multiplied by 100, then your rating gets added and the sum gets divided by 101
						#what it means is
						#you are the 101th person who is rating the hotel
						#your rating will affect the overall rating
						#but your rating won't overwrite its previous rating
						rate=$(bc -l <<< "scale=2; ($currentRate*100+$rat)/101")
						#the new rating can't be greater than 5 
						if (( $(echo "$rate > 5" |bc -l) )); then
							rate=5
						#the new rating can't be less than 0
						elif (( $(echo "$rate < 0" |bc -l) )); then
							rate=0
						fi
						#the new rating then gets added to the database
						#but we cant modify an already opened file
						#so we first create a temporary testfile, and then testfile is moved in the original database
						awk -F";" -v name1="$name" -v rat="$rate" '$1 == name1 { $4=" "rat } 1' OFS=";" "$file" > testfile.tmp && mv testfile.tmp "$file"
						#printing the hotel with modified rating
						echo " Modified rating:"
						echo
						grep -i "$name" "$file" | eval "$heading" | column -t -s $';';
						echo
						break
					#if input is not valid
					else
						echo "Enter valid input!"
					fi
				#if input is not valid
				else
					echo "Enter valid input!"
				fi
			#if you don't want to add rating
			elif [[ $temp == [N] || $temp == [n] ]]; then
				break
			#if input is not valid
			else
				echo "Enter valid input!"
			fi
		done
		#add review
		while [[ true ]]; do
			read -p "Do you want to add review? [Y/N]: " temp
			#if you want to add review
			if [[ $temp == [Y] ||  $temp == [y] ]]; then
				#taking the review input
				read -p "Enter your review: " review
				#if the hotel has no review, delete the string "Not yet reviewed" and append the new review
				if [[ $( grep -i "$name" "$file" | egrep -ci "Not yet reviewed") > 0  ]]; then
					awk -F";" -v name1="$name" -v rev="$review" '$1 == name1 { $9=" "rev } 1' OFS=";" "$file" > testfile.tmp && mv testfile.tmp "$file"
				#if the hotel already has reviews, don't delete anything, just append the new review
				else
					awk -F";" -v name1="$name" -v rev="$review" '$1 == name1 { $9=" "rev","$9 } 1' OFS=";" "$file" > testfile.tmp && mv testfile.tmp "$file"
				fi
				#printing the hotel with modified review
				echo " Modified review:"
				echo
				grep -i "$name" "$file" | eval "$heading" | column -t -s $';';
				echo
				break
			#if you don't want to add review
			elif [[ $temp == [N] || $temp == [n] ]]; then
				break
			#if input is not valid	
			else
				echo "Enter valid input!"
			fi
		done
	#searching part
	elif [[ $temp2 == [S] ||  $temp2 == [s] ]]; then
		# checking location
		#loops until a location is found uniquely
		while [[ true ]]; do
			#taking the user input in location variable, it can be any part of the total location
			read -p "Enter Location: " location
			#Location name uniqueness checker
			temp3=0
			#comparing the input from hotel database
			temp3=$(cut -d ";" -f 2 "$file" | sort -u | egrep -ci "$location")
			#if the input matches uniquely with the database location then temp3 will be exactly 1
			#to illustrate, if the inout is Kol, and there is exactly one 1 location which contain the word Kol, then this condition will occur
			if [[ $temp3 == 1 ]] ; then
				break
			#if the input matches partly but not uniquely with the database location then temp3 will be greater than 1
			#to illustrate, if the inout is Kol, and there are more than 1 location which contains the word Kol, then this condition will occur
			elif [[ $temp3 > 1 ]]; then
				echo "Did you mean:"
				cut -d ";" -f 2 "$file" | sort -u | grep -ih "$location"
			#if the input does not match even partly with the database location then temp3 will be 0
			#to illustrate, if the inout is Kol, and there is no location which contains the word Kol, then this condition will occur
			else
				echo " No location found. Try again!"	
			fi
		done
		#filtering AC
		while [[ true ]]; do
			read -p "Enter if AC is required [Y/N/D(don't care)]: " temp
			#if AC is required
			if [[ $temp == [Y] ||  $temp == [y] ]]; then
				a="AC included"
				break
			#if AC is not required
			elif [[ $temp == [N] || $temp == [n] ]]; then
				a="Non AC"
				break
			#if neutral
			elif [[ $temp == [D] || $temp == [d] ]]; then
				a=" "
				break
			#if input is not valid
			else
				echo "Enter valid input!"
			fi
		done
		#filtering parking
		while [[ true ]]; do
			read -p "Enter if Parking is required [Y/N/D(don't care)]: " temp
			#if parking is required
			if [[ $temp == [Y] ||  $temp == [y] ]]; then
				p="Free parking"
				break
			#if parking isn't required
			elif [[ $temp == [N] || $temp == [n] ]]; then
				p="No parking"
				break
			#if neutral
			elif [[ $temp == [D] || $temp == [d] ]]; then
				p=" "
				break
			#if input is not valid
			else
				echo "Enter valid input!"
			fi
		done
		#filtering wifi
		while [[ true ]]; do
			read -p "Enter if WiFi is required [Y/N/D(don't care)]: " temp
			#if wifi is required
			if [[ $temp == [Y] ||  $temp == [y] ]]; then
				w="Free wifi"
				break
			#if wifi isn't required
			elif [[ $temp == [N] || $temp == [n] ]]; then
				w="No wifi"
				break
			#if neutral
			elif [[ $temp == [D] || $temp == [d] ]]; then
				w=" "
				break
			#if input is not valid
			else
				echo "Enter valid input!"
			fi
		done
		#filtering breakfast
		while [[ true ]]; do
			read -p "Enter if Complimentary breakfast is required [Y/N/D(don't care)]: " temp
			#if complimentary breakfast is required
			if [[ $temp == [Y] ||  $temp == [y] ]]; then
				a="Complementary breakfast"
				break
			#if complimentary breakfast isn't required
			elif [[ $temp == [N] || $temp == [n] ]]; then
				b="No breakfast"
				break
			#if neutral
			elif [[ $temp == [D] || $temp == [d] ]]; then
				b=" "
				break
			#if input is not valid
			else
				echo "Enter valid input!"
			fi
		done
		#sorting
		while [[ true ]]; do
			read -p "Sort hotels according to Price or Rating [P/R/D(don't care)]: " temp
			#sorting according to price
			if [[ $temp == [P] ||  $temp == [p] ]]; then
				read -p "Sort Incresing or Decreasing [I/D]: " temp1
				#sort price low to high
				if [[ $temp1 == [I] ||  $temp1 == [i] ]]; then
					sorting="sort -t ';' -k3"
					break
				#sort price high to low
				elif [[ $temp1 == [D] ||  $temp1 == [d] ]]; then
					sorting="sort -t ';' -k3r"
					break
				#if input is not valid
				else
					echo "Enter valid input!"
				fi
			#sorting according to review
			elif [[ $temp == [R] || $temp == [r] ]]; then
				read -p "Sort Incresing or Decreasing [I/D]: " temp1
				#sort rating low to high
				if [[ $temp1 == [I] ||  $temp1 == [i] ]]; then
					sorting="sort -t ';' -k4"
					break
				#sort rating high to low
				elif [[ $temp1 == [D] ||  $temp1 == [d] ]]; then
					sorting="sort -t ';' -k4r"
					break
				#if input is not valid
				else
					echo "Enter valid input!"
				fi
			#if sorting isn't required
			elif [[ $temp == [D] || $temp == [d] ]]; then
				sorting="tee"
				break
			#if input is not valid
			else
				echo "Enter valid input!"
			fi
		done
		echo ""
		#printing heading for attributes in the output
		output=$(cat "$file" | grep -i "$location"  | grep -i "$b"  | grep -i "$p" | grep -i "$w" | grep -c "$a")
		#if one or more hotel satisfies the above requirements
		if [[ $output > 0 ]]; then
			cat "$file" | grep -i "$location"  | grep -i "$b"  | grep -i "$p" | grep -i "$w" | grep -T "$a" | eval "$sorting" | eval "$heading" | column -t -s $';' | tee Desired_hotels.txt
		#if no hotel satisfies the above requirements
		else
			echo "No hotel found!"
		fi
		echo ""
	#to quit the menu driven program
	elif [[ $temp2 == [Q] ||  $temp2 == [q] ]]; then
		break
	#if input is not valid
	else
		echo "Enter valid input!"
	fi
done