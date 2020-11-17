import pymongo
from pymongo import MongoClient

myclient = pymongo.MongoClient("mongodb+srv://Payne5220:Knights2020@softwareeng.1ub3g.mongodb.net/sousChef?retryWrites=true&w=majority")
db = myclient["sousChef"]
col = db["Recipes"]

def add_doc(data):
    document = col.insert_one(data)
    return document.inserted_id

def delete_doc(data):
    document = col.delete_one(data)

def update_or_create(document_id, data):
    # TO AVOID DUPLICATES - THIS WILL CREATE NEW DOCUMENT IF SAME ID NOT EXIST
    document = col.update_one({'_id': ObjectId(document_id)}, {"$set": data})
    return document.acknowledged

def createRecipe():
    recipeName = input("What are you making? ")
    data = {"name": recipeName}
    x = add_doc(data)
    print("Recipe created successfully!")

def deleteRecipe():
    recipeName = input("Enter Recipe name: ")
    x = input("Are you sure you want to delete recipe? y/n? ")
    if x == 'y':
        data = {"name": recipeName}
        delete_doc(data)
    else:
        print("Delete recipe aborted!")


def add_item_Recipe():
    y = input("Enter recipe name: ")
    x = input("Would you like to add a new item? y/n? ")
    while x != 'n':
        new_item = input("Enter item to add: ")
        col.update_one({"name": y}, {'$push': {'items': new_item}})
        x = input("Add another item? y/n? ")
        if x == 'n':
            print("Items successfully added!")
            break

def remove_itemRecipe():
    y = input("Enter list name: ")
    x = input("Would you like to remove an item? y/n? ")
    while x != 'n':
        old_item = input("Enter item to remove: ")
        col.update_one({"name": y}, {'$pull': {'items': old_item}})
        x = input("Remove another item? y/n? ")
        if x == 'n':
            print("Items successfully removed!")
            break

def add_descRecipe():
    y = input("Enter recipe name: ")
    x = input("Enter description: ")
    col.update_one({"name" : y}, {"$set": {"Desciption": x}})


