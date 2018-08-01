# LDPC_QKD
# This is a binary LDPC decoder in Verilog written initially for the Xilinx VC707 FPGA board

# The project includes the decoder FPGA files (Verilog + BRAM data .coe file)
# It also includes Python scripts to generate the Verilog source and BRAM .coe files

# sat_adder/
# has Verilog module for a 2-input adder with saturation, so if the summation result overflows,
# the n-bit adder result will be saturated to the highest or least value in the n-bit range.

# 