# Hotel Filter With Web Scraping (Python+Bash)
Used python for making the hotel database from Wikipedia and used bash shell for hotel filtering.
## scrap.py
1. It is used for scraping hotel database from Wikipedia.
To be specific, from this master link:
[List of Hotels from Wikipedia](https://en.wikipedia.org/wiki/List_of_hotels:_Countries_A)
*and for all other countries which starts with letter like A,B,C, upto Z.*
2. From there **Hotel names** and their **addresses** are taken.
3. Then gave every hotel random **price**.
4. Gave **rating** according to the price.
5. Used another random function to randomly generate if the hotel has the properties below:
    - **AC**
    - **Parking**
    - **WiFi**
    - **Complimentary breakfast**
6. Added **review**, null `( Not yet reviewed )` at first.
> **Database is delimited with `;`**

### Python functions:
***requests.get(url, timeout=integer)*** -> Requests is a Python module that you can use to send all kinds of HTTP requests. It is an easy-to-use library with a lot of features ranging from passing parameters in URLs to sending custom headers and SSL Verification.  
***beautifulSoup(requests.get(url, timeout=integer), “html.parser”)*** -> BeautifulSoup is a Python library for pulling data out of HTML and XML files. Here to get the full html content from a webpage.  
***random.getrandbits(1)*** -> Get either 1 or 0 randomly.  
***random.uniform(A,B)*** -> It returns a random floating point number between A and B inclusive.  
round(random.uniform(A,B),C) -> Rounding up to C digits after decimal.  
***re.sub(pattern, repl, string, count=0, flags=0)*** -> Returns the string obtained by replacing the leftmost non-overlapping occurrences of pattern in string by the replacement repl. If the pattern isn’t found, string is returned unchanged.  
***str.split(separator, maxsplit)*** -> Separator is a delimiter. The string splits at this specified separator. If is not provided then any white space is a separator. Maxsplit is a number, which tells us to split the string into maximum of provided number of times. If it is not provided then there is no limit.  
***str.join(strings)*** -> strings is a sequence of elements to be joined.  
***str(var)*** -> Converts the passed variable into string.  

## filter.sh
**It is a menu driven program which is divided in two parts:**
### *viewing part:* 
1. It is used to filter hotels if any of the following is desired or not:
    - **AC**
    - **Parking**
    - **WiFi**
    - **Complimentary breakfast**
2. It can also sort the already filtered out hotels according to:
    - Sort by **price**: 
      - *low to high*
      - *high to low*
    - Sort by **rating**:
      - *low to high*
      - *high to low*
### *editing part:*
1. **Review** can be added to any hotel.
> Remember you can't delete any previous reviews.
2. **Rating** can be added to any hotel.
> Remember you are adding rating and you are not the only one, your rating will only change the overall rating of the hotel. You can think like you are the *101th person* who is adding his/her rating.

### Bash Shell functions:  
***sed -e script*** -> Add the script to the commands to be executed.  
***cut -d "delimiter" -f (field number) file.txt*** -> List of the fields number specified must be separated by comma. Ranges are not described with -f option. Cut uses tab as a default field delimiter but can also work with other delimiter by using -d option.  
***egrep –ci “$variable” file.txt*** -> -c option suppresses normal output, instead prints a count of matching lines for each input file. –i option to ignore case distinctions in both the pattern and the input files.  
***grep –ih “$variable” file.txt*** -> -h option displays the matched lines, but does not display the filenames. And -i option ignores, case for matching.  
***sort -u file.txt*** -> -u option to sort and remove duplicates pass the -u option to sort. This will write a sorted list to standard output and remove duplicates.  
***eval “arguments”*** -> Eval is a built-in Linux command which is used to execute arguments as a shell command. It combines arguments into a single string and uses it as an input to the shell and execute the commands.   
***column -t-s ”delimiter”  file.txt***-> -s option defines the column delimiter for output. -t option is applied for creating a table by determining the number of columns.  
***bc -l*** -> -l option is also known as {- -mathlib } which defines the standard math library.  
***awk -F"delimiter" -v tempVar1="$Var1" -v tempVar2="$var2" 'operations 1' OFS="delimiter" inputFile.txt > outputFile.txt*** -> -F”delimiter” is used for the input field separator. OFS="delimiter" is used for output file field separator. –v option is used to copy a variable to a temporary variable, as awk can’t take the original variable . Operations are done in ‘operations’ section.  
***(awk output)file.txt testfile.tmp && mv testfile.tmp file.txt*** -> to directly modify the input file, create a temporary file, then move the contents in the source file.  
***tee outputFile.txt*** -> tee command reads the standard input and writes it to both the standard output and one or more files.   

## how to run:
- Keep ***scrap.py*** and ***filter.sh*** in a same folder. 
> If you don't have internet connection you don't have to run ***scrap.py***. You can just use the provided database ***List_of_hotels.txt*** . You have to keep the database in the same folder as mentioned above.
- Make sure you have *internet connection*. Run ***scrap.py*** by giving following command in your terminal:
> `python scrap.py`
- It will create a text database in the folder named ***List_of_hotels.txt***.
- Now run the shell program ***filter.sh*** by giving following command in your terminal:
> `bash filter.sh`
- Remember, while filtering hotels according to your query, it will create another text file called ***Desired_hotels.txt*** in the same folder, which will contain the **Desired Hotels**.

### Please do tell if it needs any modification, any suggestions will be appreciated.
