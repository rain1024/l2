from data import Phonetics
import os

# get available file in phonectics folder
PHONETICS_EXAMPLES_FOLDER = "l2/data/PhoneticsExamples"
files = os.listdir(PHONETICS_EXAMPLES_FOLDER)
exist = [file.split(".")[0] for file in files ]
print(exist)

phonetics_sounds = []
phonetics_sounds_urls = []
for phonetic in Phonetics:
    for example in phonetic.examples:
        if (example["sound"] is None) != (example["sound_url"] is None) or \
            (example["sound2"] is None) != (example["sound2_url"] is None) or \
                (example["sound3"] is None) != (example["sound3_url"] is None):
            raise Exception("Data has error", phonetic.id, example)
        
        if example["sound"] is not None:
            phonetics_sounds.append(example["sound"])
            phonetics_sounds_urls.append(example["sound_url"])
        
        if example["sound2"] is not None:
            phonetics_sounds.append(example["sound2"])
            phonetics_sounds_urls.append(example["sound2_url"])

        if example["sound3"] is not None:
            phonetics_sounds.append(example["sound3"])
            phonetics_sounds_urls.append(example["sound3_url"])

for sound, sound_url in zip(phonetics_sounds, phonetics_sounds_urls):
    if sound not in exist:
        print(f"Get sound {sound} from {sound_url}")
        outfile = PHONETICS_EXAMPLES_FOLDER + "/" + sound + ".mp3"
        command = f"wget -O {outfile} {sound_url}"
        os.system(command)
        
            