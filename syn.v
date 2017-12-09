module syn(
	input bit_0,
	input bit_1,
	input bit_2,
	input bit_3,
	input bit_4,
	input bit_5,
	output result
	);

assign result = bit_5^bit_4^bit_3^bit_2^bit_1^bit_0;

endmodule
