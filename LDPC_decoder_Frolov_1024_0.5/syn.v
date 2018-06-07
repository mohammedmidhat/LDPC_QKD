//////////////////////////////////////////////////////////////////////////////////
// Company:         MIT Quantum Photonics Group
// Author:        Mohammed Al Ai Baky
// 
// Create Date:     6/6/2018 
// Design Name:     LDPC_decoder_Frolov_1024_0.5
// Module Name:     syn
// Project Name:    LDPC_decoder_Frolov_1024_0.5
// Target Devices:  VC707 Virtex-7 FPGA
// Tool versions:   Vivado 2017.4
// Description:     Syndrome checker module
//
// Dependencies:    
//
// Revision: 
// Revision 0.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module syn(
	input bit_1,
	input bit_2,
	input bit_3,
	input bit_4,
	input bit_5,
	input bit_6,
	input bit_7,
	input bit_8,
	input bit_9,
	input bit_10,
	output result
	);

assign result = bit_1^bit_2^bit_3^bit_4^bit_5^bit_6^bit_7^bit_8^bit_9^bit_10;

endmodule
