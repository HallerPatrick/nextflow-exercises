#!/usr/bin/env nextflow


python_common = Channel.fromPath("./lib/common.py")
python_script = Channel.fromPath("./lib/exercise4.py")

parts_sql = Channel.fromPath("./parts.sql")
db = Channel.fromPath("./sample.db")

process table_scan {
    
    echo true

    publishDir "./results", mode: 'copy'

    input:
    path 'common.py' from python_common
    path 'parts.sql' from parts_sql
    path 'exercise4.py' from python_script
    path 'sample.db' from db

    /* output: */
    /* file 'kmers.json' into out_file */

    '''
    #!/usr/bin/env python3

    from exercise4 import table_scan

    table_scan("parts.sql")

    '''


}

