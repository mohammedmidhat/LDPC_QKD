module syndrome_checker#(parameter n = 12, parameter CIRC_SIZE = 3, parameter N_CIRC = 4)(
	input syndrome_0,
	input syndrome_1,
	input syndrome_2,
	input syndrome_3,

	output check
);

assign check = syndrome_0^syndrome_1^syndrome_2^syndrome_3;

endmodule
