## This script generates the decoder_[n]_[m].v file, which includes:
## 1- the BRAM instantiations for decoder_[code_spec].v file
## 2- var and ckh modules instantiations
## 3- belief propagation flow
##
## Note: The script assumes the neighbor indices are ordered
##       ascendingly in the alist code file
##
## By:  Mohammed Al Ai Baky, 4/21/2018

import math
import os


script_dirname = os.path.dirname(__file__)
decoder_Verilog_files_dirname = script_dirname + "\\decoder_Verilog_files"
belief_propg_Verilog_dirname = script_dirname + "\\belief_propg_Verilog_syntax"


## Module parameters
max_iter = 30
log2max_iter = math.ceil(math.log2(max_iter))
INT = 8
FRAC = 8


## Parse LDPC code file in alist format
alist_code_dirname = script_dirname + "\\alist_code_files"
## change this line to open a different alist code file
alist_code_filename = os.path.join(alist_code_dirname, "Frolov_1024_0.5.txt")
code_f = open(alist_code_filename)

n = 2048
m = 1024
deg_v_max = 7
deg_c_max = 10
circ_size = 128
log2circ_size = math.ceil(math.log2(circ_size))+1       ## The extra bit to allow the circulant itertor to go above circ_size to signal the circulant scanning is done

var_neighbors = {}
chk_neighbors = {}


skip_lines = 4
for i in range(skip_lines):
	code_f.readline()

for i in range(n):
    line = code_f.readline()[:-2]   ## mighe change based on the file
    line = line.split(' ')          ## mighe change based on the file 'space' format
    var_neighbors[i] = line

for i in range(m):
    line = code_f.readline()[:-2]   ## mighe change based on the file
    line = line.split(' ')          ## mighe change based on the file 'space' format
    chk_neighbors[i] = line

code_f.close()


## Map non-zero circulant addresses to ascending index
circ_addr_map = {}
circ_addr_map_ind = 1

for j in range(int(m/circ_size)):
    for i in chk_neighbors[j*circ_size]:
        if(i != '0'):
            circ_addr_map[(j,int((int(i)-1)/circ_size))] = circ_addr_map_ind
            circ_addr_map_ind += 1

num_non_zero_circ = circ_addr_map_ind - 1



## Write decoder_[n]_[m].v
decoder_filename = os.path.join(decoder_Verilog_files_dirname, "decoder_"+str(n)+"_"+str(m)+".v")
decoder_f = open(decoder_filename,"w")
## Writing module parameters
decoder_f.write("module decoder#(")
decoder_f.write("parameter max_iter = "+str(max_iter)+", parameter log2max_iter = "+str(log2max_iter)+", parameter INT = "+str(INT)+", parameter FRAC = "+str(FRAC)+", parameter deg_v = "+str(deg_v_max)+", parameter deg_c = "+str(deg_c_max)+",\n")
decoder_f.write("\t\t\t\tparameter circ = "+str(circ_size)+", parameter log2circ = "+str(log2circ_size)+", parameter n = "+str(n)+")(\n")


## Writing module I/O, logic signals and registers instantiation
belief_propg_filename = os.path.join(belief_propg_Verilog_dirname, "belief_propg_flow_0.v")
belief_propg_flow_0_f = open(belief_propg_filename)
for i in belief_propg_flow_0_f.readlines():
        decoder_f.write(i)
belief_propg_flow_0_f.close()


## Writing code bram instantiation
decoder_f.write("wire [log2circ-1:0] circ_addr;\n")
decoder_f.write("assign circ_addr = (chk_r)? circ+circ_iter: circ_iter;\n\n")

for i in range(num_non_zero_circ):
    decoder_f.write("wire [log2circ-2:0] circ_"+str(i+1)+"_data;\n")
    decoder_f.write("circ_"+str(i+1)+" circ_"+str(i+1)+"_inst(\n")
    decoder_f.write(".clka(clk),\n")
    decoder_f.write(".addra(circ_addr),\n")
    decoder_f.write(".douta(circ_"+str(i+1)+"_data)\n")
    decoder_f.write(");\n\n")

