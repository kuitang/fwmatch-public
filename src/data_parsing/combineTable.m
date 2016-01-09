function [data, variable_names] = combineTable(csvlist)
%%
% Author: Liang Wu
% Email: lw2589@columbia.edu
% Date: 2-20-2015
%
% This function takes all csv files that are provided
% as a list of full file paths, and then merge them
% into a single cell array.
% 
% It serves as part of the codes for data 
% preprocessing.
%
%%


ftable = cell(1, length(csvlist));

for i = 1 : length(csvlist)
    ftable{i} = dataset('File',csvlist{i},'Delimiter',',');
    ftable{i}.Properties.VarNames{1} = 'Date';
    ftable{i}.Date = datetime( ftable{i}.Date, 'convertFrom', 'posixtime' );
end

data_table = ftable{1};
for i = 2 : length(ftable)
    data_table = join(data_table, ftable{i},'type', 'inner','keys', 'Date', 'mergeKeys',true);
end

% Shorten the variable names
data_table.Date = [];
variable_names = data_table.Properties.VarNames;
for i = 1:length(variable_names)
    var = variable_names{i};
    
    var = strrep(var, 'percent_change_', '%_');
    var = strrep(var, 'difference_', 'diff_');
    var = strrep(var, 'original_', '');
    var = strrep(var, 'location_', '');
    variable_names{i} = var;
end

data = double(data_table);
