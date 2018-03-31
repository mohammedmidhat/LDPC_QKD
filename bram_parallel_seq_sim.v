`timescale 1ns / 1ps

module bram_infer_sim;

	// Inputs
	reg clk;
	reg rst;

	// Outputs
	wire success;
	wire [4:0] iterations;
	
	decoder uut (
		.clk(clk),
		.rst(rst),
		.success(success),
		.iterations(iterations)
	);
	
	always begin
	#2 clk <= ~clk;
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;

		#1
		rst = 1;
		#120
		rst = 0;

	end
      
endmodule

