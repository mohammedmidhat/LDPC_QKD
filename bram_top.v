module decoder#(parameter n = 12, parameter m = 6, parameter log2n = 4, parameter log2m = 3, parameter max_iter = 30, parameter log2max_iter = 5,
				parameter INT = 8, parameter FRAC = 8, parameter deg_v = 3, parameter deg_c = 6, parameter log2deg_v = 2, parameter log2deg_c = 3)(
	input clk,
	input rst,
	output success,
	output [log2max_iter-1:0] iterations
	);

// Zero-indexed
(* ram_style = "block" *) reg [deg_v*log2m-1:0] v_neighbor[0:n-1];
(* ram_style = "block" *) reg [deg_c*log2n-1:0] c_neighbor[0:m-1];
// One-indexed
(* ram_style = "block" *) reg [deg_c*log2deg_v-1:0] neighbor_index_to_var[0:m-1];	// specifies the neighboring index of a check to a var
																					// e.g. ch2 is the 1st neighbor check in its 3rd var neighbor
(* ram_style = "block" *) reg [deg_v*log2deg_c-1:0] neighbor_index_to_ch[0:n-1];	// specifies the neighboring index of a var to a check
																					// e.g. var2 is the 1st neighbor check in its 3rd check neighbor

assign v_neighbor = 108'b010011110001100101010011101001100110001011101010100110010100101001011110001100110010011101010011110001100101;
assign c_neighbor = 144'b001001000101011110011100000100110110100010101011000101000110011110011011001000110101100010101100001000110110011110101100000101000101100010011011;
assign neighbor_index_to_var = 72'b101010101010101010101010010101010101010101010101000000000000000000000000;
assign neighbor_index_to_ch = 108'b101101101101101101100100100100100100011011011011011011010010010010010010001001001001001001000000000000000000;

(* ram_style = "block" *) reg [deg_v*(INT+FRAC)-1:0] v_msg[0:n-1];
(* ram_style = "block" *) reg [deg_c*(INT+FRAC)-1:0] c_msg[0:m-1];

wire [INT+FRAC-1:0] LLR = 16'b1010101011001011;

wire [n-1:0] data = 12'b100101010101;
reg dec_cw[n-1:0];
reg [2:0] FSM;
reg non_zero_syn;

reg success_dec;
assign success = success_dec;

reg [log2max_iter-1:0] iter_num;
assign iterations = iter_num;

reg nop;

wire [INT+FRAC-1:0] LLR_in;
assign LLR_in = data[data_iter]*LLR;


reg bit_0_in;
reg bit_1_in;
reg bit_2_in;
reg bit_3_in;
reg bit_4_in;
reg bit_5_in;
wire syn_res;

syn	syn_0_inst (
	.bit_0(bit_0_in),
	.bit_1(bit_1_in),
	.bit_2(bit_2_in),
	.bit_3(bit_3_in),
	.bit_4(bit_4_in),
	.bit_5(bit_5_in),
	.result(syn_res)
	);


reg [deg_c*log2n-1:0] single_chk_neighbors_indices;
wire [log2n-1:0] chk_neighbor_0;
wire [log2n-1:0] chk_neighbor_1;
wire [log2n-1:0] chk_neighbor_2;
wire [log2n-1:0] chk_neighbor_3;
wire [log2n-1:0] chk_neighbor_4;
wire [log2n-1:0] chk_neighbor_5;
assign chk_neighbor_5 = single_chk_neighbors_indices[deg_c*log2n-1 -: log2n];
assign chk_neighbor_4 = single_chk_neighbors_indices[(deg_c-1)*log2n-1 -: log2n];
assign chk_neighbor_3 = single_chk_neighbors_indices[(deg_c-2)*log2n-1 -: log2n];
assign chk_neighbor_2 = single_chk_neighbors_indices[(deg_c-3)*log2n-1 -: log2n];
assign chk_neighbor_1 = single_chk_neighbors_indices[(deg_c-4)*log2n-1 -: log2n];
assign chk_neighbor_0 = single_chk_neighbors_indices[(deg_c-5)*log2n-1 -: log2n];

