import sqlite3
import pandas as pd
import json

conn = sqlite3.connect('l2/data/database.sqlite3')

cursor = conn.cursor()

cursor.execute('SELECT * FROM words')

results = cursor.fetchall()

print(results)

output = []
for result in results:
    id, text, description, lang, topic = result
    labels = ["id", "text", "description", "lang", "topic"]
    item = {}
    for i, label in enumerate(labels):
        if result[i] != None:
            item[label] = result[i]
    output.append(item)

json.dump(output, open("l2/data/vocabs2.json", "w"), indent=4, ensure_ascii=False)