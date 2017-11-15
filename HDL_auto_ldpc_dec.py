import numpy as np
import math


## file must end with "\n"
f = open("204.33.484.txt")


skip_lines = 4
for i in range(skip_lines):
	f.readline()
	
n = 204
m = 102
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
        line = line.split('\t')
        ## to get rid of "\n"
        line[len(line)-1] = line[len(line)-1][:-1]
        d_var_neighbors[str(i+1)] = line
for i in range(m):
        line = f.readline()
        line = line.split('\t')
        ## to get rid of "\n"
        line[len(line)-1] = line[len(line)-1][:-1]
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

v_neighbor_str = str(len(v_neighbor_str)) + '\'b' + v_neighbor_str
c_neighbor_str = str(len(c_neighbor_str)) + '\'b' + c_neighbor_str
neighbor_index_to_var_str = str(len(neighbor_index_to_var_str)) + '\'b' + neighbor_index_to_var_str
neighbor_index_to_ch_str = str(len(neighbor_index_to_ch_str)) + '\'b' + neighbor_index_to_ch_str
