import pymongo
from pymongo import MongoClient

#Connects to database
myclient = pymongo.MongoClient("mongodb+srv://Payne5220:Knights2020@softwareeng.1ub3g.mongodb.net/sousChef?retryWrites=true&w=majority")
mydb = myclient["sousChef"]
col = mydb["Items"]

#Adds a single item to the database
def add_item():
    a = input("Please enter new item name: ")
    data = {"name": a}
    document = col.insert_one(data)
    print("Item seccussfully added!")

#Adds as many items as a user wants to the database
def add_manyItems():
    x = input("Would you like to add a new item? y/n? ")
    while x != 'n':
        a = input("Please enter new item name: ")
        data = {"name": a}
        document = col.insert_one(data)
        x = input("Add another item? y/n? ")
        if x == 'n':
            print("Items successfully added!")
            break

#Deletes as many items as user wants from database
def delete_items():
    x = input("Would you like to delete a new item? y/n? ")
    while x != 'n':
        a = input("Please enter item name: ")
        data = {"name": a}
        document = col.delete_one(data)
        x = input("Delete another item? y/n? ")
        if x == 'n':
            print("Items successfully added!")
            break

