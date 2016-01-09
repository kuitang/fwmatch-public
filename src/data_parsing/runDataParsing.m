% Specail Note: 
% In order to get the code running, first thing to do is to 
% copy all the csv files into one folder, and remember the folder path.
% The csv files you need are as follows
%
% comenBnryStatesEFI.csv
% comotBnryStatesEFI.csv
% compmBnryStatesEFI.csv
% eq1BnryStatesEFI.csv
% eq2BnryStatesEFI.csv
% fi1BnryStatesEFI.csv
% vol1AbsBnryStatesEFI.csv
% nlp_binary_features.csv
%
% This code actually can access all subfolders and read all csv files
% into the sytem. However, the issue for our data is that there are
% TWO csv files(vol1BnryStatesEFI.csv and vol1AbsBnryStatesEFI.csv) 
% with SAME VARIABLES inside, which causes the merging data failure.
%
% Basically by running this collect_data.m, you will be asked to 
% locate the folder containing your data. After that, the data will
% be saved with name 'All_Data', and the meta-data will be saved as
% 'Meta_Data'.


% call retrieveCSV() to obtain the full paths of all csv files
csvlist = retrieveCSV('data/csv/');
% call combineTable() to merge all data into a single data table
[data_clean, variable_names] = combineTable(csvlist);

data_clean = data_clean(~any(isnan(data_clean),2),:);

save('data/mat/Clean_Data.mat', 'data_clean', 'variable_names','-v7.3');
