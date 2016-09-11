from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")
db = client.XC_DEV_NEW4

coll = db.runners

for doc in coll.find():
    print doc["name"]
    new = doc["name"].replace("\t", " ")
    coll.update_one({"name" : doc["name"]},  {
        "$set": {
            "name": new
        }
    })
