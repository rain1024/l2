import os
from data import Words
from gtts import gTTS

# read audio files 
sound_folder = "l2/Sounds"
files = os.listdir(sound_folder)
sounds = set([file.split(".")[0] for file in files])

count = 0
for word in Words:
    if word.text not in sounds:
        count += 1
        print(word.text, word.lang)
        tts = gTTS(text=word.text, lang=word.lang)
        filename = sound_folder + "/" + word.text + ".mp3"
        tts.save(filename)   

print("count", count)