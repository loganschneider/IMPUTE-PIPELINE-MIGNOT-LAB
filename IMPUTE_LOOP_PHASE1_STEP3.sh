#!/bin/sh
#1 - chromosome number
#2 total length of chr
#3 file name
for i in `seq 0 $2` 
do
interval=`echo $i'e6 '$(($i +1))'e6'`
command=`echo ./impute2 -known_haps_g "$3"_CHR"$1".haps -h /srv/gsfs0/projects/mignot/IMPUTE_REFERENCE_PHASE1/ALL.chr"$1".integrated_phase1_v3.20101123.snps_indels_svs.genotypes.nomono.haplotypes.gz -l /srv/gsfs0/projects/mignot/IMPUTE_REFERENCE_PHASE1/ALL.chr"$1".integrated_phase1_v3.20101123.snps_indels_svs.genotypes.nomono.legend.gz -m /srv/gsfs0/projects/mignot/IMPUTE_REFERENCE_PHASE1/genetic_map_chr"$1"_combined_b37.txt -int "$interval" -buffer 500 -Ne 20000 -o CHR"$1"_"$3"."$i"`
touch tmpchr"$1".$i.sh
chmod 755 tmpchr"$1".$i.sh
echo \#\!/bin/bash >tmpchr"$1".$i.sh
echo \#$ -N EM_$i.chr"$1" >>tmpchr"$1".$i.sh
echo \#$ -hold_jid shapeit_array  >>tmpchr"$1".$i.sh
echo \#$ -l h_vmem=10g >>tmpchr"$1".$i.sh
echo \#$ -l h_rt=6:00:00 >>tmpchr"$1".$i.sh
#echo \#$ -pe shm 1 >>tmpchr"$1".$i.sh
echo \#$ -w e >>tmpchr"$1".$i.sh
echo $command >> tmpchr"$1".$i.sh
qsub -V -cwd tmpchr"$1".$i.sh
done