decoder_f.write("\n")


## Writing msg bram instantiation
decoder_f.write("wire [log2circ-1:0] circ_msg_addr_w;\n")
decoder_f.write("assign circ_msg_addr_w = (chk_w)? circ+circ_iter_: circ_iter_;\n\n")

for i in range(num_non_zero_circ):
    decoder_f.write("wire [log2circ-1:0] circ_"+str(i+1)+"_msg_addr_r;\n")
    decoder_f.write("assign circ_"+str(i+1)+"_msg_addr_r = (chk_r)? circ+circ_"+str(i+1)+"_data: circ_"+str(i+1)+"_data;\n")
    decoder_f.write("wire [INT+FRAC-1:0] circ_"+str(i+1)+"_msg_data_in;\n")
    decoder_f.write("wire [INT+FRAC-1:0] circ_"+str(i+1)+"_msg_data_out;\n")
    decoder_f.write("circ_"+str(i+1)+"_msg circ_"+str(i+1)+"_msg_inst(\n")
    decoder_f.write(".clka(clk),\n")
    decoder_f.write(".wea(1'b1),\n")
    decoder_f.write(".addra(circ_msg_addr_w),\n")
    decoder_f.write(".dina(circ_"+str(i+1)+"_msg_data_in),\n")
    decoder_f.write(".clkb(clk),\n")
    decoder_f.write(".addrb(circ_"+str(i+1)+"_msg_addr_r),\n")
    decoder_f.write(".doutb(circ_"+str(i+1)+"_msg_data_out)\n")
    decoder_f.write(");\n\n")

decoder_f.write("\n")


## Write syn module signal instantiation
for i in range(int(m/circ_size)):
    bit_order = 1
    for j in range(int(n/circ_size)):
        if((i,j) in circ_addr_map):
            decoder_f.write("wire circ_chk_"+str(i+1)+"_bit_"+str(bit_order)+" = dec_cw["+str(j)+"*circ+circ_"+str(circ_addr_map[(i,j)])+"_data];\n")
            bit_order += 1
    decoder_f.write("\n")

decoder_f.write("\n")


## Write syn module instantiation
for i in range(int(m/circ_size)):
    bit_order = 1
    decoder_f.write("wire syn_res_circ_"+str(i+1)+";\n\n")
    decoder_f.write("syn syn_"+str(i+1)+"_inst (\n")
    for j in range(int(n/circ_size)):
        if((i,j) in circ_addr_map):
            decoder_f.write(".bit_"+str(bit_order)+"(circ_chk_"+str(i+1)+"_bit_"+str(bit_order)+"),\n")
            bit_order += 1
            
    for j in range(bit_order, deg_c_max+1):
        decoder_f.write(".bit_"+str(j)+"(0),\n")
        
    decoder_f.write(".result(syn_res_circ_"+str(i+1)+")\n")
    decoder_f.write(");\n\n")

decoder_f.write("wire syn_res;\n")
decoder_f.write("assign syn_res = ")
for i in range(int(m/circ_size)-1):
    decoder_f.write("syn_res_circ_"+str(i+1)+"|")
decoder_f.write("syn_res_circ_"+str(int(m/circ_size))+";\n\n")


## Write var and chk module signals instantiation
for i in range(num_non_zero_circ):
    decoder_f.write("wire [INT+FRAC-1:0] circ_"+str(i+1)+"_msg_data_vr;\n")
decoder_f.write("\n")

for i in range(num_non_zero_circ):
    decoder_f.write("wire [INT+FRAC-1:0] circ_"+str(i+1)+"_msg_data_cn;\n")
decoder_f.write("\n")

