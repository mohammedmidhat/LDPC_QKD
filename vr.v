module vr#(parameter INT = 8, parameter FRAC = 8, parameter DATA_WIDTH = 16)(
	input [DATA_WIDTH-1:0] LLR,
	input [DATA_WIDTH-1:0] ch_msg_0,
	input [DATA_WIDTH-1:0] ch_msg_1,
	input [DATA_WIDTH-1:0] ch_msg_2,
	output [DATA_WIDTH-1:0] vr_msg_0,
	output [DATA_WIDTH-1:0] vr_msg_1,
	output [DATA_WIDTH-1:0] vr_msg_2,
	output [DATA_WIDTH-1:0] belief
	);

assign belief = LLR + ch_msg_0 + ch_msg_0 + ch_msg_0;
assign vr_msg_0 = LLR + ch_msg_1 + ch_msg_2;
assign vr_msg_1 = LLR + ch_msg_0 + ch_msg_2;
assign vr_msg_2 = LLR + ch_msg_0 + ch_msg_1;

endmodule
