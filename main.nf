#!/usr/bin/env nextflow


python_common = Channel.fromPath("./lib/common.py")
python_common.into { tokenize_common; kmer_common; table_scan_common }

python_script_2 = Channel.fromPath("./lib/exercise2.py")
python_script_3 = Channel.fromPath("./lib/exercise3.py")
python_script_4 = Channel.fromPath("./lib/exercise4.py")


raeuber_text = Channel.fromPath("./raeuber.txt")
raeuber_text.into { raeuber_text_tokenize; raeuber_text_kmer }

freqs= Channel.fromPath("./results/freqs.json")

parts_sql = Channel.fromPath("./parts.sql")
db = Channel.fromPath("./sample.db")


process tokenize {
    
    echo true

    publishDir "./results", mode: 'copy'

    input:
    path 'raeuber.txt' from raeuber_text_tokenize

    path 'common.py' from tokenize_common
    path 'exercise2.py' from python_script_2

    output:
    file 'freqs.json' into out_file_freqs

    '''
    #!/usr/bin/env python3

    from exercise2 import make_frequency

    make_frequency("raeuber.txt")

    '''
}

process kmer {
    
    echo true

    publishDir "./results", mode: 'copy'

    input:
    path 'common.py' from kmer_common
    path 'raeuber.txt' from raeuber_text_kmer
    path 'exercise3.py' from python_script_3

    output:
    file 'kmers.json' into out_file_kmers

    '''
    #!/usr/bin/env python3

    from exercise3 import find_kmers

    find_kmers("raeuber.txt")

    '''


}


process table_scan {
    
    echo true

    publishDir "./results", mode: 'copy'

    input:
    path 'common.py' from table_scan_common
    path 'parts.sql' from parts_sql
    path 'exercise4.py' from python_script_4
    path 'sample.db' from db

    /* output: */
    /* file 'kmers.json' into out_file */

    '''
    #!/usr/bin/env python3

    from exercise4 import table_scan

    table_scan("parts.sql")

    '''


}