for i in range(num_non_zero_circ):
    decoder_f.write("assign circ_"+str(i+1)+"_msg_data_in = (chk_r) ? circ_"+str(i+1)+"_msg_data_vr : circ_"+str(i+1)+"_msg_data_cn;\n")
decoder_f.write("\n")


## Write chk module instantiation
data_width = INT+FRAC
max_value = str(data_width)+"'b"+''.join(['1' for i in range(data_width-1)])

for i in range(int(m/circ_size)):
    decoder_f.write("cn cn_"+str(i+1)+"_inst (\n")

    ## In messages
    bit_order = 1
    for j in range(int(n/circ_size)):
        if((i,j) in circ_addr_map):
            decoder_f.write(".msg_in_"+str(bit_order)+"(circ_"+str(circ_addr_map[(i,j)])+"_msg_data_out),\n")
            bit_order += 1
            
    for j in range(bit_order, deg_c_max+1):
        decoder_f.write(".msg_in_"+str(j)+"("+max_value+"),\n")

    ## Out messages
    non_zero_circulants = []
    for j in range(int(n/circ_size)):
        if((i,j) in circ_addr_map):
            non_zero_circulants.append(str(circ_addr_map[(i,j)]))

    if(len(non_zero_circulants) < deg_c_max):
        for j in range(len(non_zero_circulants)):
            decoder_f.write(".msg_out_"+str(j+1)+"(circ_"+non_zero_circulants[j]+"_msg_data_cn),\n")
        for j in range(len(non_zero_circulants)+1,deg_c_max):
            decoder_f.write(".msg_out_"+str(j)+"(),\n")
        decoder_f.write(".msg_out_"+str(deg_c_max)+"()\n")
        decoder_f.write(");\n\n")
    else:
        for j in range(len(non_zero_circulants)-1):
            decoder_f.write(".msg_out_"+str(j+1)+"(circ_"+non_zero_circulants[j]+"_msg_data_cn),\n")
        decoder_f.write(".msg_out_"+str(deg_c_max)+"(circ_"+non_zero_circulants[deg_c_max-1]+"_msg_data_cn)\n")
        decoder_f.write(");\n\n")

decoder_f.write("\n")


## Write var module instantiation and its signals

## LLR signal instantiation
for i in range(int(n/circ_size)):
    decoder_f.write("wire [INT+FRAC-1:0] LLR_in_circ_"+str(i+1)+";\n")
decoder_f.write("\n")

for i in range(int(n/circ_size)):
    decoder_f.write("assign LLR_in_circ_"+str(i+1)+" = (data["+str(i)+"*circ+circ_iter_]) ? -LLR : LLR;\n")
decoder_f.write("\n\n")

## var module instantiation
for i in range(int(n/circ_size)):
    decoder_f.write("wire [INT+FRAC-1:0] belief_out_"+str(i+1)+";\n")
    decoder_f.write("wire dec_bit_"+str(i+1)+";\n")
    decoder_f.write("assign dec_bit_"+str(i+1)+" = belief_out_"+str(i+1)+"[INT+FRAC-1];\n\n")
    
    decoder_f.write("vr vn_"+str(i+1)+"_inst (\n")
    decoder_f.write(".LLR(LLR_in_circ_"+str(i+1)+"),\n")

    ## In messages
    bit_order = 1
    for j in range(int(m/circ_size)):
        if((j,i) in circ_addr_map):
            decoder_f.write(".ch_msg_"+str(bit_order)+"(circ_"+str(circ_addr_map[(j,i)])+"_msg_data_out),\n")
            bit_order += 1

    for j in range(bit_order, deg_v_max+1):
        decoder_f.write(".ch_msg_"+str(j)+"(0),\n")

    ## Out messages
    bit_order = 1
    for j in range(int(m/circ_size)):
        if((j,i) in circ_addr_map):
            decoder_f.write(".vr_msg_"+str(bit_order)+"(circ_"+str(circ_addr_map[(j,i)])+"_msg_data_vr),\n")
            bit_order += 1

    for j in range(bit_order, deg_v_max+1):
        decoder_f.write(".vr_msg_"+str(j)+"(),\n")
        

    decoder_f.write(".belief(belief_out_"+str(i+1)+")\n")
    decoder_f.write(");\n\n")

