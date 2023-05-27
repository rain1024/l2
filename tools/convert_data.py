import sqlite3
import pandas as pd
import json
from data import Words, Phonetics

def convert_words():
    conn = sqlite3.connect('l2/data/database.sqlite3')
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM words')
    results = cursor.fetchall()

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


def convert_phonetics():
    data = []
    for phonetic in Phonetics:
        try:
            item = phonetic.to_dict()
            data.append(item)
        except Exception as e:
            print(e)
    json.dump(data, open("l2/data/phonetics.json", "w"), indent=4, ensure_ascii=False)

if __name__ == "__main__":
    convert_words()
    convert_phonetics()