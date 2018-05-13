`timescale 1ns / 1ps

module decoder_2048_1024_sim;

	parameter half_period = 2;
	parameter circ = 128;
	parameter log2circ = 8;
	parameter log2max_iter = 5;
	parameter max_iter = 30;
	parameter INT = 8;
	parameter FRAC = 8;

	// Inputs
	reg clk_p;
	reg clk_n;
	reg rst;
	reg [log2max_iter-1:0] iter_s;
	reg [log2circ-1:0] circ_iter_s;
	reg tog;

	// Outputs
	wire success;
	wire [4:0] iterations;

	decoder uut (
		.clk_p(clk_p),
		.clk_n(clk_n),
		.rst(rst),
		.success(success),
		.iterations(iterations)
	);

	always begin
	#half_period clk_n <= ~clk_n;
	end

	always begin
	#half_period clk_p <= ~clk_p;
	end

	initial begin
		// Initialize Inputs
		clk_n = 1;
		clk_p = 0;
		rst = 0;
		tog = 0;		// For debugging the simulation

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
					$display ("%8h", {{(INT+FRAC){uut.circ_16_msg_data_in[INT+FRAC-1]}},uut.circ_16_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_17_msg_data_in[INT+FRAC-1]}},uut.circ_17_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_18_msg_data_in[INT+FRAC-1]}},uut.circ_18_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_19_msg_data_in[INT+FRAC-1]}},uut.circ_19_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_20_msg_data_in[INT+FRAC-1]}},uut.circ_20_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_21_msg_data_in[INT+FRAC-1]}},uut.circ_21_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_22_msg_data_in[INT+FRAC-1]}},uut.circ_22_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_23_msg_data_in[INT+FRAC-1]}},uut.circ_23_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_24_msg_data_in[INT+FRAC-1]}},uut.circ_24_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_25_msg_data_in[INT+FRAC-1]}},uut.circ_25_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_26_msg_data_in[INT+FRAC-1]}},uut.circ_26_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_27_msg_data_in[INT+FRAC-1]}},uut.circ_27_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_28_msg_data_in[INT+FRAC-1]}},uut.circ_28_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_29_msg_data_in[INT+FRAC-1]}},uut.circ_29_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_30_msg_data_in[INT+FRAC-1]}},uut.circ_30_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_31_msg_data_in[INT+FRAC-1]}},uut.circ_31_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_32_msg_data_in[INT+FRAC-1]}},uut.circ_32_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_33_msg_data_in[INT+FRAC-1]}},uut.circ_33_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_34_msg_data_in[INT+FRAC-1]}},uut.circ_34_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_35_msg_data_in[INT+FRAC-1]}},uut.circ_35_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_36_msg_data_in[INT+FRAC-1]}},uut.circ_36_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_37_msg_data_in[INT+FRAC-1]}},uut.circ_37_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_38_msg_data_in[INT+FRAC-1]}},uut.circ_38_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_39_msg_data_in[INT+FRAC-1]}},uut.circ_39_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_40_msg_data_in[INT+FRAC-1]}},uut.circ_40_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_41_msg_data_in[INT+FRAC-1]}},uut.circ_41_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_42_msg_data_in[INT+FRAC-1]}},uut.circ_42_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_43_msg_data_in[INT+FRAC-1]}},uut.circ_43_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_44_msg_data_in[INT+FRAC-1]}},uut.circ_44_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_45_msg_data_in[INT+FRAC-1]}},uut.circ_45_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_46_msg_data_in[INT+FRAC-1]}},uut.circ_46_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_47_msg_data_in[INT+FRAC-1]}},uut.circ_47_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_48_msg_data_in[INT+FRAC-1]}},uut.circ_48_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_49_msg_data_in[INT+FRAC-1]}},uut.circ_49_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_50_msg_data_in[INT+FRAC-1]}},uut.circ_50_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_51_msg_data_in[INT+FRAC-1]}},uut.circ_51_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_52_msg_data_in[INT+FRAC-1]}},uut.circ_52_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_53_msg_data_in[INT+FRAC-1]}},uut.circ_53_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_54_msg_data_in[INT+FRAC-1]}},uut.circ_54_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_55_msg_data_in[INT+FRAC-1]}},uut.circ_55_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_56_msg_data_in[INT+FRAC-1]}},uut.circ_56_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_57_msg_data_in[INT+FRAC-1]}},uut.circ_57_msg_data_in});
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
					$display ("%8h", {{(INT+FRAC){uut.circ_16_msg_data_in[INT+FRAC-1]}},uut.circ_16_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_17_msg_data_in[INT+FRAC-1]}},uut.circ_17_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_18_msg_data_in[INT+FRAC-1]}},uut.circ_18_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_19_msg_data_in[INT+FRAC-1]}},uut.circ_19_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_20_msg_data_in[INT+FRAC-1]}},uut.circ_20_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_21_msg_data_in[INT+FRAC-1]}},uut.circ_21_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_22_msg_data_in[INT+FRAC-1]}},uut.circ_22_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_23_msg_data_in[INT+FRAC-1]}},uut.circ_23_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_24_msg_data_in[INT+FRAC-1]}},uut.circ_24_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_25_msg_data_in[INT+FRAC-1]}},uut.circ_25_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_26_msg_data_in[INT+FRAC-1]}},uut.circ_26_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_27_msg_data_in[INT+FRAC-1]}},uut.circ_27_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_28_msg_data_in[INT+FRAC-1]}},uut.circ_28_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_29_msg_data_in[INT+FRAC-1]}},uut.circ_29_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_30_msg_data_in[INT+FRAC-1]}},uut.circ_30_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_31_msg_data_in[INT+FRAC-1]}},uut.circ_31_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_32_msg_data_in[INT+FRAC-1]}},uut.circ_32_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_33_msg_data_in[INT+FRAC-1]}},uut.circ_33_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_34_msg_data_in[INT+FRAC-1]}},uut.circ_34_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_35_msg_data_in[INT+FRAC-1]}},uut.circ_35_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_36_msg_data_in[INT+FRAC-1]}},uut.circ_36_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_37_msg_data_in[INT+FRAC-1]}},uut.circ_37_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_38_msg_data_in[INT+FRAC-1]}},uut.circ_38_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_39_msg_data_in[INT+FRAC-1]}},uut.circ_39_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_40_msg_data_in[INT+FRAC-1]}},uut.circ_40_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_41_msg_data_in[INT+FRAC-1]}},uut.circ_41_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_42_msg_data_in[INT+FRAC-1]}},uut.circ_42_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_43_msg_data_in[INT+FRAC-1]}},uut.circ_43_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_44_msg_data_in[INT+FRAC-1]}},uut.circ_44_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_45_msg_data_in[INT+FRAC-1]}},uut.circ_45_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_46_msg_data_in[INT+FRAC-1]}},uut.circ_46_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_47_msg_data_in[INT+FRAC-1]}},uut.circ_47_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_48_msg_data_in[INT+FRAC-1]}},uut.circ_48_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_49_msg_data_in[INT+FRAC-1]}},uut.circ_49_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_50_msg_data_in[INT+FRAC-1]}},uut.circ_50_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_51_msg_data_in[INT+FRAC-1]}},uut.circ_51_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_52_msg_data_in[INT+FRAC-1]}},uut.circ_52_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_53_msg_data_in[INT+FRAC-1]}},uut.circ_53_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_54_msg_data_in[INT+FRAC-1]}},uut.circ_54_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_55_msg_data_in[INT+FRAC-1]}},uut.circ_55_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_56_msg_data_in[INT+FRAC-1]}},uut.circ_56_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.circ_57_msg_data_in[INT+FRAC-1]}},uut.circ_57_msg_data_in});
				end
				#(2*2*half_period)
				tog = tog;
			end
		end
	end

endmodule
