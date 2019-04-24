#!/bin/bash
file="List_of_hotels.txt"
heading="sed -e '1i\
		-Hotel Name- ; -Location- ; -Price- ; -Rating- ; -AC- ; -Parking- ; -WiFi- ; -Breakfast- ; -Review- ;' "
#menu
while [[ true ]]; do
	read -p "Enter if you want to Edit or Search [E/S/Q(Quit)]: " temp2
	if [[ $temp2 == [E] ||  $temp2 == [e] ]]; then
		# checking hotel name
		while [[ true ]]; do
			read -p "Enter hotel name: " name
			temp3=0
			temp3=$(cut -d ";" -f 1 "$file" | egrep -ci "$name")
			if [[ $temp3 == 1 ]]; then
				name=$(cut -d ";" -f 1 "$file" | sort -u | egrep -i "$name")
				echo " Hotel found:"
				echo
				grep -i "$name" "$file" | eval "$heading" |column -t -s $';';
				echo
				break
			elif [[ $temp3 > 1 ]]; then
				echo " Did you mean:"
				cut -d ";" -f 1 "$file" | grep -ih "$name"
			else
				echo " No hotels found. Try again!"
			fi
		done
		# add rating
		while [[ true ]]; do
			read -p "Do you want to add rating? [Y/N]: " temp
			if [[ $temp == [Y] ||  $temp == [y] ]]; then
				read -p "Enter your rating [0-5]: " rat
				if [[ $rat =~ ^[0-9]+$ ]]; then
					if (( $rat < 6 )) && (( $rat > -1 )); then
						currentRate=$(grep -i "$name" "$file" | cut -d ";" -f 4)
						rate=$(bc -l <<< "scale=2; ($currentRate*100+$rat)/101")
						if (( $(echo "$rate > 5" |bc -l) )); then
							rate=5
						elif (( $(echo "$rate < 0" |bc -l) )); then
							rate=0
						fi
						awk -F";" -v name1="$name" -v rat="$rate" '$1 == name1 { $4=" "rat } 1' OFS=";" "$file" > testfile.tmp && mv testfile.tmp "$file"
						echo " Modified rating:"
						echo
						grep -i "$name" "$file" | eval "$heading" | column -t -s $';';
						echo
						break
					else
						echo "Enter valid input!"
					fi
				else
					echo "Enter valid input!"
				fi
			elif [[ $temp == [N] || $temp == [n] ]]; then
				break
			else
				echo "Enter valid input!"
			fi
		done
		# add review
		while [[ true ]]; do
			read -p "Do you want to add review? [Y/N]: " temp
			if [[ $temp == [Y] ||  $temp == [y] ]]; then
				read -p "Enter your review: " review
				if [[ $( grep -i "$name" "$file" | egrep -ci "Not yet reviewed") > 0  ]]; then
					awk -F";" -v name1="$name" -v rev="$review" '$1 == name1 { $9=" "rev } 1' OFS=";" "$file" > testfile.tmp && mv testfile.tmp "$file"
				else
					awk -F";" -v name1="$name" -v rev="$review" '$1 == name1 { $9=" "rev","$9 } 1' OFS=";" "$file" > testfile.tmp && mv testfile.tmp "$file"
				fi
				echo " Modified review:"
				echo
				grep -i "$name" "$file" | eval "$heading" | column -t -s $';';
				echo
				break
			elif [[ $temp == [N] || $temp == [n] ]]; then
				break
			else
				echo "Enter valid input!"
			fi
		done

	elif [[ $temp2 == [S] ||  $temp2 == [s] ]]; then
		# checking location
		while [[ true ]]; do
			read -p "Enter Location: " location
			temp3=0
			temp3=$(cut -d ";" -f 2 "$file" | sort -u | egrep -ci "$location")
			if [[ $temp3 == 1 ]] ; then
				break
			elif [[ $temp3 > 1 ]]; then
				echo "Did you mean:"
				cut -d ";" -f 2 "$file" | sort -u | grep -ih "$location"
			else
				echo " No location found. Try again!"	
			fi
		done
		#filtering AC
		while [[ true ]]; do
			read -p "Enter if AC is required [Y/N/D(don't care)]: " temp
			if [[ $temp == [Y] ||  $temp == [y] ]]; then
				a="AC included"
				break
			elif [[ $temp == [N] || $temp == [n] ]]; then
				a="Non AC"
				break
			elif [[ $temp == [D] || $temp == [d] ]]; then
				a=" "
				break
			else
				echo "Enter valid input!"
			fi
		done
		#filtering parking
		while [[ true ]]; do
			read -p "Enter if Parking is required [Y/N/D(don't care)]: " temp
			if [[ $temp == [Y] ||  $temp == [y] ]]; then
				p="Free parking"
				break
			elif [[ $temp == [N] || $temp == [n] ]]; then
				p="No parking"
				break
			elif [[ $temp == [D] || $temp == [d] ]]; then
				p=" "
				break
			else
				echo "Enter valid input!"
			fi
		done
		#filtering wifi
		while [[ true ]]; do
			read -p "Enter if WiFi is required [Y/N/D(don't care)]: " temp
			if [[ $temp == [Y] ||  $temp == [y] ]]; then
				w="Free wifi"
				break
			elif [[ $temp == [N] || $temp == [n] ]]; then
				w="No wifi"
				break
			elif [[ $temp == [D] || $temp == [d] ]]; then
				w=" "
				break
			else
				echo "Enter valid input!"
			fi
		done
		#filtering breakfast
		while [[ true ]]; do
			read -p "Enter if Complimentary breakfast is required [Y/N/D(don't care)]: " temp
			if [[ $temp == [Y] ||  $temp == [y] ]]; then
				a="Complementary breakfast"
				break
			elif [[ $temp == [N] || $temp == [n] ]]; then
				b="No breakfast"
				break
			elif [[ $temp == [D] || $temp == [d] ]]; then
				b=" "
				break
			else
				echo "Enter valid input!"
			fi
		done
		#sorting according rating
		while [[ true ]]; do
			read -p "Sort hotels according to Price or Rating [P/R/D(don't care)]: " temp
			if [[ $temp == [P] ||  $temp == [p] ]]; then
				read -p "Sort Incresing or Decreasing [I/D]: " temp1
				if [[ $temp1 == [I] ||  $temp1 == [i] ]]; then
					sorting="sort -t ';' -k3"
					break
				elif [[ $temp1 == [D] ||  $temp1 == [d] ]]; then
					sorting="sort -t ';' -k3r"
					break
				else
					echo "Enter valid input!"
				fi
			elif [[ $temp == [R] || $temp == [r] ]]; then
				read -p "Sort Incresing or Decreasing [I/D]: " temp1
				if [[ $temp1 == [I] ||  $temp1 == [i] ]]; then
					sorting="sort -t ';' -k4"
					break
				elif [[ $temp1 == [D] ||  $temp1 == [d] ]]; then
					sorting="sort -t ';' -k4r"
					break
				else
					echo "Enter valid input!"
				fi
			elif [[ $temp == [D] || $temp == [d] ]]; then
				sorting="tee"
				break
			else
				echo "Enter valid input!"
			fi
		done
		echo ""
		output=$(cat "$file" | grep -i "$location"  | grep -i "$b"  | grep -i "$p" | grep -i "$w" | grep -c "$a")
		if [[ $output > 0 ]]; then
			cat "$file" | grep -i "$location"  | grep -i "$b"  | grep -i "$p" | grep -i "$w" | grep -T "$a" | eval "$sorting" | eval "$heading" | column -t -s $';' | tee Desired_hotels.txt
		else
			echo "No hotel found!"
		fi
		echo ""
	elif [[ $temp2 == [Q] ||  $temp2 == [q] ]]; then
		break
	else
		echo "Enter valid input!"
	fi
done