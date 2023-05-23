import sqlite3
import pandas as pd

conn = sqlite3.connect('l2/data/database.sqlite3')

cursor = conn.cursor()

cursor.execute('SELECT * FROM words')

results = cursor.fetchall()

print(results)

print(len)

users = pd.DataFrame(results, columns=['id', 'text', 'description', 'lang', 'topic'])

print(users.groupby(['lang', 'topic']).agg('count'))