decoder_f.write("\n")


## Write belief propagation logic flow
belief_propg_filename = os.path.join(belief_propg_Verilog_dirname, "belief_propg_flow_1.v")
belief_propg_flow_1_f = open(belief_propg_filename)
for i in belief_propg_flow_1_f.readlines():
        decoder_f.write(i)
belief_propg_flow_1_f.close()

decoder_f.write("\n\n")
for i in range(int(n/circ_size)):
        decoder_f.write("\t\t\tdec_cw["+str(i)+"*circ+circ_iter_] <= dec_bit_"+str(i+1)+";\n")
decoder_f.write("\t\tend\n")
decoder_f.write("\t\telse begin\n")
decoder_f.write("\t\t\tif(nop == 4) begin\n")
decoder_f.write("\t\t\t\tcirc_iter_ <= circ_iter_ + 1;\n\n")
for i in range(int(n/circ_size)):
        decoder_f.write("\t\t\t\tdec_cw["+str(i)+"*circ+circ_iter_] <= dec_bit_"+str(i+1)+";\n")

belief_propg_filename = os.path.join(belief_propg_Verilog_dirname, "belief_propg_flow_2.v")
belief_propg_flow_2_f = open(belief_propg_filename)
for i in belief_propg_flow_2_f.readlines():
        decoder_f.write(i)
belief_propg_flow_2_f.close()


decoder_f.close()


## Write syn.v
syn_module_filename = os.path.join(decoder_Verilog_files_dirname, "syn.v")
decoder_f = open(syn_module_filename,"w")

decoder_f.write("module syn(\n")
for i in range(deg_c_max):
    decoder_f.write("\tinput bit_"+str(i+1)+",\n")
decoder_f.write("\toutput result\n")
decoder_f.write("\t);\n\n")

decoder_f.write("assign result = ")
for i in range(deg_c_max-1):
    decoder_f.write("bit_"+str(i+1)+"^")
decoder_f.write("bit_"+str(deg_c_max)+";\n\n")

decoder_f.write("endmodule\n")

decoder_f.close()


## Write min.v
min_module_filename = os.path.join(decoder_Verilog_files_dirname, "min.v")
decoder_f = open(min_module_filename,"w")

decoder_f.write("module min #(parameter INT = "+str(INT)+", parameter FRAC = "+str(FRAC)+")(\n")

## I/O
## In messages
for i in range(deg_c_max-1):
    decoder_f.write("input [INT+FRAC-1:0] msg_"+str(i+1)+",\n")
## Out message
decoder_f.write("output [INT+FRAC-1:0] msg\n")
decoder_f.write(");\n\n")

## Instantiating signals
for i in range(deg_c_max-1):
    decoder_f.write("wire [INT+FRAC-1:0] abs_msg_"+str(i+1)+";\n")
decoder_f.write("wire [INT+FRAC-1:0] abs_msg;\n\n")

## Assigning signals
for i in range(deg_c_max-1):
    decoder_f.write("assign abs_msg_"+str(i+1)+" = (msg_"+str(i+1)+"[INT+FRAC-1])? -msg_"+str(i+1)+":msg_"+str(i+1)+";\n")
decoder_f.write("\n")

## Instantiation/Assignment/Computation of intermediate signals
inputs = deg_c_max-1      ## number inputs to be summed up, inputs >= 2
intermediate_min_signals = []  ## list of 3-tuple (a,b,c) of the input/output signals to each sat_adder module
##
## We formulate the problem of signal instantiation/assignment/computation to compute
## intermediate values and eventually the total sum, as a tree where the leaf nodes
## are the deg_c_max input messages. The root node is the final absolute min value. There
## are (2*inputs-1) nodes in this tree.
## Note this results in a balanced tree minimizing the delay path between any input signal and the
## result of the n-input adder
##
num_nodes = 2*inputs-1
num_non_leaf_nodes = num_nodes - inputs
first_leaf_parent = num_non_leaf_nodes - math.ceil(inputs/2)

