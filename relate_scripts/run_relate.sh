PATH_TO_RELATE=~/relate
MY_PATH="PATH/TO/DATA"
MAP_PATH="PATH/TO/GENOME/MAP"

chr=1

haps_outname="$MY_PATH/input/PELAI_${chr}"
annot_name="$MY_PATH/input/PELAI_${chr}"


#STEP 1: Generate anc/muc files
${PATH_TO_RELATE}/scripts/RelateParallel/RelateParallel.sh \
	--mode ALL \
	-m 1.25e-8 \
	-N 30000 \
	--haps $annot_name.haps.gz \
	--sample $annot_name.sample.gz \
	--map $MAP_PATH/genetic_map_GRCh37_chr${chr}.txt \
	--seed $RANDOM \
	--memory 1 \
	--threads 4 \
	-o PELAI_${chr}
