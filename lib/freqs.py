import json

from collections import Counter


def make_frequency(file_path):
    
    with open(file_path) as f:
        tokens = f.read().split(" ")

    c = Counter(tokens)

    with open(file_path.replace("tokenized_", "freqs_").replace(".txt", ".json"), "w", encoding="utf-8") as f:
        json.dump(c, f, indent=4)
    

