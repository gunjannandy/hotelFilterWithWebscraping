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
    - **Complementary breakfast**
6. Added **review**, null `( Not yet reviewed )` at first.
> **Database is delimited with `;`**
## filter.sh
**It is a menu driven program which is divided in two parts:**
### *viewing part:* 
1. It is used to filter hotels if any of the following is desired or not:
    - **AC**
    - **Parking**
    - **WiFi**
    - **Complementary breakfast**
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
