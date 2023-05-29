import sqlite3


db_folder = "l2/data/"
db_file = db_folder + "database.sqlite3"

class Word:
    def __init__(self, id, text, description, lang, topic):
        self.id = id
        self.text = text
        self.description = description
        self.lang = lang
        self.topic = topic

class Phonetic:
    def __init__(self, id, name, symbol, sound, sound_source_url, order, type, examples=[]):
        self.id = id
        self.name = name
        self.symbol = symbol
        self.sound = sound
        self.sound_source_url = sound_source_url
        self.type = type
        self.order = order
        self.examples = examples

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "symbol": self.symbol,
            "sound": self.sound,
            "sound_source_url": self.sound_source_url,
            "type": self.type,
            "order": self.order,
            "examples": self.examples
        }
    
class Story:
    def __init__(self, id, title, lang, type, published):
        self.id = id
        self.title = title
        self.lang = lang
        self.type = type
        self.published = published
        self.text = None

    def set_text(self, text):
        self.text = text

    def to_dict(self):
        return {
            "id": self.id,
            "title": self.title,
            "lang": self.lang,
            "type": self.type,
            "text": self.text
        }

def get_words():
    conn = sqlite3.connect(db_file)
    cursor = conn.cursor()
    cursor.execute('SELECT * FROM words')
    results = cursor.fetchall()
    words = []
    for result in results:
        id, text, description, lang, topic = result
        word = Word(id, text, description, lang, topic)
        words.append(word)
    return words

def get_phonetics():
    conn = sqlite3.connect(db_file)
    c = conn.cursor()
    c.execute('SELECT * FROM phonetics WHERE symbol != " "')
    phonetics_rows = c.fetchall()
    phonetics = []
    for row in phonetics_rows:
        phonetic_id, name, symbol, sound, sound_source_url, order, type = row
        c.execute("SELECT ipa, word, description, sound, sound_url, sound2, sound2_url, sound3, sound3_url FROM phonetics_examples WHERE phonetic_id = ?", (phonetic_id,))
        examples_rows = c.fetchall()
        examples = []
        for example_row in examples_rows:
            ipa, word, description, example_sound, example_sound_url, example_sound2, example_sound2_url, example_sound3, example_sound3_url = example_row
            examples.append({
                "ipa": ipa,
                "word": word,
                "description": description,
                "sound": example_sound,
                "sound_url": example_sound_url,
                "sound2": example_sound2,
                "sound2_url": example_sound2_url,
                "sound3": example_sound3,
                "sound3_url": example_sound3_url
            })
        phonetic = Phonetic(phonetic_id, name, symbol, sound, sound_source_url, type, order, examples=examples)
        phonetics.append(phonetic)
    return phonetics

def get_stories():
    conn = sqlite3.connect(db_file)
    c = conn.cursor()
    c.execute('SELECT * FROM stories')
    rows = c.fetchall()
    items = []
    for row in rows:
        id, title, lang, type, published = row
        item = Story(id, title, lang, type, published)
        
        items.append(item)
    return items

Words = get_words()
Phonetics = get_phonetics()
Stories = get_stories()