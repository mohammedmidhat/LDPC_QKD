module vr#(parameter INT = 8, parameter FRAC = 8)(
	input [INT+FRAC-1:0] ch_msg_0,
	input [INT+FRAC-1:0] ch_msg_1,
	input [INT+FRAC-1:0] ch_msg_2,
	output [INT+FRAC-1:0] vr_msg_0,
	output [INT+FRAC-1:0] vr_msg_1,
	output [INT+FRAC-1:0] vr_msg_2,
	output [INT+FRAC-1:0] belief
	);

assign belief = vr_msg_0 + vr_msg_0 + vr_msg_0;
assign vr_msg_0 = vr_msg_1 + vr_msg_2;
assign vr_msg_1 = vr_msg_0 + vr_msg_2;
assign vr_msg_2 = vr_msg_0 + vr_msg_1;

endmodule
