import numpy as np
import math


## file must end with "\n"
f = open("small_code.txt")
f_v_neighbor_data = open("v_neighbor_data.data","w")
f_c_neighbor_data = open("c_neighbor_data.data","w")
f_neighbor_index_to_var_data = open("neighbor_index_to_var_data.data","w")
f_neighbor_index_to_ch_data = open("neighbor_index_to_ch_data.data","w")
f_v_neighbor_coe = open("v_neighbor_coe.coe","w")
f_c_neighbor_coe = open("c_neighbor_coe.coe","w")
f_neighbor_index_to_var_coe = open("neighbor_index_to_var_coe.coe","w")
f_neighbor_index_to_ch_coe = open("neighbor_index_to_ch_coe.coe","w")


skip_lines = 4
for i in range(skip_lines):
	f.readline()
	
n = 12
m = 6
deg_v = 3
deg_c = 6
col_format_spec = '#0' + str(int(math.ceil(math.log(m)/math.log(2)))+2) + 'b'
row_format_spec = '#0' + str(int(math.ceil(math.log(n)/math.log(2)))+2) + 'b'
neighbor_index_to_var_format_spec = '#0' + str(int(math.ceil(math.log(deg_v)/math.log(2)))+2) + 'b'
neighbor_index_to_ch_format_spec = '#0' + str(int(math.ceil(math.log(deg_c)/math.log(2)))+2) + 'b'


## dict: {key: str, value: list[str]}
## key: check node index, 1-indexing
## value: list of var node neighbors indices
d_ch_neighbors = {}
## dict: {key: str, value: list[str]}
## key: variable node index, 1-indexing
## value: list of check node neighbors indices
d_var_neighbors = {}

for i in range(n):
        line = f.readline()
        #line = line.split('\t')
        line = line.split(' ')
        ## to get rid of "\n"
        #line[len(line)-1] = line[len(line)-1][:-1]
        line = line[:len(line)-1]
        d_var_neighbors[str(i+1)] = line
for i in range(m):
        line = f.readline()
        #line = line.split('\t')
        line = line.split(' ')
        ## to get rid of "\n"
        #line[len(line)-1] = line[len(line)-1][:-1]
        line = line[:len(line)-1]
        d_ch_neighbors[str(i+1)] = line


v_neighbor_str = ''
c_neighbor_str = ''
neighbor_index_to_var_str = ''
neighbor_index_to_ch_str = ''

for i in range(n):
        var_neighbors = d_var_neighbors[str(i+1)]
        v_neighbor_str_aux = ''
        neighbor_index_to_ch_str_aux = ''
        for j in var_neighbors:
                v_neighbor_str_aux += format(int(j), col_format_spec)[2:]
                var_neighboring_index = d_ch_neighbors[j].index(str(i+1))
                neighbor_index_to_ch_str_aux += format(int(var_neighboring_index),
                                                        neighbor_index_to_ch_format_spec)[2:]
        v_neighbor_str = v_neighbor_str_aux + v_neighbor_str
        neighbor_index_to_ch_str = neighbor_index_to_ch_str_aux + neighbor_index_to_ch_str

for i in range(m):
        ch_neighbors = d_ch_neighbors[str(i+1)]
        c_neighbor_str_aux = ''
        neighbor_index_to_var_str_aux = ''
        for j in ch_neighbors:
                c_neighbor_str_aux += format(int(j), row_format_spec)[2:]
                ch_neighboring_index = d_var_neighbors[j].index(str(i+1))
                neighbor_index_to_var_str_aux += format(int(ch_neighboring_index),
                                                        neighbor_index_to_var_format_spec)[2:]
        c_neighbor_str = c_neighbor_str_aux + c_neighbor_str
        neighbor_index_to_var_str = neighbor_index_to_var_str_aux + neighbor_index_to_var_str

f_v_neighbor_coe.write('memory_initialization_radix=2;\n')
f_v_neighbor_coe.write('memory_initialization_vector=\n')
for i in range(n-1):
        line_width = deg_v*int(math.ceil(math.log(m)/math.log(2)))
        start_ind = (n-1-i)*line_width
        f_v_neighbor_data.write(v_neighbor_str[start_ind:start_ind+line_width]+'\n')
        f_v_neighbor_coe.write(v_neighbor_str[start_ind:start_ind+line_width]+',\n')
# Writing the last line. It has a different last character
f_v_neighbor_data.write(v_neighbor_str[:line_width])
f_v_neighbor_coe.write(v_neighbor_str[:line_width]+';')

f_c_neighbor_coe.write('memory_initialization_radix=2;\n')
f_c_neighbor_coe.write('memory_initialization_vector=\n')
for i in range(m-1):
        line_width = deg_c*int(math.ceil(math.log(n)/math.log(2)))
        start_ind = (m-1-i)*line_width
        f_c_neighbor_data.write(c_neighbor_str[start_ind:start_ind+line_width]+'\n')
        f_c_neighbor_coe.write(c_neighbor_str[start_ind:start_ind+line_width]+',\n')
# Writing the last line. It has a different last character
f_c_neighbor_data.write(c_neighbor_str[:line_width])
f_c_neighbor_coe.write(c_neighbor_str[:line_width]+';')

f_neighbor_index_to_ch_coe.write('memory_initialization_radix=2;\n')
f_neighbor_index_to_ch_coe.write('memory_initialization_vector=\n')
for i in range(n-1):
        line_width = deg_v*int(math.ceil(math.log(deg_c)/math.log(2)))
        start_ind = (n-1-i)*line_width
        f_neighbor_index_to_ch_data.write(neighbor_index_to_ch_str[start_ind:start_ind+line_width]+'\n')
        f_neighbor_index_to_ch_coe.write(neighbor_index_to_ch_str[start_ind:start_ind+line_width]+',\n')
# Writing the last line. It has a different last character
f_neighbor_index_to_ch_data.write(neighbor_index_to_ch_str[:line_width])
f_neighbor_index_to_ch_coe.write(neighbor_index_to_ch_str[:line_width]+';')

f_neighbor_index_to_var_coe.write('memory_initialization_radix=2;\n')
f_neighbor_index_to_var_coe.write('memory_initialization_vector=\n')
for i in range(m-1):
        line_width = deg_c*int(math.ceil(math.log(deg_v)/math.log(2)))
        start_ind = (m-1-i)*line_width
        f_neighbor_index_to_var_data.write(neighbor_index_to_var_str[start_ind:start_ind+line_width]+'\n')
        f_neighbor_index_to_var_coe.write(neighbor_index_to_var_str[start_ind:start_ind+line_width]+',\n')
# Writing the last line. It has a different last character
f_neighbor_index_to_var_data.write(neighbor_index_to_var_str[:line_width])
f_neighbor_index_to_var_coe.write(neighbor_index_to_var_str[:line_width]+';')


v_neighbor_str = str(len(v_neighbor_str)) + '\'b' + v_neighbor_str
c_neighbor_str = str(len(c_neighbor_str)) + '\'b' + c_neighbor_str
neighbor_index_to_var_str = str(len(neighbor_index_to_var_str)) + '\'b' + neighbor_index_to_var_str
neighbor_index_to_ch_str = str(len(neighbor_index_to_ch_str)) + '\'b' + neighbor_index_to_ch_str


f.close()
f_v_neighbor_data.close()
f_c_neighbor_data.close()
f_neighbor_index_to_var_data.close()
f_neighbor_index_to_ch_data.close()
f_v_neighbor_coe.close()
f_c_neighbor_coe.close()
f_neighbor_index_to_var_coe.close()
f_neighbor_index_to_ch_coe.close()
