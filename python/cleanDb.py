from pymongo import MongoClient

client = MongoClient("mongodb://162.243.51.178:27017")
db = client.XC_DEV

coll = db.runners

for doc in coll.find():
    print doc["name"]
    new = doc["name"].replace("\t", " ")
    coll.update_one({"name" : doc["name"]},  {
        "$set": {
            "name": new
        }
    })