reg [deg_c*log2deg_v-1:0] single_chk_order_indices;
wire [log2deg_v-1:0] chk_order_0;
wire [log2deg_v-1:0] chk_order_1;
wire [log2deg_v-1:0] chk_order_2;
wire [log2deg_v-1:0] chk_order_3;
wire [log2deg_v-1:0] chk_order_4;
wire [log2deg_v-1:0] chk_order_5;
assign chk_order_5 = single_chk_order_indices[deg_c*log2deg_v-1 -: log2deg_v];
assign chk_order_4 = single_chk_order_indices[(deg_c-1)*log2deg_v-1 -: log2deg_v];
assign chk_order_3 = single_chk_order_indices[(deg_c-2)*log2deg_v-1 -: log2deg_v];
assign chk_order_2 = single_chk_order_indices[(deg_c-3)*log2deg_v-1 -: log2deg_v];
assign chk_order_1 = single_chk_order_indices[(deg_c-4)*log2deg_v-1 -: log2deg_v];
assign chk_order_0 = single_chk_order_indices[(deg_c-5)*log2deg_v-1 -: log2deg_v];

reg [deg_v*(INT+FRAC)-1:0] vn_msgs_to_chk_neighbors_0;
reg [deg_v*(INT+FRAC)-1:0] vn_msgs_to_chk_neighbors_1;
reg [deg_v*(INT+FRAC)-1:0] vn_msgs_to_chk_neighbors_2;
reg [deg_v*(INT+FRAC)-1:0] vn_msgs_to_chk_neighbors_3;
reg [deg_v*(INT+FRAC)-1:0] vn_msgs_to_chk_neighbors_4;
reg [deg_v*(INT+FRAC)-1:0] vn_msgs_to_chk_neighbors_5;

wire [INT+FRAC-1:0] vn_cn_msgs_0_5;
wire [INT+FRAC-1:0] vn_cn_msgs_0_4;
wire [INT+FRAC-1:0] vn_cn_msgs_0_3;
wire [INT+FRAC-1:0] vn_cn_msgs_0_2;
wire [INT+FRAC-1:0] vn_cn_msgs_0_1;
wire [INT+FRAC-1:0] vn_cn_msgs_0_0;
assign vn_cn_msgs_0_5 = vn_msgs_to_chk_neighbors_5[chk_order_5*(INT+FRAC)-1 -: (INT+FRAC)];
assign vn_cn_msgs_0_4 = vn_msgs_to_chk_neighbors_4[chk_order_4*(INT+FRAC)-1 -: (INT+FRAC)];
assign vn_cn_msgs_0_3 = vn_msgs_to_chk_neighbors_3[chk_order_3*(INT+FRAC)-1 -: (INT+FRAC)];
assign vn_cn_msgs_0_2 = vn_msgs_to_chk_neighbors_2[chk_order_2*(INT+FRAC)-1 -: (INT+FRAC)];
assign vn_cn_msgs_0_1 = vn_msgs_to_chk_neighbors_1[chk_order_1*(INT+FRAC)-1 -: (INT+FRAC)];
assign vn_cn_msgs_0_0 = vn_msgs_to_chk_neighbors_0[chk_order_0*(INT+FRAC)-1 -: (INT+FRAC)];

wire [INT+FRAC-1:0] cn_vn_msgs_0_0;
wire [INT+FRAC-1:0] cn_vn_msgs_0_1;
wire [INT+FRAC-1:0] cn_vn_msgs_0_2;
wire [INT+FRAC-1:0] cn_vn_msgs_0_3;
wire [INT+FRAC-1:0] cn_vn_msgs_0_4;
wire [INT+FRAC-1:0] cn_vn_msgs_0_5;

