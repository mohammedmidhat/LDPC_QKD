`timescale 1ns / 1ps

module bram_infer_sim;

	// Inputs
	reg clk;
	reg [7:0] data_in;
	reg [3:0] addr;
	reg write;
	reg reset;

	// Outputs
	wire [7:0] data_out_1;
	wire [7:0] data_out_2;
	
	bram_infer uut (
		.clk(clk),
		.data_in(data_in),
		.data_out_1(data_out_1),
		.data_out_2(data_out_2),
		.addr(addr),
		.write(write),
		.reset(reset)
	);
	
	always begin
	#2 clk <= ~clk;
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		addr = 0;
		write = 0;
		data_in = 0;
		reset = 0;

		#1
		reset = 1;
		#100
		reset = 0;
		#18
		addr = 1;
		#18
		addr = 2;
		#18
		addr = 3;

	end
      
endmodule

