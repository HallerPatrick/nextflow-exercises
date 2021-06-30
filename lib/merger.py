import os
import json


def merger(dir_name):

    merged_titles = []

    result = {}
    
    for file in os.listdir(dir_name):

        title = file.replace("kmers_", "").replace("freqs_", "")

        if title in merged_titles:
            continue
        
        if "freqs_" in file:

            with open(file) as f:
                freqs = json.load(f)

            file = file.replace("freqs_", "kmers_")
            
            with open(file) as f:
                kmers = json.load(f)

            for token in freqs.keys():

                kmer = kmers[token]
                freq = freqs[token]

                result[token] = {
                        "frequency": freq,
                        "8-mers": kmer
                        }

        if "kmers_" in file:

            with open(file) as f:
                kmers = json.load(f)

            file = file.replace("kmers_", "freqs_")

            with open(file) as f:
                freqs = json.load(f)

            for token in freqs.keys():

                kmer = kmers[token]
                freq = freqs[token]

                result[token] = {
                        "frequency": freq,
                        "8-mers": kmer
                        }


        merged_titles.append(file)


    
    with open("result.json", "w") as f:
        json.dump(result, f)
