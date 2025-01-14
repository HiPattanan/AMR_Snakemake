configfile: "path/to/config.yml"

DIR = config['AMR_config']['DIR']
NAMES = config['AMR_config']['NAMES']

rule all:
  input:
    expand("{dir}/{name}/genome", dir=DIR, name=NAMES),
		expand("{dir}/{name}/amrfinder", dir=DIR, name=NAMES),
		expand("{dir}/{name}/out_prokka", dir=DIR, name=NAMES),
		expand("{dir}/{name}/prokka_rename.bash", dir=DIR, name=NAMES),
		expand("{dir}/renamed_gff", dir=DIR)

rule download_genomes:
	input:
		expand("{dir}/{name}.txt", dir=DIR, name=NAMES)
	output:
		out2 = directory("{dir}/{name}/genome".format(dir=DIR, name=NAMES))
	shell:
		"""
		mkdir -p {output.out2} && cd {output.out2}/.. && datasets download genome accession --inputfile {input}
		unzip ncbi_dataset.zip && cd ncbi_dataset/data
		for folder in *; do
			if [[ "$(basename "$folder")" == GCA* && -d "$folder" ]]; then
				cp "$folder"/* {output.out2}/;
			fi
		done
		"""

rule run_amrfinder:
	input:
		"{dir}/{name}/genome".format(dir=DIR, name=NAMES)
	output:
		directory("{dir}/{name}/amrfinder".format(dir=DIR, name=NAMES))
	shell:
		"""
		mkdir -p {output} &&
		for i in {input}/GCA*.fna ;do 
			b=$(basename "$i" .fna); amrfinder -n $i -o {output}/$b.tsv ;
		done
		"""

rule prokka_and_rename_gff:
    input:
        "{dir}/{name}/genome".format(dir=DIR, name=NAMES)
    output:
        directory("{dir}/renamed_gff".format(dir=DIR)),
        directory("{dir}/{name}/out_prokka".format(dir=DIR, name=NAMES))
    shell:
        """
        # Create the Prokka output directory
        mkdir -p {output[1]}

        # Create the rename output directory
        if [[ ! -d {output[0]} ]]; then 
            mkdir -p {output[0]}
        fi

        # Prokka command for genome annotation
        for F in {input}/GCA*.fna; do 
            N=$(basename $F .fna)
            prokka --kingdom Bacteria --genus burkholderia --locustag $N --outdir {output[1]}/$N --prefix $N $F
        done

        # Wait for all processes to finish
        wait

        # Rename and copy GFF files
        for G in {output[1]}/*/GCA*.gff; do 
            N=$(basename $G .gff)
            BASE_NAME=$(echo $N | cut -d"_" -f1-2)
            cp $G {output[0]}/$BASE_NAME-{NAMES}.gff
        done
        """
