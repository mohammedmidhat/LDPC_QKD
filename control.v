module control#(parameter max_iter = 30, parameter LOG2max_iter = 5, parameter CIRC_SIZE = 3, parameter LOG2CIRC_SIZE = 2, parameter n = 18)(
	// Message RAM
	input [ADDR_WIDTH-1:0] mf_addr_0,
	input [ADDR_WIDTH-1:0] mf_addr_1,
	input [ADDR_WIDTH-1:0] mf_addr_2,
	input [ADDR_WIDTH-1:0] mf_addr_3,
	input [ADDR_WIDTH-1:0] mf_addr_4,
	input [ADDR_WIDTH-1:0] mf_addr_5,
	input [ADDR_WIDTH-1:0] mf_addr_6,
	input [ADDR_WIDTH-1:0] mf_addr_7,
	input [ADDR_WIDTH-1:0] mf_addr_8,
	output [BUS_WIDTH-1:0] mf_data_out_0,
	output [BUS_WIDTH-1:0] mf_data_out_1,
	output [BUS_WIDTH-1:0] mf_data_out_2,
	output [BUS_WIDTH-1:0] mf_data_out_3,
	output [BUS_WIDTH-1:0] mf_data_out_4,
	output [BUS_WIDTH-1:0] mf_data_out_5,
	output [BUS_WIDTH-1:0] mf_data_out_6,
	output [BUS_WIDTH-1:0] mf_data_out_7,
	output [BUS_WIDTH-1:0] mf_data_out_8,
	input [BUS_WIDTH-1:0] mf_data_in_0,
	input [BUS_WIDTH-1:0] mf_data_in_1,
	input [BUS_WIDTH-1:0] mf_data_in_2,
	input [BUS_WIDTH-1:0] mf_data_in_3,
	input [BUS_WIDTH-1:0] mf_data_in_4,
	input [BUS_WIDTH-1:0] mf_data_in_5,
	input [BUS_WIDTH-1:0] mf_data_in_6,
	input [BUS_WIDTH-1:0] mf_data_in_7,
	input [BUS_WIDTH-1:0] mf_data_in_8,

	input clk,
	input rst,
	input [n-1:0] data_parallel,
	output [3:0] state,

	// Control Signals to memory_fetcher
	output vr_process,
	output [LOG2CIRC_SIZE-1:0] circ_node,
	output neighbor,
	output syndrome
	);

reg [LOG2max_iter-1:0] iter_num;

reg [LOG2CIRC_SIZE-1:0] circ_iter;

reg [3:0] FSM = 0;
assign state = FSM;

// Control Signals to memory_fetcher
reg process_vr;
reg get_neighbor;
reg get_syndrome;

assign circ_node = circ_iter;
assign vr_process = process_vr;
assign neighbor = get_neighbor;
assign syndrome = get_syndrome;


always @(posedge clk) begin
	if(rst) begin
		iter_num <= 0;
		FSM <= 0;
		circ_iter <= 0;


	end else if(FSM == 0) begin
		

end