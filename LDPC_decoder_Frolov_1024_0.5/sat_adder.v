//////////////////////////////////////////////////////////////////////////////////
// Company:         MIT Quantum Photonics Group
// Author:        Mohammed Al Ai Baky
// 
// Create Date:     6/6/2018 
// Design Name:     LDPC_decoder_Frolov_1024_0.5
// Module Name:     sat_adder
// Project Name:    LDPC_decoder_Frolov_1024_0.5
// Target Devices:  VC707 Virtex-7 FPGA
// Tool versions:   Vivado 2017.4
// Description:     Saturation adder module
//
// Dependencies:    
//
// Revision: 
// Revision 0.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module sat_adder#(parameter INT = 8, parameter FRAC = 8)(
		input [INT+FRAC-1:0] a,
		input [INT+FRAC-1:0] b,
		output [INT+FRAC-1:0] c
	);

wire [INT+FRAC-1:0] sum;
assign sum = a+b;

wire [INT+FRAC-1:0] pos_sum;
assign pos_sum = (sum[INT+FRAC-1])? 16'b111111111111111:sum;

wire [INT+FRAC-1:0] neg_sum;
assign neg_sum = (sum[INT+FRAC-1])? sum:16'b1000000000000000;

wire [INT+FRAC-1:0] result;
assign result = (a[INT+FRAC-1])? neg_sum:pos_sum;

assign c = (a[INT+FRAC-1]^b[INT+FRAC-1]) ? sum:result;

endmodule
