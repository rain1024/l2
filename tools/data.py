import sqlite3

class Word:
    def __init__(self, id, text, description, lang, topic):
        self.id = id
        self.text = text
        self.description = description
        self.lang = lang
        self.topic = topic

class Phonetic:
    def __init__(self, id, name, symbol, sound, sound_source_url=None, examples=[]):
        self.id = id
        self.name = name
        self.symbol = symbol
        self.sound = sound
        self.sound_source_url = sound_source_url
        self.examples = examples

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "symbol": self.symbol,
            "sound": self.sound,
            "sound_source_url": self.sound_source_url,
            "examples": self.examples
        }

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

def get_phonetics():
    conn = sqlite3.connect('l2/data/database.sqlite3')
    c = conn.cursor()
    c.execute('SELECT * FROM phonetics WHERE symbol != " "')
    phonetics_rows = c.fetchall()
    phonetics = []
    for row in phonetics_rows:
        phonetic_id, name, symbol, sound, sound_source_url = row
        c.execute("SELECT ipa, word, description, sound, sound2 FROM phonetics_examples WHERE phonetic_id = ?", (phonetic_id,))
        examples_rows = c.fetchall()
        examples = []
        for example_row in examples_rows:
            ipa, word, description, example_sound, example_sound2 = example_row
            examples.append({
                "ipa": ipa,
                "word": word,
                "description": description,
                "sound": example_sound,
                "sound2": example_sound2
            })
        phonetic = Phonetic(phonetic_id, name, symbol, sound, sound_source_url, examples=examples)
        phonetics.append(phonetic)
    return phonetics

Words = get_words()
Phonetics = get_phonetics()