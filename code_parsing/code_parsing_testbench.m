% testbench for BRAM_data_gen_LDPC_par.py
% tests against (155,93).txt and the code_[n].coe
% files generated from it

% Author: Mohammed Al Ai Baky
% Created: 4/20/2018


H = alist_to_mat('(155,93).txt');
circ_size = 31;


% Parsing the code_[n].coe files

code_file = fopen('code_0.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([1:31],[1:31])))
    display('fail_0');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([1:31],[1:31])))
    display('fail_0');
end

fclose(code_file);


code_file = fopen('code_1.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([1:31],[32:62])))
    display('fail_1');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([1:31],[32:62])))
    display('fail_1');
end

fclose(code_file);


code_file = fopen('code_2.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([1:31],[63:93])))
    display('fail_2');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([1:31],[63:93])))
    display('fail_2');
end

fclose(code_file);


code_file = fopen('code_3.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([1:31],[94:124])))
    display('fail_3');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([1:31],[94:124])))
    display('fail_3');
end

fclose(code_file);


code_file = fopen('code_4.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([1:31],[125:155])))
    display('fail_4');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([1:31],[125:155])))
    display('fail_4');
end

fclose(code_file);


code_file = fopen('code_5.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([32:62],[1:31])))
    display('fail_5');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([32:62],[1:31])))
    display('fail_5');
end

fclose(code_file);


code_file = fopen('code_6.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([32:62],[32:62])))
    display('fail_6');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([32:62],[32:62])))
    display('fail_6');
end

fclose(code_file);

code_file = fopen('code_7.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([32:62],[63:93])))
    display('fail_7');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([32:62],[63:93])))
    display('fail_7');
end

fclose(code_file);

code_file = fopen('code_8.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([32:62],[94:124])))
    display('fail_8');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([32:62],[94:124])))
    display('fail_8');
end

fclose(code_file);

code_file = fopen('code_9.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([32:62],[125:155])))
    display('fail_9');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([32:62],[125:155])))
    display('fail_9');
end

fclose(code_file);


code_file = fopen('code_10.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([63:93],[1:31])))
    display('fail_10');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([63:93],[1:31])))
    display('fail_10');
end

fclose(code_file);


code_file = fopen('code_11.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([63:93],[32:62])))
    display('fail_11');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([63:93],[32:62])))
    display('fail_11');
end

fclose(code_file);


code_file = fopen('code_12.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([63:93],[63:93])))
    display('fail_12');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([63:93],[63:93])))
    display('fail_12');
end

fclose(code_file);


code_file = fopen('code_13.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([63:93],[94:124])))
    display('fail_13');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([63:93],[94:124])))
    display('fail_13');
end

fclose(code_file);


code_file = fopen('code_14.coe');

% skip the first two lines
line = fgetl(code_file);
line = fgetl(code_file);

% check neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(i, bin2dec(line)+1) = 1;
    line = fgetl(code_file);
end
% check neighbors verification
if(~isequal(H_circ,H([63:93],[125:155])))
    display('fail_14');
end

% variable neighbors parsing
H_circ = zeros(circ_size,circ_size);
for i=1:circ_size
    line = fgets(code_file, 6);
    H_circ(bin2dec(line)+1, i) = 1;
    line = fgetl(code_file);
end
% variable neighbors verification
if(~isequal(H_circ,H([63:93],[125:155])))
    display('fail_14');
end

fclose(code_file);
