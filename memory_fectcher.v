//////////////////////////////////////////////////////////////////////////////////
// Company: 		MIT Quantum Photonics Group
// Engineer: 		Mohammed Al Ai Baky
// 
// Create Date:    	10/22/2017 
// Design Name: 	LDPC_QKD
// Module Name:    	memory_fetcher
// Project Name: 	LDPC_QKD
// Target Devices: 	VC707 Virtex-7 FPGA
// Tool versions: 	Vivado 14.4
// Description: 	reads and writes to different BRAMs depending on control signals
//					from the control unit
//
// Dependencies: 	
//
// Revision: 
// Revision 0.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////

// BRAM Architecture

// Message RAM
// Belief vr1	|vr -> ch1
// ch -> vr1	|
// Belief vr2	|vr -> ch2
// ch -> vr2	|

// Mat RAM
// vr1 neighbor index 	|ch1 neighbor index
// vr2 neighbor index 	|ch2 neighbor index
// vr3 neighbor index 	|ch3 neighbor index


module memory_fetcher#(parameter ADDR_WIDTH = 3, parameter DATA_WIDTH = 6, parameter BUS_WIDTH = 18, parameter OFFSET_CH = 3, parameter mat_addr_wdth = 4,
					   parameter LOG2CIRC_SIZE = 2, parameter NUM_CIRCs = 12, parameter NEIGHBOR_INDEX_WIDTH = 2, parameter n = 18)(
	// Message RAM
	output [ADDR_WIDTH-1:0] mf_addr_0,
	output [ADDR_WIDTH-1:0] mf_addr_1,
	output [ADDR_WIDTH-1:0] mf_addr_2,
	output [ADDR_WIDTH-1:0] mf_addr_3,
	output [ADDR_WIDTH-1:0] mf_addr_4,
	output [ADDR_WIDTH-1:0] mf_addr_5,
	output [ADDR_WIDTH-1:0] mf_addr_6,
	output [ADDR_WIDTH-1:0] mf_addr_7,
	output [ADDR_WIDTH-1:0] mf_addr_8,
	output [ADDR_WIDTH-1:0] mf_addr_9,
	output [ADDR_WIDTH-1:0] mf_addr_10,
	output [ADDR_WIDTH-1:0] mf_addr_11,
	output [BUS_WIDTH-1:0] mf_data_out_0,
	output [BUS_WIDTH-1:0] mf_data_out_1,
	output [BUS_WIDTH-1:0] mf_data_out_2,
	output [BUS_WIDTH-1:0] mf_data_out_3,
	output [BUS_WIDTH-1:0] mf_data_out_4,
	output [BUS_WIDTH-1:0] mf_data_out_5,
	output [BUS_WIDTH-1:0] mf_data_out_6,
	output [BUS_WIDTH-1:0] mf_data_out_7,
	output [BUS_WIDTH-1:0] mf_data_out_8,
	output [BUS_WIDTH-1:0] mf_data_out_9,
	output [BUS_WIDTH-1:0] mf_data_out_10,
	output [BUS_WIDTH-1:0] mf_data_out_11,
	input [BUS_WIDTH-1:0] mf_data_in_0,
	input [BUS_WIDTH-1:0] mf_data_in_1,
	input [BUS_WIDTH-1:0] mf_data_in_2,
	input [BUS_WIDTH-1:0] mf_data_in_3,
	input [BUS_WIDTH-1:0] mf_data_in_4,
	input [BUS_WIDTH-1:0] mf_data_in_5,
	input [BUS_WIDTH-1:0] mf_data_in_6,
	input [BUS_WIDTH-1:0] mf_data_in_7,
	input [BUS_WIDTH-1:0] mf_data_in_8,
	input [BUS_WIDTH-1:0] mf_data_in_9,
	input [BUS_WIDTH-1:0] mf_data_in_10,
	input [BUS_WIDTH-1:0] mf_data_in_11,


	// Mat RAM
	output [mat_addr_wdth-1:0] mat_addr,

	input [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_0,
	input [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_1,
	input [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_2,
	input [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_3,
	input [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_4,
	input [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_5,
	input [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_6,
	input [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_7,
	input [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_8,
	input [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_9,
	input [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_10,
	input [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_11,


	// Control Signals
	input vr_process,	// when set, process the vr->ch messages in the Message RAM, and the check nodes (2nd) portion in the Mat RAM
	input [LOG2CIRC_SIZE-1:0] circ_node,	// The node in the circulant to be processed
	input neighbor, 	// When set, addr is for the neighboring node
	input syndrome	// When set, mat_addr_n is in the syndrome portion of the MAT RAM
	);

reg [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_0;
reg [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_0;
reg [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_0;
reg [NEIGHBOR_INDEX_WIDTH-1:0] neighbor_index_0;

if(neighbor) begin
	assign mf_addr_0 = (vr_process)? OFFSET_CH+neighbor_index_0 : neighbor_index_0;
	assign mf_addr_1 = (vr_process)? OFFSET_CH+neighbor_index_1 : neighbor_index_1;
	assign mf_addr_2 = (vr_process)? OFFSET_CH+neighbor_index_2 : neighbor_index_2;
	assign mf_addr_3 = (vr_process)? OFFSET_CH+neighbor_index_3 : neighbor_index_3;
	assign mf_addr_4 = (vr_process)? OFFSET_CH+neighbor_index_4 : neighbor_index_4;
	assign mf_addr_5 = (vr_process)? OFFSET_CH+neighbor_index_5 : neighbor_index_5;
	assign mf_addr_6 = (vr_process)? OFFSET_CH+neighbor_index_6 : neighbor_index_6;
	assign mf_addr_7 = (vr_process)? OFFSET_CH+neighbor_index_7 : neighbor_index_7;
	assign mf_addr_8 = (vr_process)? OFFSET_CH+neighbor_index_8 : neighbor_index_8;
	assign mf_addr_9 = (vr_process)? OFFSET_CH+neighbor_index_9 : neighbor_index_9;
	assign mf_addr_10 = (vr_process)? OFFSET_CH+neighbor_index_10 : neighbor_index_10;
	assign mf_addr_11 = (vr_process)? OFFSET_CH+neighbor_index_11 : neighbor_index_11;
end else begin
	assign mf_addr_0 = (vr_process)? OFFSET_CH+circ_node : circ_node;
	assign mf_addr_1 = (vr_process)? OFFSET_CH+circ_node : circ_node;
	assign mf_addr_2 = (vr_process)? OFFSET_CH+circ_node : circ_node;
	assign mf_addr_3 = (vr_process)? OFFSET_CH+circ_node : circ_node;
	assign mf_addr_4 = (vr_process)? OFFSET_CH+circ_node : circ_node;
	assign mf_addr_5 = (vr_process)? OFFSET_CH+circ_node : circ_node;
	assign mf_addr_6 = (vr_process)? OFFSET_CH+circ_node : circ_node;
	assign mf_addr_7 = (vr_process)? OFFSET_CH+circ_node : circ_node;
	assign mf_addr_8 = (vr_process)? OFFSET_CH+circ_node : circ_node;
	assign mf_addr_9 = (vr_process)? OFFSET_CH+circ_node : circ_node;
	assign mf_addr_10 = (vr_process)? OFFSET_CH+circ_node : circ_node;
	assign mf_addr_11 = (vr_process)? OFFSET_CH+circ_node : circ_node;
end

if(syndrome) begin
	assign mat_addr_0 = OFFSET_CH+circ_node;
	assign mat_addr_1 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_2 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_3 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_4 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_5 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_6 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_7 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_8 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_9 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_10 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_11 = (vr_process)? circ_node : OFFSET_CH+circ_node;
end else begin
	assign mat_addr_0 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_1 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_2 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_3 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_4 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_5 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_6 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_7 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_8 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_9 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_10 = (vr_process)? circ_node : OFFSET_CH+circ_node;
	assign mat_addr_11 = (vr_process)? circ_node : OFFSET_CH+circ_node;
end

endmodule
