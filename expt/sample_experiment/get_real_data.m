function [data,variable_names] = get_real_data(varargin)

    % load samples and get only variables that were selected in config file
    load 'data/mat/real_rank_bounded_data/Clean_Data.mat' data_clean variable_names;
    
    num_samples = size(data_clean,1);
    
    if nargin < 1
        order = 1:num_samples;
    elseif nargin == 1 && varargin{1} <= num_samples
        order = randperm(varargin{1});
    else
        error('Usage : get_real_data(number_of_samples) or get_real_data()');
    end
        
    data = data_clean(order,:);

    clear data_clean

end
