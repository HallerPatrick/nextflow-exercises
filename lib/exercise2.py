import json

from collections import Counter


def remove_sentence_symbols(text: str):
    return (
        text.replace(".", " ")
        .replace(",", " ")
        .replace(":", " ")
        .replace(";", " ")
        .replace("!", "")
        .replace("?", "")
        .replace(")", "")
        .replace("(", "")
    )


def tokenize(text_path: str):

    with open(text_path, "r", encoding='utf-8') as f:
        text = remove_sentence_symbols(f.read())
        tokens = text.replace("\n", "").split(" ")

    c = Counter(tokens)

    with open("frequencies.json", "w", encoding="utf-8") as f:
        json.dump(c, f, indent=4)
    
    # Count of all unique words 
    print(list(c.values()).count(1))
