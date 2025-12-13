program define missforest_rf_master
    version 18.0
    // Options:
    // - Target(varlist min=0): optional list of target variables; default is auto-detect all columns with missinng values
    // - Saveas(string): REQUIRED output path for imputed training dataset (.dta)
    // - NewData(string): optional path to new dataset for prediction (.dta)
    // - Overwrite: allow overwriting existing files
    // - Verbose: increase console detail
    // - NImp(integer 10): n_estimators for RF inside IterativeImputer (MissForest step)
    // - NModel(integer 500): n_estimators for RandomForest models (per target)
    // - MaxIter(integer 10): max iterations for iterative imputation
    // - RandomState(integer 0): random seed for reproducibility
    // - NJobs(integer 1): parallel jobs for RF models (use -1 for all cores)
    // - TopFeatures(integer 0): top N features to report per target (use 0 to print all)
    // - MaxDepth(integer 0): RF max_depth (0 means None)
    // - MinSamplesLeaf(integer 1): RF min_samples_leaf
    // - Uncertainty: compute and save prediction uncertainty (per-tree std for regression; entropy for classification)
    //
    // Example:
    // . missforest_rf_master, saveas("train_imputed.dta") verbose overwrite nmodel(1000) randomstate(42) njobs(-1) topfeatures(15)

    syntax [, Target(varlist min=0) Saveas(string) NewData(string) Overwrite Verbose ///
             NImp(integer 10) NModel(integer 500) MaxIter(integer 10) RandomState(integer 0) ///
             NJobs(integer 1) TopFeatures(integer 10) MaxDepth(integer 0) MinSamplesLeaf(integer 1) Uncertainty]
    
    // Require Saveas()
    if ("`saveas'" == "") {
        di as err "Option saveas() is required."
        exit 198
    }

    // Flags (Stata) - no need to pass explicitly; Python reads from _st.options
    local verboseflag = "`verbose'" != ""
    local overwriteflag = "`overwrite'" != ""
    local uncertaintyflag = "`uncertainty'" != ""

    // Optional: user feedback on parsed options
    if `verboseflag' {
        di as txt "Parsed options: target(`target') saveas(`saveas') newdata(`newdata')"
        di as txt "Flags: overwrite(`overwriteflag) verbose(`verboseflag') uncertainty(`uncertaintyflag')"
    }

    // Hand off to Python
    python do "C:\path\to\_mf_rf_prgrm.py"
end

