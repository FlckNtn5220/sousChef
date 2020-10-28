# Sous Chef

A native app for IOS and Android that is utilized for making the creation of shopping lists more effecient and easy. The app does this through allowing the user to put all their recipes into one place and be able to select the ingredients they need from a recipe and put it into a shopping list.

## Getting Started

First you will need VScode and Android Studio if you want to run the app on an android. 

* Download VScode [here](https://code.visualstudio.com/download)
* Download Android Studio [here](https://developer.android.com/studio)

You will also need to download Flutter (which comes with Dart) as well as the Flutter extension in VScode.

* Download Flutter and follow installation steps [here](https://flutter.dev/docs/get-started/install)

Make sure you uodate your path appropriatly and use flutter doctor to make sure everyhting is in order. To run on iOS make sure to follow the deploy to iOS section.

## Database Notes
To connect database to python, pymongo will need to be installed. dnspython will also need to be installed if not already.

* from terminal, type pip install pymongo
* from terminal, type pip install dnspython

You will need to connect to the database through a specific URL.

Copy this line of code:

myclient = pymongo.MongoClient("mongodb+srv://Payne5220:Knights2020@softwareeng.1ub3g.mongodb.net/sousChef?retryWrites=true&w=majority")

    *note: The user and password have been created for the sole purpose of the sousChef native application and do not satisfy any other known user credentials.

*tutorial on how to use pymongo(https://api.mongodb.com/python/current/tutorial.html)


