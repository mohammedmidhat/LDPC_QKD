% testbench for BRAM_data_gen_LDPC_par.py
% tests against Frolov_1024_0.5.txt and the code_[n].coe
% files generated from it

% Author: Mohammed Al Ai Baky
% Created: 4/20/2018


H = alist_to_mat('Frolov_1024_0.5.txt');
circ_size = 128;
[m n] = size(H);

% Parsing the code_[n].coe files

data_width = 9;
code_f_ind = 1;

for i = 1:m/circ_size
    for j = 1:n/circ_size
        if(nnz(H([circ_size*(i-1)+1:circ_size*i],[circ_size*(j-1)+1:circ_size*j])) ~= 0)
            code_file = fopen(strcat('code_',int2str(code_f_ind),'.coe'));
            
            % skip the first two lines
            line = fgetl(code_file);
            line = fgetl(code_file);

            % check neighbors parsing
            H_circ = zeros(circ_size,circ_size);
            for k=1:circ_size
                line = fgets(code_file, data_width);
                H_circ(k, bin2dec(line)+1) = 1;
                line = fgetl(code_file);
            end
            % check neighbors verification
            if(~isequal(H_circ,H([circ_size*(i-1)+1:circ_size*i],[circ_size*(j-1)+1:circ_size*j])))
                display(strcat('fail_',int2str(code_f_ind)));
            end

            % variable neighbors parsing
            H_circ = zeros(circ_size,circ_size);
            for k=1:circ_size
                line = fgets(code_file, data_width);
                H_circ(bin2dec(line)+1, k) = 1;
                line = fgetl(code_file);
            end
            % variable neighbors verification
            if(~isequal(H_circ,H([circ_size*(i-1)+1:circ_size*i],[circ_size*(j-1)+1:circ_size*j])))
                display(strcat('fail_',int2str(code_f_ind)));
            end

            fclose(code_file);

            code_f_ind = code_f_ind + 1;
        end
    end
end
