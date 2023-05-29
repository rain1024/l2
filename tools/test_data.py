import json

json_file = "l2/data/phonetics.json"

with open(json_file, "r") as f:
    content = json.load(f)    
print(content)