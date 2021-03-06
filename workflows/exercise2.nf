#!/usr/bin/env nextflow


python_common = Channel.fromPath("./lib/common.py")
python_script = Channel.fromPath("./lib/exercise2.py")
raeuber_text = Channel.fromPath("./raeuber.txt")
freqs= Channel.fromPath("./results/freqs.json")


process tokenize {
    
    echo true

    publishDir "./results", mode: 'copy'

    input:
    path 'raeuber.txt' from raeuber_text
    path 'common.py' from python_common
    path 'exercise2.py' from python_script

    output:
    file 'freqs.json' into out_file

    '''
    #!/usr/bin/env python3

    from exercise2 import make_frequency

    make_frequency("raeuber.txt")

    '''

    '''
    #!/bin/bash

    python3 exercise2.py
    '''
}

