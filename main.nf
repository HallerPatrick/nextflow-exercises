

/* Channel.fromPath("./gesamt/*.txt").set { text_channel } */
Channel.fromPath("raeuber.txt").set { text_channel }

/* Read in content of python modules*/
python_tokenizer = file("lib/tokenizer.py")
python_freqs = file("lib/freqs.py")
python_kmers = file("lib/kmers.py")
python_merger = file("lib/merger.py")


process tokenize {

    input:
    file some_file from text_channel

    /* Pass python content into workspace file tokenize.py */
    file 'tokenizer.py' from Channel.value(python_tokenizer.text)

    output:
    file 'tokenized_*' into tokenized_files

    """
    #!/usr/bin/env python3

    from tokenizer import tokenize

    tokens = tokenize("$some_file")

    with open("tokenized_$some_file", "w") as f:
       f.write(" ".join(tokens))
        
    """
}

tokenized_files.into { freqs_tokens; kmers_tokens }

process frequencies {

    input:
    file tokenized_file from freqs_tokens
    file 'freqs.py' from Channel.value(python_freqs.text)

    output:
    file 'freqs_*' into freqs_files

    """
    #!/usr/bin/env python3

    from freqs import make_frequency
    
    make_frequency("$tokenized_file")

    """
}


process kmers {

    input:
    file tokenized_file from kmers_tokens
    file 'kmers.py' from Channel.value(python_kmers.text)

    output:
    file 'kmers_*' into kmers_files

    """
    #!/usr/bin/env python3

    from kmers import find_kmers

    find_kmers("$tokenized_file")

    """
}

process merge {

    publishDir "results", mode: "copy"

    input:
    file 'merger.py' from Channel.value(python_merger.text)

    file freqs_file from freqs_files.collect()
    file kmers_file from kmers_files.collect()

    output:
    file 'result.json' into result
    

    """
    #!/usr/bin/env python3
    
    from merger import merger

    merger(".")

    """
}

