%% Experiment: Parameter Estimation for Real data
%  Description:
%     - Learn multiple structures with various regularizers (lambda) and
%     tolerance values 
%     - Train the parameters with respect to each of the structure learned
%     in the previous step with various values of parameter estimation
%     regularizer
%     - Predict (test) the learned models in the previous step on validation data
%     - Finally, choose the optimal model based on validation likelihood
%
%  Inputs (with example):
%    params.lambda = 1e-10;
%    params.use_built_in_lasso = false;
%
%  Quick run in MATLAB: 
%    In root folder, after loading startup.m, run:
%    runExpt('structure_learning_synthetic', 1)
%  Quick run on command line:
%    \run.sh Parameter_estimation 1

function run(params)

    %% Get the data
    X = params.data;
    sample_count = size(X,1);
    sample_order = randperm(sample_count);
    x_train = X(sample_order(1:floor(params.split*sample_count)),:);
    x_test = X(sample_order((floor(params.split*sample_count)+1):sample_count),:);
    
    %% Instantiate object that runs the algorithm
    if strcmp(params.structure_type, 'loopy')
        model_collection = LoopyModelCollection(x_train, x_test, ...
            's_lambda_count',params.s_lambda_count, ...
            's_lambda_min',params.s_lambda_min, ...
            's_lambda_max',params.s_lambda_max, ...
            'density_count',params.density_count, ...
            'density_min',params.density_min, ...
            'density_max',params.density_max, ...
            'p_lambda_count',params.p_lambda_count, ...
            'p_lambda_min',params.p_lambda_min, ...
            'p_lambda_max',params.p_lambda_max);
    else
        % when training a tree there is no need for density and structure
        % lambda
        model_collection = LoopyModelCollection(x_train, x_test, ...
            'p_lambda_count',params.p_lambda_count, ...
            'p_lambda_min',params.p_lambda_min, ...
            'p_lambda_max',params.p_lambda_max);
    end

    %% Structure Learninig
    fprintf('Structure Learning...\n');
    if strcmp(params.structure_type, 'loopy')
        % learn loopy models
        model_collection = model_collection.do_loopy_structure_learning();
    elseif strcmp(params.structure_type, 'naive')
        % Structure with no edges
        model_collection = model_collection.do_naive_bayes_structure_learning();
    else
        % learn tree model (learns single structure)
        model_collection = model_collection.do_chowliu_structure_learning();
    end
    
    % load already computed structure 
%     load(sprintf('%s/structures/%s', params.exptDir, params.structureFileName), 'model_collection');
%     model_collection = model_collection.set_p_lambdas...
%         (params.p_lambda_count, params.p_lambda_min, params.p_lambda_max);
    %% Parameter Estimation
    fprintf('Parameter Estimation...\n');
   
    % Training
    model_collection = model_collection.do_parameter_estimation( ...
        'BCFW_max_iterations', params.BCFW_max_iterations, ...
        'compute_true_logZ', params.compute_true_logZ, ...
        'reweight_denominator', params.reweight_denominator);
    
    % Saves results
    save(sprintf('%s/results/%s', params.exptDir, params.saveFileName), 'model_collection');
end

