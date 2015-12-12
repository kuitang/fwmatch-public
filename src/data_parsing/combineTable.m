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

start_time = datetime ( '2009-01-01 06:00:00', 'convertFrom', 'posixtime' );

for i = 1 : length(csvlist)
    ftable{i} = dataset('File',csvlist{i},'Delimiter',',');
    ftable{i}.Properties.VarNames{1} = 'Date';
    if i == 1 % fiannace
        ftable{i}.Date = datetime( ftable{i}.Date, 'ConvertFrom', 'posixtime' );
        ftable{i}(find(minute(ftable{i}.Date) > 0), :) = [];
    else % NLP
        ftable{i}.Date = datetime( ftable{i}.Date, 'convertFrom', 'posixtime' );
        ftable{i}(find(ftable{i}.Date < start_time), :) = [];
    end
    ftable{i}.Date(1)
%     ftable{i}.Date = datenum(ftable{i}.Date);
%      ftable{i} = readtable(csvlist{i});
%      ftable{i}.Properties.VariableNames{1} = 'Date';
%      ftable{i}.Date = datenum(ftable{i}.Date);
%      ftable{i}.Properties.ObsNames = ftable{i}.Date;
end

% % For binary samples
% data_table = cell2mat(data_table);
% variable_count = floor((size(data_table,2)-1)/10);
% sample_count = size(data_table,1);
% binary_samples = zeros(sample_count, variable_count);
% for i = 0:(variable_count-1)
%     binary_samples(:,i+1) = sum(data_table(:,(6+10*i):(10+10*i)),2);
% end
nlp = ftable{2};
% nlp(:,202:end) = [];
% ftable{2} = nlp;

% binarize NLP dataset
% tmp = double(nlp(:,2:end));
% num_variables = floor(size(tmp,2)/10);
% binary_samples = cell(size(tmp,1)+1,num_variables+1);
% binary_samples(1,1) = {'Date'};
% binary_samples(2:end,1) = mat2cell(nlp.Date,ones(1,length(nlp.Date)));
% for i=1:num_variables
%     binary_samples(1,i+1) = {nlp.Properties.VarNames{10*(i-1)+2}};
%     binary_samples(2:end,i+1) = mat2cell(sum(tmp(:, (6+10*(i-1)):(10+10*(i-1))),2), ones(1,size(binary_samples,1)-1));
% end
% ftable{2} = cell2dataset(binary_samples);
% nlp = ftable{2};

fin = ftable{1};
% binarize finanacial dataset
% tmp = double(fin(:,2:end));
% num_variables = floor(size(tmp,2)/11);
% binary_samples = cell(size(tmp,1)+1,num_variables+1);
% binary_samples(1,1) = {'Date'};
% binary_samples(2:end,1) = mat2cell(fin.Date,ones(1,length(fin.Date)));
% for i=1:num_variables
%     binary_samples(1,i+1) = {fin.Properties.VarNames{11*(i-1)+2}};
%     binary_samples(2:end,i+1) = mat2cell(...
%                                    max(sum(tmp(:,(7+11*(i-1)):(11+11*(i-1))),2),(0.5*tmp(:,1+(i-1)*11))), ...
%                                    ones(1,size(binary_samples,1)-1));
% end
% fin = cell2dataset(binary_samples);

% num_data = length(fin.Date);
% columns_to_be_deleted = [];
% for i=2:size(fin,2)
%     column_sum = sum(double(fin(:,i)));
%     if column_sum == num_data 
%         columns_to_be_deleted = [columns_to_be_deleted, i];
%     elseif column_sum == 0
%         columns_to_be_deleted = [columns_to_be_deleted, i];
%     elseif ~sum(double(fin(:,i)) == 1 | double(fin(:,i)) == 0) 
%         columns_to_be_deleted = [columns_to_be_deleted, i];
%     end
% end
% fin(:,columns_to_be_deleted) = [];
% 
% ftable{1} = fin;

data_table = ftable{1};
for i = 2 : length(ftable)
    data_table = join(data_table, ftable{i},'type', 'inner','keys', 'Date', 'mergeKeys',true);
end
size(data_table)
save('dataset.mat', 'fin' , 'nlp' ,'data_table', '-v7.3');

data_table.Date = [];
variable_names = data_table.Properties.VarNames;
for i = 1:length(variable_names)
    var = variable_names{i};
    
    var = strrep(var, 'percent_change_', '%_');
    var = strrep(var, 'difference_', 'diff_');
    var = strrep(var, 'original_', '');
    var = strrep(var, 'location_', '');
%     ind = strfind(var,'_NaN');
%     if isempty(ind)
%         ind = strfind(var, '_quartile');
%     end
%     var(1:ind-1)
    variable_names{i} = var;
end
save variables_short.mat variable_names;

data = double(data_table);
% convert datenumber back to date
% formatOut = 'mm-dd-yyyy';
% data_table.Date = datestr(data_table.Date, formatOut);
% formatIn = 'MM-dd-yyyy';
% data_table.Date = datetime(data_table.Date, 'InputFormat',formatIn);
% data = dataset2cell(data_table);
