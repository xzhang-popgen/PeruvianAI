module load gcc/13.2.0
module load R/4.3.2-mkl
module load perl-modules/1.0

PATH_TO_RELATE=~/relate
MY_PATH="PATH/TO/DATA"

relate_output="$MY_PATH/PELAI"
output_file="${MY_PATH}/popsize/popsizePELAI"

#STEP 2: Use .anc/.muc files from relate output to generate .coal file
${PATH_TO_RELATE}/scripts/EstimatePopulationSize/EstimatePopulationSize.sh \
        -i $relate_output \
        -o $output_file \
        -m 1.25e-8 \
        -N 30000 \
        --chr "relate_chr.txt" \
        --years_per_gen 28 \
        --threshold 0 \
        --num_iter 5 \
        --poplabels $MY_PATH/input/PELAI.poplabels \
        --threads 5 \
        --memory 2 \
        --seed $RANDOM