cn cn_0_inst (
	.msg_in_1(vn_cn_msgs_0_0),
	.msg_in_2(vn_cn_msgs_0_1),
	.msg_in_3(vn_cn_msgs_0_2),
	.msg_in_4(vn_cn_msgs_0_3),
	.msg_in_5(vn_cn_msgs_0_4),
	.msg_in_6(vn_cn_msgs_0_5),
	.msg_out_1(cn_vn_msgs_0_0),
	.msg_out_2(cn_vn_msgs_0_1),
	.msg_out_3(cn_vn_msgs_0_2),
	.msg_out_4(cn_vn_msgs_0_3),
	.msg_out_5(cn_vn_msgs_0_4),
	.msg_out_6(cn_vn_msgs_0_5)
	);


reg [deg_v*log2m-1:0] single_vn_neighbors_indices;
wire [log2m-1:0] vn_neighbor_0;
wire [log2m-1:0] vn_neighbor_1;
wire [log2m-1:0] vn_neighbor_2;
assign vn_neighbor_2 = single_vn_neighbors_indices[deg_v*log2m-1 -: log2m];
assign vn_neighbor_1 = single_vn_neighbors_indices[(deg_v-1)*log2m-1 -: log2m];
assign vn_neighbor_0 = single_vn_neighbors_indices[(deg_v-2)*log2m-1 -: log2m];

reg [deg_v*log2deg_c-1:0] single_vn_order_indices;
wire [log2deg_c-1:0] vn_order_0;
wire [log2deg_c-1:0] vn_order_1;
wire [log2deg_c-1:0] vn_order_2;
assign vn_order_2 = single_vn_order_indices[deg_v*log2deg_c-1 -: log2deg_c];
assign vn_order_1 = single_vn_order_indices[(deg_v-1)*log2deg_c-1 -: log2deg_c];
assign vn_order_0 = single_vn_order_indices[(deg_v-2)*log2deg_c-1 -: log2deg_c];

reg [deg_c*(INT+FRAC)-1:0] cn_msgs_to_vn_neighbors_0;
reg [deg_c*(INT+FRAC)-1:0] cn_msgs_to_vn_neighbors_1;
reg [deg_c*(INT+FRAC)-1:0] cn_msgs_to_vn_neighbors_2;

wire [INT+FRAC-1:0] cn_vn_msgs_2;
wire [INT+FRAC-1:0] cn_vn_msgs_1;
wire [INT+FRAC-1:0] cn_vn_msgs_0;
assign cn_vn_msgs_2 = cn_msgs_to_vn_neighbors_2[vn_order_2*(INT+FRAC)-1 -: (INT+FRAC)];
assign cn_vn_msgs_1 = cn_msgs_to_vn_neighbors_1[vn_order_1*(INT+FRAC)-1 -: (INT+FRAC)];
assign cn_vn_msgs_0 = cn_msgs_to_vn_neighbors_0[vn_order_0*(INT+FRAC)-1 -: (INT+FRAC)];

wire [INT+FRAC-1:0] vn_out_1;
wire [INT+FRAC-1:0] vn_out_2;
wire [INT+FRAC-1:0] vn_out_3;
wire [INT+FRAC-1:0] belief_out;

vr vn_0_inst (
	.LLR(LLR_in),
	.ch_msg_0(cn_vn_msgs_0),
	.ch_msg_1(cn_vn_msgs_1),
	.ch_msg_2(cn_vn_msgs_2),
	.vr_msg_0(vn_out_1),
	.vr_msg_1(vn_out_2),
	.vr_msg_2(vn_out_3),
	.belief(belief_out)
	);


reg data_iter_rst;
wire data_iter_counter_rst;
assign data_iter_counter_rst = data_iter_rst || rst;
wire [log2n-1:0] data_iter;
wire [2:0] data_iter_count_state;

