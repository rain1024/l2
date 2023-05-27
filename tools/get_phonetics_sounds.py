from data import Phonetics
import os
import requests
from pydub import AudioSegment

# get available file in phonectics folder
folder = "l2/data/Phonetics/"
files = os.listdir(folder)
exist = [file.split(".")[0] for file in files ]

for phonetic in Phonetics:
    if phonetic.sound in exist:
        continue
    
    
    if phonetic.sound_source_url is None:
        continue

    if phonetic.sound_source_url == "":
        continue
    
    # download sound with requests

    # download ogg file using wget and os command
    

    attempts = 0
    while attempts < 3:
        try:
            print(phonetic.sound_source_url)
            r = requests.get(phonetic.sound_source_url, verify=True)
            tmp_folder = "tmp/"
            ogg_file = tmp_folder + phonetic.sound + ".ogg"
            mp3_file = tmp_folder + phonetic.sound + ".mp3"
            command = f"wget -O {ogg_file} {phonetic.sound_source_url}"
            print(command)
            os.system(command)
               
            # convert ogg to mp3 with pydub
            AudioSegment.from_file(ogg_file).export(mp3_file, format="mp3")

            # remove ogg file
            os.remove(ogg_file)
            break
        except:
            attempts += 1
            print("Error")
            sleep(0.2)
            continue


    # print(phonetic.sound_source_url)