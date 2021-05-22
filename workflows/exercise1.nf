#!/usr/bin/env nextflow

process helloWorld {
    echo true

    '''
    #!/usr/bin/env python

    print("Hello World")
    '''
}