for i in range(num_non_leaf_nodes):
    if(i == first_leaf_parent):
        if(inputs%2 == 1):
            if(i == 0):
                intermediate_min_signals.append(("r"+str(2*i+1),"abs_msg_"+str(1),"abs_msg"))
            else:
                intermediate_min_signals.append(("r"+str(2*i+1),"abs_msg_"+str(1),"r"+str(i)))
        else:
            if(i == 0):
                intermediate_min_signals.append(("abs_msg_"+str(1),"abs_msg_"+str(2),"abs_msg"))
            else:
                intermediate_min_signals.append(("abs_msg_"+str(1),"abs_msg_"+str(2),"r"+str(i)))
    elif(i > first_leaf_parent):
        after_first_leaf_p_ind = i - first_leaf_parent
        if(inputs%2 == 1):
            intermediate_min_signals.append(("abs_msg_"+str(2*after_first_leaf_p_ind),"abs_msg_"+str(2*after_first_leaf_p_ind+1),"r"+str(i)))
        else:
            intermediate_min_signals.append(("abs_msg_"+str(2*after_first_leaf_p_ind+1),"abs_msg_"+str(2*after_first_leaf_p_ind+2),"r"+str(i)))
    else:
        if(i == 0):
            intermediate_min_signals.append(("r"+str(1),"r"+str(2),"abs_msg"))
        else:
            intermediate_min_signals.append(("r"+str(2*i+1),"r"+str(2*i+2),"r"+str(i)))

## Intermediate signal instantiation
for i in range(num_non_leaf_nodes-1):
    decoder_f.write("wire [INT+FRAC-1:0] r"+str(i+1)+"\n")
decoder_f.write("\n")

## Assignment
for i in intermediate_min_signals:
    decoder_f.write("assign "+i[2]+" = ("+i[0]+"<"+i[1]+")? "+i[0]+":"+i[1]+";\n")
decoder_f.write("\n")

## Get the product of input msgs signs in the result
min_result_str = "assign msg = ("
for i in range(deg_c_max-2):
    min_result_str += "msg_"+str(i+1)+"[INT+FRAC-1]^"
min_result_str += "msg_"+str(deg_c_max-1)+"[INT+FRAC-1])? -abs_msg:abs_msg;\n\n"
decoder_f.write(min_result_str)
decoder_f.write("endmodule")

decoder_f.close()


## Write cn.v
cn_module_filename = os.path.join(decoder_Verilog_files_dirname, "cn.v")
decoder_f = open(cn_module_filename,"w")

decoder_f.write("module cn #(parameter INT = "+str(INT)+", parameter FRAC = "+str(FRAC)+")(\n")

## I/O
## In messages
for i in range(deg_c_max):
    decoder_f.write("input [INT+FRAC-1:0] msg_in_"+str(i+1)+",\n")
## Out messages
for i in range(deg_c_max-1):
    decoder_f.write("output [INT+FRAC-1:0] msg_out_"+str(i+1)+",\n")
## last line
decoder_f.write("output [INT+FRAC-1:0] msg_out_"+str(deg_c_max)+"\n")
decoder_f.write(");\n\n")


## Writing min instantiation modules
for i in range(deg_c_max):
    msg_port_oder = 1
    decoder_f.write("min min_to_v"+str(i+1)+"_inst (\n")
    for j in list(range(1,i+1))+list(range(i+2,deg_c_max+1)):
        decoder_f.write("\t.msg_"+str(msg_port_oder)+"(msg_in_"+str(j)+"),\n")
        msg_port_oder += 1
    decoder_f.write("\t.msg(msg_out_"+str(i+1)+")\n")
    decoder_f.write("\t);\n\n")

