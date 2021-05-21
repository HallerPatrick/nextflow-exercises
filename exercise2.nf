#!/usr/bin/env nextflow


python_script = Channel.fromPath("./exercise2.py")
raeuber_text = Channel.fromPath("./raeuber.txt")
freqs= Channel.fromPath("./freqs.json")


process tokenize {
    
    echo true

    publishDir ".", mode: 'copy'

    input:
    path 'raeuber.txt' from raeuber_text
    path 'exercise2.py' from python_script

    output:
    file 'frequencies.json' into out_file

    '''
    #!/usr/bin/env python3

    from exercise2 import tokenize

    tokenize("raeuber.txt")

    '''


}

