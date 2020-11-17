import pymongo
from pymongo import MongoClient
from bson import ObjectId

myclient = pymongo.MongoClient("mongodb+srv://Payne5220:Knights2020@softwareeng.1ub3g.mongodb.net/sousChef?retryWrites=true&w=majority")
db = myclient["sousChef"]
col = db["Lists"]


def add_doc(data):
    document = col.insert_one(data)
    return document.inserted_id

def delete_doc(data):
    document = col.delete_one(data)

def update_or_create(document_id, data):
    # TO AVOID DUPLICATES - THIS WILL CREATE NEW DOCUMENT IF SAME ID NOT EXIST
    document = col.update_one({'_id': ObjectId(document_id)}, {"$set": data})
    return document.acknowledged

def createList():
    listName = input("Enter a name for your new list: ")
    data = {"name": listName}
    x = add_doc(data)
    print("List created successfully!")

def deleteList():
    listName = input("Enter list name: ")
    x = input("Are you sure you want to delete list? y/n? ")
    if x == 'y':
        data = {"name": listName}
        delete_doc(data)
    else:
        print("Delete list aborted!")


def add_item_List():
    y = input("Enter list name: ")
    x = input("Would you like to add a new item? y/n? ")
    while x != 'n':
        new_item = input("Enter item to add: ")
        col.update_one({"name": y}, {'$push': {'items': new_item}})
        x = input("Add another item? y/n? ")
        if x == 'n':
            print("Items successfully added!")
            break

def remove_itemList():
    y = input("Enter list name: ")
    x = input("Would you like to remove an item? y/n? ")
    while x != 'n':
        old_item = input("Enter item to remove: ")
        col.update_one({"name": y}, {'$pull': {'items': old_item}})
        x = input("Remove another item? y/n? ")
        if x == 'n':
            print("Items successfully removed!")
            break


add_item_List()