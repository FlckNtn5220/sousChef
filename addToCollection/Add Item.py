import pymongo
from pymongo import MongoClient

myclient = pymongo.MongoClient("mongodb+srv://Payne5220:Knights2020@softwareeng.1ub3g.mongodb.net/sousChef?retryWrites=true&w=majority")
mydb = myclient["sousChef"]
col = mydb["Items"]

#example {"name": "Apple"}
post = {}
col.insert_one(post)