decoder_f.write("endmodule\n")


decoder_f.close()



## Write sat_adder.v
sat_adder_module_filename = os.path.join(decoder_Verilog_files_dirname, "sat_adder.v")
decoder_f = open(sat_adder_module_filename,"w")
decoder_f.write("module sat_adder#(parameter INT = "+str(INT)+", parameter FRAC = "+str(FRAC)+")(\n")

min_value = str(data_width)+"'b1"+''.join(['0' for i in range(data_width-1)])

## I/O
decoder_f.write("\t\tinput [INT+FRAC-1:0] a,\n")
decoder_f.write("\t\tinput [INT+FRAC-1:0] b,\n")
decoder_f.write("\t\toutput [INT+FRAC-1:0] c\n")
decoder_f.write("\t);\n\n")

## signals instantiation
decoder_f.write("wire [INT+FRAC-1:0] sum;\n")
decoder_f.write("assign sum = a+b;\n\n")

decoder_f.write("wire [INT+FRAC-1:0] pos_sum;\n")
decoder_f.write("assign pos_sum = (sum[INT+FRAC-1])? "+str(max_value)+":sum;\n\n")

decoder_f.write("wire [INT+FRAC-1:0] neg_sum;\n")
decoder_f.write("assign neg_sum = (sum[INT+FRAC-1])? sum:"+str(min_value)+";\n\n")

decoder_f.write("wire [INT+FRAC-1:0] result;\n")
decoder_f.write("assign result = (a[INT+FRAC-1])? neg_sum:pos_sum;\n\n")

decoder_f.write("assign c = (a[INT+FRAC-1]^b[INT+FRAC-1]) ? sum:result;\n\n")

decoder_f.write("endmodule\n")


decoder_f.close()



## Write vr.v
vr_module_filename = os.path.join(decoder_Verilog_files_dirname, "vr.v")
decoder_f = open(vr_module_filename,"w")

decoder_f.write("module vr#(parameter INT = "+str(INT)+", parameter FRAC = "+str(FRAC)+")(\n")

## I/O
## In messages
decoder_f.write("\tinput [INT+FRAC-1:0] LLR,\n")
for i in range(deg_v_max):
    decoder_f.write("\tinput [INT+FRAC-1:0] ch_msg_"+str(i+1)+",\n")
## Out messages
for i in range(deg_v_max):
    decoder_f.write("\toutput [INT+FRAC-1:0] vr_msg_"+str(i+1)+",\n")
decoder_f.write("\toutput [INT+FRAC-1:0] belief\n")
decoder_f.write("\t);\n\n")

## signal and sat_adder module instantiation
inputs = deg_v_max+1      ## number inputs to be summed up, inputs >= 2
sat_adder_signals = []  ## list of 3-tuple (a,b,c) of the input/output signals to each sat_adder module
##
## We formulate the problem of signal and sat_adder module instantiation to compute
## intermediate values and eventually the total sum, as a tree where the leaf nodes
## are the deg_v_max+1 input messages. The root node is the final belief value. There
## are (2*inputs-1) nodes in this tree.
## sat_adders are not instantiated for the leaf nodes. Other nodes represent intermediate
## or final (root) values which also corresponds to an adder computing that value
## Note this results in a balanced tree minimizing the delay path between any input signal and the
## result of the n-input adder
## An imbalanced tree implements the adder with the same hardware utilization but results in longer
## delay paths
##
num_nodes = 2*inputs-1
num_non_leaf_nodes = num_nodes - inputs
first_leaf_parent = num_non_leaf_nodes - math.ceil(inputs/2)

