module cn #(parameter INT = 8, parameter FRAC = 8)(
input [INT+FRAC-1:0] msg_in_1,
input [INT+FRAC-1:0] msg_in_2,
input [INT+FRAC-1:0] msg_in_3,
input [INT+FRAC-1:0] msg_in_4,
input [INT+FRAC-1:0] msg_in_5,
input [INT+FRAC-1:0] msg_in_6,
output [INT+FRAC-1:0] msg_out_1,
output [INT+FRAC-1:0] msg_out_2,
output [INT+FRAC-1:0] msg_out_3,
output [INT+FRAC-1:0] msg_out_4,
output [INT+FRAC-1:0] msg_out_5,
output [INT+FRAC-1:0] msg_out_6
);

min min_to_v1_inst ( 
	.msg_1 (msg_in_2),
	.msg_2 (msg_in_3),
	.msg_3 (msg_in_4),
	.msg_4 (msg_in_5),
	.msg_5 (msg_in_6),
	.msg (msg_out_1)
	);

min min_to_v2_inst ( 
	.msg_1 (msg_in_1),
	.msg_2 (msg_in_3),
	.msg_3 (msg_in_4),
	.msg_4 (msg_in_5),
	.msg_5 (msg_in_6),
	.msg (msg_out_2)
	);

min min_to_v3_inst ( 
	.msg_1 (msg_in_1),
	.msg_2 (msg_in_2),
	.msg_3 (msg_in_4),
	.msg_4 (msg_in_5),
	.msg_5 (msg_in_6),
	.msg (msg_out_3)
	);

min min_to_v4_inst ( 
	.msg_1 (msg_in_1),
	.msg_2 (msg_in_2),
	.msg_3 (msg_in_3),
	.msg_4 (msg_in_5),
	.msg_5 (msg_in_6),
	.msg (msg_out_4)
	);

min min_to_v5_inst ( 
	.msg_1 (msg_in_1),
	.msg_2 (msg_in_2),
	.msg_3 (msg_in_3),
	.msg_4 (msg_in_4),
	.msg_5 (msg_in_6),
	.msg (msg_out_5)
	);

min min_to_v6_inst ( 
	.msg_1 (msg_in_1),
	.msg_2 (msg_in_2),
	.msg_3 (msg_in_3),
	.msg_4 (msg_in_4),
	.msg_5 (msg_in_5),
	.msg (msg_out_6)
	);

endmodule
