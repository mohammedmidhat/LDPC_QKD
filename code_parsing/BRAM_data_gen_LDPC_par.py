## 1- Parse LDPC code file in alist format and write the code coe files
## 2- Writes the message files initialized to zero
## Note: The code file must end with an empty new line
##
## By:  Mohammed Al Ai Baky, 4/17/2018

n = 2048
m = 1024
circ_size = 128
log2circ = 9
data_width = 16

code_f = open("Frolov_1024_0.5.txt")


## Parse LDPC code file in alist format

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

## Write the code coe files
cur_column_w_circ_group = [0 for i in range(n/circ_size)]
    
for j in range(m/circ_size):
    var_circ_group = [int(i)/circ_size for i in chk_neighbors[j*circ_size] if(i != '0')]
    for ind,val in enumerate(var_circ_group):
        code_f = open("code_"+str(j*n/circ_size+ind)+".coe","w")
        code_f.write("memory_initialization_radix=2;\n")
        code_f.write("memory_initialization_vector=\n")
        
        for k in range(j*circ_size,(j+1)*circ_size):
            chk_node_neighbor = (int(chk_neighbors[k][ind])-1)%circ_size
            code_f.write(format(chk_node_neighbor, "#0"+str(log2circ+2)+"b")[2:]+",\n")

        for k in range(val*circ_size,(val+1)*circ_size-1):
            var_node_neighbor = (int(var_neighbors[k][cur_column_w_circ_group[val]])-1)%circ_size
            code_f.write(format(var_node_neighbor, "#0"+str(log2circ+2)+"b")[2:]+",\n")
        var_node_neighbor = (int(var_neighbors[(val+1)*circ_size-1][cur_column_w_circ_group[val]])-1)%circ_size
        code_f.write(format(var_node_neighbor, "#0"+str(log2circ+2)+"b")[2:]+";")

        cur_column_w_circ_group[val] += 1

        code_f.close()
        


## Writes the message files initialized to zero
for i in range((n/circ_size)*(m/circ_size)):
    msg_f = open("msg_"+str(i)+".coe","w")
    
    msg_f.write("memory_initialization_radix=2;\n")
    msg_f.write("memory_initialization_vector=\n")

    for j in range(2*circ_size-1):
        msg_f.write(format(0, "#0"+str(data_width+2)+"b")[2:]+",\n")
    msg_f.write(format(0, "#0"+str(data_width+2)+"b")[2:]+";")
    
    msg_f.close()