for i in range(num_non_leaf_nodes):
    if(i == first_leaf_parent):
        if(inputs%2 == 1):
            if(i == 0):
                sat_adder_signals.append(("vr_msg_"+str(2*i+1)+"_int","LLR","belief"))
            else:
                sat_adder_signals.append(("vr_msg_"+str(2*i+1)+"_int","LLR","vr_msg_"+str(i)+"_int"))
        else:
            if(i == 0):
                sat_adder_signals.append(("LLR","ch_msg_"+str(1),"belief"))
            else:
                sat_adder_signals.append(("LLR","ch_msg_"+str(1),"vr_msg_"+str(i)+"_int"))
    elif(i > first_leaf_parent):
        after_first_leaf_p_ind = i - first_leaf_parent
        if(inputs%2 == 1):
            sat_adder_signals.append(("ch_msg_"+str(2*after_first_leaf_p_ind-1),"ch_msg_"+str(2*after_first_leaf_p_ind),"vr_msg_"+str(i)+"_int"))
        else:
            sat_adder_signals.append(("ch_msg_"+str(2*after_first_leaf_p_ind),"ch_msg_"+str(2*after_first_leaf_p_ind+1),"vr_msg_"+str(i)+"_int"))
    else:
        if(i == 0):
            sat_adder_signals.append(("vr_msg_"+str(2*i+1)+"_int","vr_msg_"+str(2*i+2)+"_int","belief"))
        else:
            sat_adder_signals.append(("vr_msg_"+str(2*i+1)+"_int","vr_msg_"+str(2*i+2)+"_int","vr_msg_"+str(i)+"_int"))

## Intermediate signal instantiation
for i in range(num_non_leaf_nodes-1):
    decoder_f.write("wire [INT+FRAC-1:0] vr_msg_"+str(i+1)+"_int;\n")
decoder_f.write("\n\n")

# Instintiate n-input adder sat_adders
for idx, val in enumerate(sat_adder_signals):
    decoder_f.write("sat_adder sat_adder_"+str(idx)+"(\n")
    decoder_f.write(".a("+val[0]+"),\n")
    decoder_f.write(".b("+val[1]+"),\n")
    decoder_f.write(".c("+val[2]+")\n")
    decoder_f.write(");\n\n")
    
decoder_f.write("\n")

# Instintiate sat_adders to get the output msg
for i in range(deg_v_max):
    idx += 1
    decoder_f.write("sat_adder sat_adder_"+str(idx)+"(\n")
    decoder_f.write(".a(belief),\n")
    decoder_f.write(".b(-ch_msg_"+str(i+1)+"),\n")
    decoder_f.write(".c(vr_msg_"+str(i+1)+")\n")
    decoder_f.write(");\n\n")
    
decoder_f.write("\n")
decoder_f.write("endmodule\n")

decoder_f.close()



## Write decoder_[n]_[m]_sim.v
decoder_sim_filename = os.path.join(decoder_Verilog_files_dirname, "decoder_"+str(n)+"_"+str(m)+"_sim.v")
decoder_f = open(decoder_sim_filename,"w")

## somulation timescale
decoder_f.write("`timescale 1ns / 1ps\n\n")

decoder_f.write("module decoder_"+str(n)+"_"+str(m)+"_sim;\n\n")

## parameters
decoder_f.write("\tparameter half_period = 2;\n")
decoder_f.write("\tparameter circ = "+str(circ_size)+";\n")
decoder_f.write("\tparameter log2circ = "+str(log2circ_size)+";\n")
decoder_f.write("\tparameter log2max_iter = "+str(log2max_iter)+";\n")
decoder_f.write("\tparameter max_iter = "+str(max_iter)+";\n")
decoder_f.write("\tparameter INT = "+str(INT)+";\n")
decoder_f.write("\tparameter FRAC = "+str(FRAC)+";\n\n")

## registers
decoder_f.write("\t// Inputs\n")
decoder_f.write("\treg clk;\n")
decoder_f.write("\treg rst;\n")
decoder_f.write("\treg [log2max_iter-1:0] iter_s;\n")
decoder_f.write("\treg [log2circ-1:0] circ_iter_s;\n")
decoder_f.write("\treg tog;\n\n")

