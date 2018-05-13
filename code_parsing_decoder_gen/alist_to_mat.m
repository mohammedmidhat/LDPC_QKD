% alist_to_mat
% Reads an LDPC matrix in alist format
% return a sparse representation of it

% Author: Mohammed Al Ai Baky
% Created: 12/10/2017

function H = alist_to_mat(file)
    % Open the alist matrix file
    mat_file = fopen(file);
    
    % Create sparse matrix
    c_r = fscanf(mat_file, '%d', [1 2]);
    c = c_r(1);
    r = c_r(2);
    H = sparse(r,c);
    
    % Fetch the the max weights and weight vectors
    col_weight_max = fscanf(mat_file, '%d', 1);
    row_weight_max = fscanf(mat_file, '%d', 1);
    col_weight_arr = fscanf(mat_file, '%d', [1 c]);
    row_weight_arr = fscanf(mat_file, '%d', [1 r]);
    
    for i = 1:c
        col = fscanf(mat_file, '%d', [1 col_weight_arr(i)]);
        skip_size = col_weight_max - col_weight_arr(i);
        skip = fscanf(mat_file, '%d', [1 skip_size]);
        
        for j = col
            H(j,i) = 1;
        end
    end
    
    fclose(mat_file);
    return;
end
