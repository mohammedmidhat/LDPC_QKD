

def memory_fetcher(circ_size, row_w, col_w, data_wdth, addr_wdth, n, m, fix_pnt_wdth):
    # first region in BRAM is for variable nodes messages
    # factor of 3 as each each variable stores one ch-->v message, belief,
    # and channel message
    bus_wdth = 3*fix_pnt_wdth
    # address at which the check messages start
    check_offset = cir_size
    num_addrs = 2*circ_size
    addr_wdth = 
