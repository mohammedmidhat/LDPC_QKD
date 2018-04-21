`timescale 1ns / 1ps

module bram_infer_sim;

	parameter half_period = 2;
	parameter circ = 31;
	parameter log2circ = 6;
	parameter log2max_iter = 5;
	parameter max_iter = 30;
	parameter INT = 8;
	parameter FRAC = 8;

	// Inputs
	reg clk;
	reg rst;
	reg [log2max_iter-1:0] iter_s;
	reg [log2circ-1:0] circ_iter_s;
	reg tog;

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
	#half_period clk <= ~clk;
	end

	initial begin
		// Initialize Inputs
		clk = 0;
		rst = 0;
		tog = 0;

		#1
		rst = 1;
		#120
		rst = 0;
		#(2+(circ+1)*2*half_period)			// 1+(circ-1)*half_period+2*half_period+1
		if(uut.FSM == 3)begin
			tog = ~tog;
			$display("already cw");
		end

		else begin
			#(2*half_period)
			for (iter_s = 0; iter_s < max_iter; iter_s = iter_s +1) begin
				for (circ_iter_s = 0; circ_iter_s < circ; circ_iter_s = circ_iter_s +1) begin
					#(2*half_period)
					tog = ~tog;
					$display ("%8h", {{(INT+FRAC){uut.circ_1_msg_data_in[INT+FRAC-1]}},uut.circ_1_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_2_msg_data_in[INT+FRAC-1]}},uut.circ_2_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_3_msg_data_in[INT+FRAC-1]}},uut.circ_3_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_4_msg_data_in[INT+FRAC-1]}},uut.circ_4_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_5_msg_data_in[INT+FRAC-1]}},uut.circ_5_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_6_msg_data_in[INT+FRAC-1]}},uut.circ_6_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_7_msg_data_in[INT+FRAC-1]}},uut.circ_7_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_8_msg_data_in[INT+FRAC-1]}},uut.circ_8_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_9_msg_data_in[INT+FRAC-1]}},uut.circ_9_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_10_msg_data_in[INT+FRAC-1]}},uut.circ_10_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_11_msg_data_in[INT+FRAC-1]}},uut.circ_11_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_12_msg_data_in[INT+FRAC-1]}},uut.circ_12_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_13_msg_data_in[INT+FRAC-1]}},uut.circ_13_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_14_msg_data_in[INT+FRAC-1]}},uut.circ_14_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_15_msg_data_in[INT+FRAC-1]}},uut.circ_15_msg_data_in});
				end
				#(2*2*half_period)
				for (circ_iter_s = 0; circ_iter_s < circ; circ_iter_s = circ_iter_s +1) begin
					#(2*half_period)
					tog = ~tog;
					$display ("%8h", {{(INT+FRAC){uut.circ_1_msg_data_in[INT+FRAC-1]}},uut.circ_1_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_2_msg_data_in[INT+FRAC-1]}},uut.circ_2_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_3_msg_data_in[INT+FRAC-1]}},uut.circ_3_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_4_msg_data_in[INT+FRAC-1]}},uut.circ_4_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_5_msg_data_in[INT+FRAC-1]}},uut.circ_5_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_6_msg_data_in[INT+FRAC-1]}},uut.circ_6_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_7_msg_data_in[INT+FRAC-1]}},uut.circ_7_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_8_msg_data_in[INT+FRAC-1]}},uut.circ_8_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_9_msg_data_in[INT+FRAC-1]}},uut.circ_9_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_10_msg_data_in[INT+FRAC-1]}},uut.circ_10_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_11_msg_data_in[INT+FRAC-1]}},uut.circ_11_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_12_msg_data_in[INT+FRAC-1]}},uut.circ_12_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_13_msg_data_in[INT+FRAC-1]}},uut.circ_13_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_14_msg_data_in[INT+FRAC-1]}},uut.circ_14_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_15_msg_data_in[INT+FRAC-1]}},uut.circ_15_msg_data_in});
				end
				#(2*2*half_period)
				tog = tog;
			end
		end
	end
      
endmodule

