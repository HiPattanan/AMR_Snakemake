configfile: "path/to/config.yml"

DIR = config['AMR_config']['DIR']

rule roary:
	input:
		"{dir}/renamed_gff".format(dir=DIR)
	output:
		directory("{dir}/roary".format(dir=DIR)),
		"{dir}/roary.bash".format(dir=DIR)
	params:
		script= "{dir}/roary_plots.py".format(dir=DIR)
	shell:
		"""
		mkdir -p {output[0]}/
		echo '#!/bin/bash' > {output[1]}
		echo '#SBATCH --job-name=roary' >> {output[1]}
		echo '#SBATCH --ntasks=8' >> {output[1]}
		echo '#SBATCH -o %j.out' >> {output[1]}
		echo '#SBATCH -e %j.err' >> {output[1]}
		echo 'roary -f {output[0]}/ -p 24 -e -n -v {input}/*.gff ' >> {output[1]}
		echo 'wait' >> {output[1]}
		echo 'mv {output[0]}/*/* {output[0]}/ && rm -r {output[0]}/*/ ' >> {output[1]}
		echo 'wait' >> {output[1]}
		echo 'python {params.script} {output[0]}/accessory_binary_genes.fa.newick {output[0]}/gene_presence_absence.csv --label' >> {output[1]}
		chmod +x {output[1]}
		sbatch {output[1]}
		"""
