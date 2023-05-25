import sqlite3

class Word:
    def __init__(self, id, text, description, lang, topic):
        self.id = id
        self.text = text
        self.description = description
        self.lang = lang
        self.topic = topic

def get_words():
    conn = sqlite3.connect('l2/data/database.sqlite3')
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM words')
    results = cursor.fetchall()
    words = []
    for result in results:
        id, text, description, lang, topic = result
        word = Word(id, text, description, lang, topic)
        words.append(word)
    return words

Words = get_words()