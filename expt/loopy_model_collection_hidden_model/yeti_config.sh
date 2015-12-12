#!/bin/sh
#yeti_config.sh

#Torque script to run Matlab program

#Torque directives
#PBS -N loopy_model_collection_hidden_model
#PBS -W group_list=yetidsi
#PBS -l nodes=1,walltime=12:00:00,mem=800mb
#PBS -m abe
#PBS -M 1live.life.queen.size1@gmail.com
#PBS -V
#PBS -t 1-120

#set output and error directories (SSCC example here)
#PBS -o localhost:/vega/dsi/users/rt2544/fwMatch/expt/loopy_model_collection_hidden_model/yeti_logs/
#PBS -e localhost:/vega/dsi/users/rt2544/fwMatch/expt/loopy_model_collection_hidden_model/yeti_logs/

#Command below is to execute Matlab code for Job Array (Example 4) so that each part writes own output
./run.sh loopy_model_collection_hidden_model $PBS_ARRAYID > expt/loopy_model_collection_hidden_model/job_logs/matoutfile.$PBS_ARRAYID
#End of script
