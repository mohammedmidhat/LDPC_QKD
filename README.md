# LDPC_DEC
### This is a Verilog binary LDPC decoder for quasi-cyclic codes
### The design is based on the min-sum decoding algorithm
### It was written initially for the Xilinx VC707 FPGA board

The project includes the decoder FPGA files (Verilog + BRAM data .coe file)
It also includes Python scripts to generate the Verilog source and BRAM .coe files

`sat_adder/`
Has Verilog module for a 2-input adder with saturation, so if the summation result overflows,
the n-bit adder result will be saturated to the highest or least value in the n-bit range

`code_parsing_decoder_gen/`
Has python scripts for generating Verilog source and simulation codes and generating BRAM
.coe files. It has a testbench for the .coe files generation script

`LDPC_decoder_Frolov_1024_0.5/`
Has Verilog source code and simulation bench for a (2048,1024) irregular quasi-cyclic code.
The LDPC code is by Alexey Frolov