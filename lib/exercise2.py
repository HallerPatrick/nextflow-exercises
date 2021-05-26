import json

from collections import Counter

from common import tokenize


def make_frequency(file_path):
    
    tokens = tokenize(file_path)

    c = Counter(tokens)

    with open("frequencies.json", "w", encoding="utf-8") as f:
        json.dump(c, f, indent=4)
    
    # Count of all unique words 
    print(list(c.values()).count(1))

