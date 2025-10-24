#!/usr/bin/env nextflow
nextflow.enable.dsl=2

/*
 Minimal Nextflow skeleton for nf-cancer-variant-demo
*/

params.reads  = "./data/*.fastq.gz"
params.outdir = "./results"

process QC {
    publishDir "${params.outdir}/qc", mode: 'copy'
    input:
        path fastq
    output:
        path "*.txt"
    script:
    """
    echo "Running QC on ${fastq.getName()}" > qc_${fastq.getName()}.txt
    """
}

workflow {
    Channel
        .fromPath(params.reads)
        .ifEmpty { error "No input FASTQ found in ${params.reads}" }
        | QC
}