## wires
decoder_f.write("\t// Outputs\n")
decoder_f.write("\twire success;\n")
decoder_f.write("\twire [4:0] iterations;\n\n")

## DUT instantiation
decoder_f.write("\tdecoder uut (\n")
decoder_f.write("\t\t.clk(clk),\n")
decoder_f.write("\t\t.rst(rst),\n")
decoder_f.write("\t\t.success(success),\n")
decoder_f.write("\t\t.iterations(iterations)\n")
decoder_f.write("\t);\n\n")

## clock gen
decoder_f.write("\talways begin\n")
decoder_f.write("\t#half_period clk <= ~clk;\n")
decoder_f.write("\tend\n\n")

## initializing simulation variables
decoder_f.write("\tinitial begin\n")
decoder_f.write("\t\t// Initialize Inputs\n")
decoder_f.write("\t\tclk = 0;\n")
decoder_f.write("\t\trst = 0;\n")
decoder_f.write("\t\ttog = 0;\t\t// For debugging the simulation\n\n")
decoder_f.write("\t\t#1\n")
decoder_f.write("\t\trst = 1;\n")
decoder_f.write("\t\t#120\n")
decoder_f.write("\t\trst = 0;\n")

## simulation tracking belief propagation logic flow
decoder_f.write("\t\t#(2+(circ+1)*2*half_period)\t\t\t// 1+(circ-1)*half_period+2*half_period+1\n")
decoder_f.write("\t\tif(uut.FSM == 3)begin\n")
decoder_f.write("\t\t\ttog = ~tog;\n")
decoder_f.write("\t\t\t$display(\"already cw\");\n")
decoder_f.write("\t\tend\n\n")
decoder_f.write("\t\telse begin\n")
decoder_f.write("\t\t\t#(2*half_period)\n")
decoder_f.write("\t\t\tfor (iter_s = 0; iter_s < max_iter; iter_s = iter_s +1) begin\n")
decoder_f.write("\t\t\t\tfor (circ_iter_s = 0; circ_iter_s < circ; circ_iter_s = circ_iter_s +1) begin\n")
decoder_f.write("\t\t\t\t\t#(2*half_period)\n")
decoder_f.write("\t\t\t\t\ttog = ~tog;\n")
for i in range(num_non_zero_circ):              ## Prints 8-digit hex values
    decoder_f.write("\t\t\t\t\t$display (\"%8h\", {{(INT+FRAC){uut.circ_"+str(i+1)+"_msg_data_in[INT+FRAC-1]}},uut.circ_"+str(i+1)+"_msg_data_in});\n")
decoder_f.write("\t\t\t\tend\n")
decoder_f.write("\t\t\t\t#(2*2*half_period)\n")
decoder_f.write("\t\t\t\tfor (circ_iter_s = 0; circ_iter_s < circ; circ_iter_s = circ_iter_s +1) begin\n")
decoder_f.write("\t\t\t\t\t#(2*half_period)\n")
decoder_f.write("\t\t\t\t\ttog = ~tog;\n")
for i in range(num_non_zero_circ):              ## Prints 8-digit hex values
    decoder_f.write("\t\t\t\t\t$display (\"%8h\", {{(INT+FRAC){uut.circ_"+str(i+1)+"_msg_data_in[INT+FRAC-1]}},uut.circ_"+str(i+1)+"_msg_data_in});\n")
decoder_f.write("\t\t\t\tend\n")
decoder_f.write("\t\t\t\t#(2*2*half_period)\n")
decoder_f.write("\t\t\t\ttog = tog;\n")
decoder_f.write("\t\t\tend\n")
decoder_f.write("\t\tend\n")
decoder_f.write("\tend\n\n")
decoder_f.write("endmodule\n")


decoder_f.close()
