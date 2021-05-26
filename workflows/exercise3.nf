#!/usr/bin/env nextflow


python_common = Channel.fromPath("./lib/common.py")
python_script = Channel.fromPath("./lib/exercise3.py")
raeuber_text = Channel.fromPath("./raeuber.txt")
freqs= Channel.fromPath("./results/freqs.json")


process kmer {
    
    echo true

    publishDir "./results", mode: 'copy'

    input:
    path 'common.py' from python_common
    path 'raeuber.txt' from raeuber_text
    path 'exercise3.py' from python_script

    output:
    file 'kmers.json' into out_file

    '''
    #!/usr/bin/env python3

    from exercise3 import find_kmers

    find_kmers("raeuber.txt")

    '''


}