data_iter_counter data_iter_counter_0_inst(
	.clk(clk),
	.rst(data_iter_counter_rst),
	.data_iter_count(data_iter),
	.state(data_iter_count_state)
	);

reg check_iter_rst;
wire check_iter_counter_rst;
assign check_iter_counter_rst = check_iter_rst || rst;
wire [log2m-1:0] check_iter;
wire [2:0] check_iter_count_state;

check_iter_counter check_iter_counter_0_inst(
	.clk(clk),
	.rst(check_iter_counter_rst),
	.check_iter_count(check_iter),
	.state(check_iter_count_state)
	);


always @(posedge clk or posedge rst) begin
	if (rst) begin
		FSM <= 0;
		data_iter_rst <= 1;
		check_iter_rst <= 0;
		iter_num <= 0;

		success_dec <= 0;
		dec_cw <= data;
		non_zero_syn <= 0;
		
		single_chk_neighbors_indices <= c_neighbor[0];
		// Make syn_res = 0 the clock cycle after rst is deasserted
		bit_5_in <= 0;
		bit_4_in <= 0;
		bit_3_in <= 0;
		bit_2_in <= 0;
		bit_1_in <= 0;
		bit_0_in <= 0;

		nop <= 1;
	end

	else if (FSM == 0) begin
		if(check_iter_count_state[1]) begin
			if(nop) begin
				nop <= 0;
				bit_5_in <= dec_cw[chk_neighbor_5];
				bit_4_in <= dec_cw[chk_neighbor_4];
				bit_3_in <= dec_cw[chk_neighbor_3];
				bit_2_in <= dec_cw[chk_neighbor_2];
				bit_1_in <= dec_cw[chk_neighbor_1];
				bit_0_in <= dec_cw[chk_neighbor_0];
			end else begin
				data_iter_rst <= 0;
				check_iter_rst <= 1;
				nop <= 1;
				if(syn_res) begin
					FSM <= 1;
				end else begin
					FSM <= 4;
				end
			end
		end

		else begin
			single_chk_neighbors_indices <= c_neighbor[check_iter];
			bit_5_in <= dec_cw[chk_neighbor_5];
			bit_4_in <= dec_cw[chk_neighbor_4];
			bit_3_in <= dec_cw[chk_neighbor_3];
			bit_2_in <= dec_cw[chk_neighbor_2];
			bit_1_in <= dec_cw[chk_neighbor_1];
			bit_0_in <= dec_cw[chk_neighbor_0];

			if(syn_res) begin
				data_iter_rst <= 0;
				FSM <= 1;
			end
		end
	end

	else if (FSM == 1) begin
		if(data_iter_count_state[1]) begin
			if(nop) begin
				nop <= 0;

				single_chk_neighbors_indices <= c_neighbor[1];
				single_chk_order_indices <= neighbor_index_to_var[1];
			end else begin
				FSM <= 2;
				data_iter_rst <= 1;
				check_iter_rst <= 0;
				nop <= 1;

				c_msg[0] <= {cn_vn_msgs_0_5,cn_vn_msgs_0_4,cn_vn_msgs_0_3,cn_vn_msgs_0_2,cn_vn_msgs_0_1,cn_vn_msgs_0_0};
				if(syn_res) begin
					non_zero_syn <= 1;
				end

				single_chk_neighbors_indices <= c_neighbor[2];
				single_chk_order_indices <= neighbor_index_to_var[2];
			end

			vn_msgs_to_chk_neighbors_0 <= v_msg[chk_neighbor_0];
			vn_msgs_to_chk_neighbors_1 <= v_msg[chk_neighbor_1];
			vn_msgs_to_chk_neighbors_2 <= v_msg[chk_neighbor_2];
			vn_msgs_to_chk_neighbors_3 <= v_msg[chk_neighbor_3];
			vn_msgs_to_chk_neighbors_4 <= v_msg[chk_neighbor_4];
			vn_msgs_to_chk_neighbors_5 <= v_msg[chk_neighbor_5];

			bit_5_in <= dec_cw[chk_neighbor_5];
			bit_4_in <= dec_cw[chk_neighbor_4];
			bit_3_in <= dec_cw[chk_neighbor_3];
			bit_2_in <= dec_cw[chk_neighbor_2];
			bit_1_in <= dec_cw[chk_neighbor_1];
			bit_0_in <= dec_cw[chk_neighbor_0];
		end else begin
			v_msg[data_iter] <= {deg_v{LLR_in}};

			single_chk_neighbors_indices <= c_neighbor[0];
			single_chk_order_indices <= neighbor_index_to_var[0];
		end
	end

	else if (FSM == 2) begin
		if(check_iter_count_state[1]) begin
			if(nop) begin
				nop <= 0;

				if(~non_zero_syn) begin
					FSM <= 4;
				end

				single_vn_neighbors_indices <= v_neighbor[1];
				single_vn_order_indices <= neighbor_index_to_ch[1];
			end else begin
				if(iter_num < max_iter) begin
					FSM <= 3;
					data_iter_rst <= 0;
					check_iter_rst <= 1;
					nop <= 1;

					iter_num <= iter_num + 1;
				end
				v_msg[0] <= {vn_out_3,vn_out_2,vn_out_1};
				dec_cw[0] <= ~belief_out[INT+FRAC-1];

				single_vn_neighbors_indices <= v_neighbor[2];
				single_vn_order_indices <= neighbor_index_to_ch[2];
			end
		end else begin
			c_msg[check_iter] <= {cn_vn_msgs_0_5,cn_vn_msgs_0_4,cn_vn_msgs_0_3,cn_vn_msgs_0_2,cn_vn_msgs_0_1,cn_vn_msgs_0_0};

			if(syn_res) begin
				non_zero_syn <= 1;
			end

			single_vn_neighbors_indices <= v_neighbor[0];
			single_vn_order_indices <= neighbor_index_to_ch[0];
		end

		single_chk_neighbors_indices <= c_neighbor[check_iter+2];
		single_chk_order_indices <= neighbor_index_to_var[check_iter+2];

		bit_5_in <= dec_cw[chk_neighbor_5];
		bit_4_in <= dec_cw[chk_neighbor_4];
		bit_3_in <= dec_cw[chk_neighbor_3];
		bit_2_in <= dec_cw[chk_neighbor_2];
		bit_1_in <= dec_cw[chk_neighbor_1];
		bit_0_in <= dec_cw[chk_neighbor_0];
	end

	else if (FSM == 3) begin
		if(data_iter_count_state[1]) begin
			if(nop) begin
				nop <= 0;

				single_chk_neighbors_indices <= c_neighbor[1];
				single_chk_order_indices <= neighbor_index_to_var[1];
			end else begin
				FSM <= 2;
				data_iter_rst <= 1;
				check_iter_rst <= 0;
				nop <= 1;

				c_msg[0] <= {cn_vn_msgs_0_5,cn_vn_msgs_0_4,cn_vn_msgs_0_3,cn_vn_msgs_0_2,cn_vn_msgs_0_1,cn_vn_msgs_0_0};
				if(syn_res) begin
					non_zero_syn <= 1;
				end

				single_chk_neighbors_indices <= c_neighbor[2];
				single_chk_order_indices <= neighbor_index_to_var[2];
			end
		end else begin
			v_msg[data_iter+1] <= {vn_out_3,vn_out_2,vn_out_1};
			dec_cw[data_iter+1] <= ~belief_out[INT+FRAC-1];

			single_chk_neighbors_indices <= c_neighbor[0];
			single_chk_order_indices <= neighbor_index_to_var[0];
		end

		single_vn_neighbors_indices <= v_neighbor[data_iter+2];
		single_vn_order_indices <= neighbor_index_to_ch[data_iter+2];
	end

	else if (FSM == 4) begin
		success_dec <= 1;
	end
end

endmodule
