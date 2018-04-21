`timescale 1ns / 1ps

module bram_infer_sim;

	// Inputs
	reg rst;
	reg [15:0] a;
	reg [15:0] b;
	
	// Outputs
	wire [15:0] c;
	
	bram_infer uut (
		.a(a),
		.b(b),
		.c(c)
	);

	initial begin
		// Initialize Inputs
		rst = 0;
		a = 0;
		b = 0;

		#1
		rst = 1;
		#120
		rst = 0;
		#2
		a = 3;
		b = -2;
		#2
		if(c != 1) $display("failed1");
		#2
        a = 3;
        b = 13;
        #2
        if(c != 16) $display("failed2");
        #2
        a = -30;
        b = -123;
        #2
        if(c != -153) $display("failed3");
        #2
        a = 32000;
        b = 1000;
        #2
        if(c != 32767) $display("failed4");
        #2
        a = -2000;
        b = -32500;
        #2
        if(c != -32768) $display("failed5");
        #2
        a = -32767;
        b = -1;
        #2
        if(c != -32768) $display("failed6");

	end
      
endmodule

