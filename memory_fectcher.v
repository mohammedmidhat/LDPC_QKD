module memory_fetcher#(parameter ADDR_WIDTH = 3, parameter DATA_WIDTH = 6, parameter BUS_WIDTH = 18, parameter OFFSET = 3, parameter LOG2CIRC_SIZE = 2, parameter NUM_CIRCs = 9)(
	// Message RAM
	output [ADDR_WIDTH-1:0] addr_0,
	output [ADDR_WIDTH-1:0] addr_1,
	output [ADDR_WIDTH-1:0] addr_2,
	output [ADDR_WIDTH-1:0] addr_3,
	output [ADDR_WIDTH-1:0] addr_4,
	output [ADDR_WIDTH-1:0] addr_5,
	output [ADDR_WIDTH-1:0] addr_6,
	output [ADDR_WIDTH-1:0] addr_7,
	output [ADDR_WIDTH-1:0] addr_8,
	output [BUS_WIDTH-1:0] data_out_0,
	output [BUS_WIDTH-1:0] data_out_1,
	output [BUS_WIDTH-1:0] data_out_2,
	output [BUS_WIDTH-1:0] data_out_3,
	output [BUS_WIDTH-1:0] data_out_4,
	output [BUS_WIDTH-1:0] data_out_5,
	output [BUS_WIDTH-1:0] data_out_6,
	output [BUS_WIDTH-1:0] data_out_7,
	output [BUS_WIDTH-1:0] data_out_8,
	input [BUS_WIDTH-1:0] data_in_0,
	input [BUS_WIDTH-1:0] data_in_1,
	input [BUS_WIDTH-1:0] data_in_2,
	input [BUS_WIDTH-1:0] data_in_3,
	input [BUS_WIDTH-1:0] data_in_4,
	input [BUS_WIDTH-1:0] data_in_5,
	input [BUS_WIDTH-1:0] data_in_6,
	input [BUS_WIDTH-1:0] data_in_7,
	input [BUS_WIDTH-1:0] data_in_8,

	// Control Signals
	input vr_process,	// when set, process the vr->ch messages
	input [LOG2CIRC_SIZE-1:0] circ_node,	// The node in the circulant to be processed
	input [NUM_CIRCs*LOG2CIRC_SIZE-1:0] ,
	);