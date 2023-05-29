from data import Stories
import json
from os.path import join

file = "l2/data/stories2.json"

raw_folder = "stories/raw"
data = []

def get_raw(id):
    with open(join(raw_folder, str(id) + ".txt"), "r") as f:
        content = f.read()
    return content

def normalize_text(raw):
    text = raw.replace("\n", "\n")
    return text 

for story in Stories:
    raw = get_raw(story.id)
    text = normalize_text(raw)
    story.set_text(text)
    data.append(story.to_dict())

json.dump(data, open(file, "w"), indent=4, ensure_ascii=False)
print("Stories")
print(Stories)