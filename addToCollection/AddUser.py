import pymongo
from pymongo import MongoClient

myclient = pymongo.MongoClient("mongodb+srv://Payne5220:Knights2020@softwareeng.1ub3g.mongodb.net/sousChef?retryWrites=true&w=majority")
db = myclient["sousChef"]
col = db["Users"]


a = input("Enter First Name: " )
b = input("Enter Last Name: ")
c = input("Enter username: ")
for x in c:
    if col.count_documents({ 'username': c}, limit= 1)!=0:
        print("sorry! User already exists. ")
        c = input("Enter username: ")
    else:
        break

d = input("Enter password: ")

post = {"fName": a, "lName": b, "username": c, "password": d}
col.insert_one(post)