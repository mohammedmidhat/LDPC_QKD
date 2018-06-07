//////////////////////////////////////////////////////////////////////////////////
// Company:         MIT Quantum Photonics Group
// Author:        Mohammed Al Ai Baky
// 
// Create Date:     6/6/2018 
// Design Name:     LDPC_decoder_Frolov_1024_0.5
// Module Name:     vr
// Project Name:    LDPC_decoder_Frolov_1024_0.5
// Target Devices:  VC707 Virtex-7 FPGA
// Tool versions:   Vivado 2017.4
// Description:     Variable node module
//
// Dependencies:    sat_adder.v
//
// Revision: 
// Revision 0.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vr#(parameter INT = 8, parameter FRAC = 8)(
	input [INT+FRAC-1:0] LLR,
	input [INT+FRAC-1:0] ch_msg_1,
	input [INT+FRAC-1:0] ch_msg_2,
	input [INT+FRAC-1:0] ch_msg_3,
	input [INT+FRAC-1:0] ch_msg_4,
	input [INT+FRAC-1:0] ch_msg_5,
	input [INT+FRAC-1:0] ch_msg_6,
	input [INT+FRAC-1:0] ch_msg_7,
	output [INT+FRAC-1:0] vr_msg_1,
	output [INT+FRAC-1:0] vr_msg_2,
	output [INT+FRAC-1:0] vr_msg_3,
	output [INT+FRAC-1:0] vr_msg_4,
	output [INT+FRAC-1:0] vr_msg_5,
	output [INT+FRAC-1:0] vr_msg_6,
	output [INT+FRAC-1:0] vr_msg_7,
	output [INT+FRAC-1:0] belief
	);


wire [INT+FRAC-1:0] vr_msg_1_int;
wire [INT+FRAC-1:0] vr_msg_2_int;
wire [INT+FRAC-1:0] vr_msg_3_int;
wire [INT+FRAC-1:0] vr_msg_4_int;
wire [INT+FRAC-1:0] vr_msg_5_int;
wire [INT+FRAC-1:0] vr_msg_6_int;


	sat_adder sat_adder_1(
	.a(ch_msg_1),
	.b(ch_msg_2),
	.c(vr_msg_1_int)
	);

	sat_adder sat_adder_2(
	.a(ch_msg_3),
	.b(ch_msg_4),
	.c(vr_msg_2_int)
	);

	sat_adder sat_adder_3(
	.a(ch_msg_5),
	.b(ch_msg_6),
	.c(vr_msg_3_int)
	);

	sat_adder sat_adder_4(
	.a(ch_msg_7),
	.b(LLR),
	.c(vr_msg_4_int)
	);


	sat_adder sat_adder_5(
	.a(vr_msg_1_int),
	.b(vr_msg_2_int),
	.c(vr_msg_5_int)
	);

	sat_adder sat_adder_6(
	.a(vr_msg_3_int),
	.b(vr_msg_4_int),
	.c(vr_msg_6_int)
	);


	sat_adder sat_adder_7(
	.a(vr_msg_5_int),
	.b(vr_msg_6_int),
	.c(belief)
	);


	sat_adder sat_adder_8(
	.a(belief),
	.b(-ch_msg_1),
	.c(vr_msg_1)
	);

	sat_adder sat_adder_9(
	.a(belief),
	.b(-ch_msg_2),
	.c(vr_msg_2)
	);

	sat_adder sat_adder_10(
	.a(belief),
	.b(-ch_msg_3),
	.c(vr_msg_3)
	);

	sat_adder sat_adder_11(
	.a(belief),
	.b(-ch_msg_4),
	.c(vr_msg_4)
	);

	sat_adder sat_adder_12(
	.a(belief),
	.b(-ch_msg_5),
	.c(vr_msg_5)
	);

	sat_adder sat_adder_13(
	.a(belief),
	.b(-ch_msg_6),
	.c(vr_msg_6)
	);

	sat_adder sat_adder_14(
	.a(belief),
	.b(-ch_msg_7),
	.c(vr_msg_7)
	);

endmodule
