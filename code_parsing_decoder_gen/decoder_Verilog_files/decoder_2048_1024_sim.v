`timescale 1ns / 1ps

module decoder_2048_1024_sim;

	parameter clk_half_period_pre_div = 2.5;
	parameter clk_div_factor = 200;
	parameter clk_half_period_post_div = clk_half_period_pre_div*clk_div_factor;
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
	#clk_half_period_pre_div clk_n <= ~clk_n;
	end

	always begin
	#clk_half_period_pre_div clk_p <= ~clk_p;
	end

	initial begin
		// Initialize Inputs
		clk_p = 0;
		clk_n = 1;
		rst = 0;
		tog = 0;		// For debugging the simulation

		#(clk_half_period_post_div/2)
		rst = 1;
		#(60*clk_half_period_post_div)
		rst = 0;
		#(clk_half_period_post_div+(circ+1)*2*clk_half_period_post_div)
			tog = ~tog;
		if(uut.FSM == 3)begin
			$display("already cw");
		end

		else begin
			#(2*clk_half_period_post_div)
			for (iter_s = 0; iter_s < max_iter; iter_s = iter_s +1) begin
				for (circ_iter_s = 0; circ_iter_s < circ; circ_iter_s = circ_iter_s +1) begin
					#(2*clk_half_period_post_div)
					tog = ~tog;
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_1_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_1_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_2_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_2_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_3_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_3_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_4_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_4_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_5_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_5_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_6_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_6_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_7_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_7_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_8_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_8_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_9_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_9_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_10_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_10_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_11_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_11_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_12_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_12_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_13_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_13_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_14_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_14_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_15_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_15_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_16_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_16_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_17_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_17_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_18_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_18_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_19_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_19_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_20_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_20_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_21_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_21_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_22_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_22_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_23_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_23_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_24_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_24_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_25_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_25_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_26_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_26_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_27_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_27_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_28_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_28_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_29_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_29_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_30_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_30_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_31_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_31_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_32_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_32_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_33_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_33_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_34_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_34_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_35_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_35_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_36_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_36_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_37_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_37_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_38_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_38_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_39_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_39_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_40_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_40_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_41_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_41_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_42_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_42_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_43_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_43_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_44_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_44_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_45_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_45_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_46_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_46_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_47_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_47_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_48_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_48_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_49_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_49_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_50_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_50_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_51_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_51_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_52_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_52_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_53_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_53_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_54_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_54_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_55_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_55_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_56_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_56_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_57_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_57_msg_data_in});
				end
				#(2*2*clk_half_period_post_div)
				for (circ_iter_s = 0; circ_iter_s < circ; circ_iter_s = circ_iter_s +1) begin
					#(2*clk_half_period_post_div)
					tog = ~tog;
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_1_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_1_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_2_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_2_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_3_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_3_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_4_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_4_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_5_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_5_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_6_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_6_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_7_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_7_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_8_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_8_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_9_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_9_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_10_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_10_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_11_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_11_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_12_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_12_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_13_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_13_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_14_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_14_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_15_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_15_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_16_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_16_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_17_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_17_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_18_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_18_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_19_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_19_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_20_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_20_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_21_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_21_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_22_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_22_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_23_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_23_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_24_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_24_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_25_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_25_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_26_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_26_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_27_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_27_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_28_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_28_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_29_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_29_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_30_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_30_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_31_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_31_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_32_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_32_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_33_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_33_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_34_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_34_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_35_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_35_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_36_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_36_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_37_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_37_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_38_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_38_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_39_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_39_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_40_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_40_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_41_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_41_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_42_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_42_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_43_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_43_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_44_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_44_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_45_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_45_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_46_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_46_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_47_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_47_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_48_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_48_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_49_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_49_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_50_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_50_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_51_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_51_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_52_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_52_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_53_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_53_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_54_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_54_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_55_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_55_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_56_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_56_msg_data_in});
					$display ("%8h", {{(INT+FRAC){uut.decoder_inst.circ_57_msg_data_in[INT+FRAC-1]}},uut.decoder_inst.circ_57_msg_data_in});
				end
				#(2*2*clk_half_period_post_div)
				tog = tog;
			end

		// so you can manually verify 'success' gets deasserted
		#(6*clk_half_period_post_div)
		rst = 1;
		#(6*clk_half_period_post_div)
		rst = 0;
		end
	end

endmodule
