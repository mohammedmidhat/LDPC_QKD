# LDPC_DEC
**This is the generating scripts directory**

**`alist_code_files/`**
Has the LDPC in the alist format

**`belief_propg_Verilog_syntax/`**
Has snippets of the decoder Verilog code. These snippets are used by decoder_files_gen.py
These snippets are static. i.e. they don't depend on the LDPC code

**`bram_code_msg_coe_file/`**
Where the geenrated .coe files live

**`decoder_Verilog_files/`**
Where the generated Verilog files live

**`decoder_files_gen.py`**
Generates Verilog files

**`BRAM_data_gen_LDPC_par.py`**
Generate .coe files including the non-zero circulant data files
and a msg.coe file initialized with all-zero rows

**`code_parsing_testbench.m`**
Compares the generated .coe files against the LDPC code in the alist format
It uses alist_to_mat.m to fetch the code from the alist format file into an array
variable in Matlab