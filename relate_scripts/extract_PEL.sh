module load gcc/13.2.0
module load R/4.3.2-mkl
module load perl-modules/1.0

MY_PATH="PATH/TO/DATA"
PATH_TO_RELATE=~/relate

run_extract () {

        $PATH_TO_RELATE/bin/RelateExtract \
                --mode SubTreesForSubpopulation \
                --anc $1 \
                --mut $2 \
                --poplabels $3 \
                --pop_of_interest AMR \
                -o $4
}


for chr in $(cat relate_chr.txt); do

        anc_input=$(find "$MY_PATH/popsize" -name "popsizePELAI_chr${chr}.anc.gz" -type f)
        mut_input=$(find "$MY_PATH/popsize" -name "popsizePELAI_chr${chr}.mut.gz" -type f)

        poplabels_input=$(find "$MY_PATH/input" -name "PELAI.poplabels" -type f)

        outfile="$MY_PATH/popsize/AMRextract_${chr}"

        run_extract "$anc_input" "$mut_input" "$poplabels_input" "$outfile"

done
