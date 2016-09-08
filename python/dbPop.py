from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")
db = client.XC_DEV

coll = db.runners


with open("runners.txt") as f:
    for line in f:
        # coll.insert_one({
        #     "name" : line.strip()
        # })
        # print "Inserted " + line + " into db"
        fullLine = line.split(" ")[0] + "\t" + line.split(" ")[1]
        fullLine = fullLine.strip()
        print fullLine
        person = coll.find({"name": fullLine})[0]
        if not person is None:
            try:
                 f = line.split(" ")[2]
                 coll.update_one({"name": fullLine}, {"$set": {"isFrosh": True}})
                 print "Updated " + line
            except IndexError:
                continue
