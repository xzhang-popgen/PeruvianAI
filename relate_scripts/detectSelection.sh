run_selection () {

        $PATH_TO_RELATE/scripts/DetectSelection/DetectSelection.sh \
                -i $1 \
                -o $2 \
                -m 1.25e-8 \
                --first_bp $3 \
                --last_bp $4 \
                --years_per_gen 28

}


while read -r region; do

    echo "$region"
    chr=$(echo "$region" | awk '{print $1}')
    archaic_start=$(echo "$region" | awk '{print $3}')
    archaic_end=$(echo "$region" | awk '{print $4}')
    
    input_filename="$MY_PATH/popsize/AMRextract_$chr"
    output_filename="${MY_PATH}/chr${chr}/selectionAMR_${chr}_${archaic_start}-${archaic_end}"

    run_selection $input_filename $output_filename $archaic_start $archaic_end

    echo -e "Done.\n"

done < ~/sampleLists/archaic_regions.txt
