module vr#(parameter DATA_WIDTH = 6)(
	input [DATA_WIDTH-1:0] ch_msg_0,
	input [DATA_WIDTH-1:0] ch_msg_1,
	input [DATA_WIDTH-1:0] ch_msg_2,
	output [DATA_WIDTH-1:0] vr_msg_0,
	output [DATA_WIDTH-1:0] vr_msg_1,
	output [DATA_WIDTH-1:0] vr_msg_2,
	output [DATA_WIDTH-1:0] belief
	);

assign belief = vr_msg_0 + vr_msg_0 + vr_msg_0;

endmodule
