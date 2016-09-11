from pymongo import MongoClient

client = MongoClient("mongodb://localhost:27017")
db = client.XC_DEV_NEW2

coll = db.runners
import re
import urllib2

JSON = "{"
i = 0
with open("windham.txt") as f:
    for line in f:
        if " Hall " in line:
            minutes = line.split(":")[0][-2:]
            seconds = line.split(":")[1][:-2]
            person = line.split("    ")[1]
            person = ''.join([j for j in person if not j.isdigit()])
            person = person.strip()
            docs = coll.find({"name": person})
            if docs.count() != 1:
                print "Error on person " + person
            else:
                print "Ok " + person + " with a time of " + minutes + ":" + seconds
                JSON = JSON + '"' + str(i) + '"' + ' : {"name" : "' + person + '", "value" : "' + minutes.strip() + ':' + seconds.strip() + '"},'
                i+=1
with open("windhamFrosh.txt") as f:
    for line in f:
        if " Hall " in line:
            minutes = line.split(":")[0][-2:]
            seconds = line.split(":")[1][:-2]
            person = line.split("   ")[1]
            if len(person) == 0:
                person = line.split("    ")[1]
            person = ''.join([j for j in person if not j.isdigit()])
            person = person.strip()
            docs = coll.find({"name": re.compile(person, re.IGNORECASE)})
            if docs.count() != 1:
                print "Error on person " + person
            else:
                print "Ok " + person + " with a time of " + minutes + ":" + seconds
                JSON = JSON + '"' + str(i) + '"' + ' : {"name" : "' + person + '", "value" : "' + minutes.strip() + ':' + seconds.strip() + '"},'
                i+=1
JSON = JSON[:-1]
JSON = JSON + "}"
print JSON

req = urllib2.Request('http://localhost:3000/meet/57d0d88601161a3e02000001/runUpdate')
req.add_header('Content-Type', 'application/json')

response = urllib2.urlopen(req, JSON)
