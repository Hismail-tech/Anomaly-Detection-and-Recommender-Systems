function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    % BY me, because pval will be a value between 0 and 1 for all data
    % points, we want to step through from the min_pval estimated to the
    % max_pval estimated with the step size of to find the best espilon
    % that correctly classifies the data- having the highest F1 score. 
    
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions
    
        cvPredictions = (pval < epsilon); 
            
    % calculating true positive (tp)- the data values our algorithm correctly classifies
    % false positive (fp)- the data that are actually not anomaly but our
    % algorithm classifies as anomaly
    % false positive (fn)- the data that are actually anomaly but our
    % algorithm classifies as not having anomally
    
        fp = sum((cvPredictions == 1) & (yval == 0));
        tp = sum((cvPredictions == 1) & (yval == 1));
        fn = sum((cvPredictions == 0) & (yval == 1));
    
    % calculating the precision- 'prec', recall- 'rec', F1 score. 
        prec = tp/ (tp + fp);
        rec = tp / (tp + fn);
        F1 = 2 * prec * rec   / (prec + rec);
        
     
    % =============================================================

    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon; % epsilon will be the point at which we found the highest F1 score
    end
end

end
