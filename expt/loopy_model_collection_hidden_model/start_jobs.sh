
# If you are having problem with line endings use ":set ff=unix" in vim

rm -f ./results/result*.mat
rm -f ./results/model_collection.mat
rm -f ./yeti_logs/*
rm -f ./job_logs/*

cd ../.. && qsub expt/loopy_model_collection_columbia_data/yeti_config.sh



