module vr#(parameter INT = 8, parameter FRAC = 8)(
	input [INT+FRAC-1:0] LLR,
	input [INT+FRAC-1:0] ch_msg_1,
	input [INT+FRAC-1:0] ch_msg_2,
	input [INT+FRAC-1:0] ch_msg_3,
	output [INT+FRAC-1:0] vr_msg_1,
	output [INT+FRAC-1:0] vr_msg_2,
	output [INT+FRAC-1:0] vr_msg_3,
	output [INT+FRAC-1:0] belief
	);

wire [INT+FRAC-1:0] vr_msg_0_int;
wire [INT+FRAC-1:0] vr_msg_1_int;


sat_adder sat_adder_1(
	.a(ch_msg_1),
	.b(ch_msg_2),
	.c(vr_msg_0_int)
	);

sat_adder sat_adder_2(
	.a(ch_msg_3),
	.b(LLR),
	.c(vr_msg_1_int)
	);

sat_adder sat_adder_3(
	.a(vr_msg_0_int),
	.b(vr_msg_1_int),
	.c(belief)
	);


sat_adder sat_adder_4(
	.a(belief),
	.b(-ch_msg_1),
	.c(vr_msg_1)
	);

sat_adder sat_adder_5(
	.a(belief),
	.b(-ch_msg_2),
	.c(vr_msg_2)
	);

sat_adder sat_adder_6(
	.a(belief),
	.b(-ch_msg_3),
	.c(vr_msg_3)
	);

endmodule
