module syn(
	input bit_1,
	input bit_2,
	input bit_3,
	input bit_4,
	input bit_5,
	input bit_6,
	input bit_7,
	input bit_8,
	input bit_9,
	input bit_10,
	output result
	);

assign result = bit_1^bit_2^bit_3^bit_4^bit_5^bit_6^bit_7^bit_8^bit_9^bit_10;

endmodule
