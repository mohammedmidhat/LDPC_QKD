	input clk,
	input rst,
	input [n-1:0] data,
	output success,
	output [log2max_iter-1:0] iterations
	);

reg [log2circ-1:0] circ_iter;
reg [log2circ-1:0] circ_iter_;
reg chk_r = 0;
reg chk_w = 0;

wire [INT+FRAC-1:0] LLR = 16'b0000000000001011;
reg [n-1:0] dec_cw;
reg [2:0] FSM;
reg non_zero_syn;

reg [2:0] nop = 0;

reg success_dec;
assign success = success_dec;

reg [log2max_iter-1:0] iter_num;
assign iterations = iter_num;


