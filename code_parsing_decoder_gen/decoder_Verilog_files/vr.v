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

