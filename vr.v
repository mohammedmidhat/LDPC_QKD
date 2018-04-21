module vr#(parameter INT = 8, parameter FRAC = 8)(
	input [INT+FRAC-1:0] LLR,
	input [INT+FRAC-1:0] ch_msg_0,
	input [INT+FRAC-1:0] ch_msg_1,
	input [INT+FRAC-1:0] ch_msg_2,
	output [INT+FRAC-1:0] vr_msg_0,
	output [INT+FRAC-1:0] vr_msg_1,
	output [INT+FRAC-1:0] vr_msg_2,
	output [INT+FRAC-1:0] belief
	);

// assign belief = LLR + ch_msg_0 + ch_msg_1 + ch_msg_2;
// assign vr_msg_0 = LLR + ch_msg_1 + ch_msg_2;
// assign vr_msg_1 = LLR + ch_msg_0 + ch_msg_2;
// assign vr_msg_2 = LLR + ch_msg_0 + ch_msg_1;

wire [INT+FRAC-1:0] vr_msg_0_int;
wire [INT+FRAC-1:0] vr_msg_1_int;
wire [INT+FRAC-1:0] vr_msg_2_int;
wire [INT+FRAC-1:0] belief_int;


sat_adder sat_adder_1(
	.a(ch_msg_1),
	.b(ch_msg_2),
	.c(vr_msg_0_int)
	);

sat_adder sat_adder_2(
	.a(ch_msg_0),
	.b(ch_msg_2),
	.c(vr_msg_1_int)
	);

sat_adder sat_adder_3(
	.a(ch_msg_0),
	.b(ch_msg_1),
	.c(vr_msg_2_int)
	);


sat_adder sat_adder_4(
	.a(vr_msg_0_int),
	.b(ch_msg_0),
	.c(belief_int)
	);


sat_adder sat_adder_5(
	.a(LLR),
	.b(belief_int),
	.c(belief)
	);

sat_adder sat_adder_6(
	.a(LLR),
	.b(vr_msg_0_int),
	.c(vr_msg_0)
	);

sat_adder sat_adder_7(
	.a(LLR),
	.b(vr_msg_1_int),
	.c(vr_msg_1)
	);

sat_adder sat_adder_8(
	.a(LLR),
	.b(vr_msg_2_int),
	.c(vr_msg_2)
	);

endmodule
