from typing import List

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


def tokenize(text_path: str) -> List[str]:

    with open(text_path, "r", encoding='utf-8') as f:
        text = remove_sentence_symbols(f.read())
        tokens = text.replace("\n", "").split(" ")
    
    return tokens
