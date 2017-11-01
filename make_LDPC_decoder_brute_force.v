module decoder#(parameter n = 204, parameter m = 102, parameter log2n = 8, parameter log2m = 7, parameter max_iter = 30, parameter log2max_iter = 5,
				parameter INT = 8, parameter FRAC = 8, parameter deg_v = 3, parameter deg_c = 6, parameter log2deg_v = 2, parameter log2deg_c = 3)(
	input clk,
	input rst,
	output [log2max_iter-1:0] iterations,
	output success
	);

reg [n*deg_v*log2m-1:0] v_neighbor;
reg [m*deg_c*log2n-1:0] c_neighbor;
reg [m*deg_c*log2deg_v-1:0] neighbor_index_to_var;	// specifies the neighboring index of a check to a var
													// e.g. ch2 is the 1st neighbor check in its 3rd var neighbor
reg [n*deg_v*(INT+FRAC)-1:0] v_msg;
reg [m*deg_c*(INT+FRAC)-1:0] c_msg;
reg [INT+FRAC-1:0] LLR;
reg [n*(INT+FRAC)-1:0] LLRs;

reg [n-1:0] data;
reg [1:0] FSM;

reg success_dec;
assign success = success_dec;

reg [log2max_iter-1:0] iter_num;
assign iterations = iter_num;
reg [log2n-1:0] data_iter;
reg [log2m-1:0] check_iter;


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

vn vn_0_inst (
	.msg_in_1(cn_vn_msgs_0),
	.msg_in_2(cn_vn_msgs_1),
	.msg_in_3(cn_vn_msgs_2),
	.msg_out_1(vn_out_1),
	.msg_out_2(vn_out_2),
	.msg_out_3(vn_out_3),
	.belief(belief_out)
	);


always @(posedge clk or posedge rst) begin
	if (rst) begin
		FSM <= 0;
		success_dec <= 0;
		data_iter <= 1;
		check_iter <= 1;
		iter_num <= 0;
	end
	else if (FSM == 0) begin
		if (data_iter < 205) begin
			LLRs[data_iter*(INT+FRAC)-1 -: INT+FRAC] <= data[data_iter-1]*LLR;
		
			v_msg[data_iter*deg_v*(INT+FRAC)-1 -: INT+FRAC] <= data[data_iter-1]*LLR;
			v_msg[(data_iter*deg_v-1)*(INT+FRAC)-1 -: INT+FRAC] <= data[data_iter-1]*LLR;
			v_msg[(data_iter*deg_v-2)*(INT+FRAC)-1 -: INT+FRAC] <= data[data_iter-1]*LLR;

			data_iter <= data_iter + 1;
		end
		
		if(data_iter == 205)begin
			data_iter <= 1;
			FSM <= 1;

			vn_cn_msgs_0_5 <= v_msg[((c_neighbor[(deg_c)*log2n-1 -: log2n])*deg_v-neighbor_index_to_var[(deg_c)*log2deg_v-1 -: log2deg_v])*(INT+FRAC)-1 -: INT+FRAC];
			vn_cn_msgs_0_4 <= v_msg[((c_neighbor[(deg_c-1)*log2n-1 -: log2n])*deg_v-neighbor_index_to_var[(deg_c-1)*log2deg_v-1 -: log2deg_v])*(INT+FRAC)-1 -: INT+FRAC];
			vn_cn_msgs_0_3 <= v_msg[((c_neighbor[(deg_c-2)*log2n-1 -: log2n])*deg_v-neighbor_index_to_var[(deg_c-2)*log2deg_v-1 -: log2deg_v])*(INT+FRAC)-1 -: INT+FRAC];
			vn_cn_msgs_0_2 <= v_msg[((c_neighbor[(deg_c-3)*log2n-1 -: log2n])*deg_v-neighbor_index_to_var[(deg_c-3)*log2deg_v-1 -: log2deg_v])*(INT+FRAC)-1 -: INT+FRAC];
			vn_cn_msgs_0_1 <= v_msg[((c_neighbor[(deg_c-4)*log2n-1 -: log2n])*deg_v-neighbor_index_to_var[(deg_c-4)*log2deg_v-1 -: log2deg_v])*(INT+FRAC)-1 -: INT+FRAC];
			vn_cn_msgs_0_0 <= v_msg[((c_neighbor[(deg_c-5)*log2n-1 -: log2n])*deg_v-neighbor_index_to_var[(deg_c-5)*log2deg_v-1 -: log2deg_v])*(INT+FRAC)-1 -: INT+FRAC];
		end
	end
	else if (FSM == 1) begin
		if (check_iter < 103) begin
			check_iter <= check_iter + 1;

			c_msg[check_iter*deg_c*(INT+FRAC)-1 -: INT+FRAC] <= cn_vn_msgs_0_5;
			c_msg[(check_iter*deg_c-1)*(INT+FRAC)-1 -: INT+FRAC] <= cn_vn_msgs_0_4;
			c_msg[(check_iter*deg_c-2)*(INT+FRAC)-1 -: INT+FRAC] <= cn_vn_msgs_0_3;
			c_msg[(check_iter*deg_c-3)*(INT+FRAC)-1 -: INT+FRAC] <= cn_vn_msgs_0_2;
			c_msg[(check_iter*deg_c-4)*(INT+FRAC)-1 -: INT+FRAC] <= cn_vn_msgs_0_1;
			c_msg[(check_iter*deg_c-5)*(INT+FRAC)-1 -: INT+FRAC] <= cn_vn_msgs_0_0;
		end

		if (check_iter < 102) begin
			neighbor_index_to_var_5 <= neighbor_index_to_var[((check_iter+1)*deg_c)*log2deg_v-1 -: log2deg_v];
			neighbor_index_to_var_4 <= neighbor_index_to_var[((check_iter+1)*deg_c-1)*log2deg_v-1 -: log2deg_v];
			neighbor_index_to_var_3 <= neighbor_index_to_var[((check_iter+1)*deg_c-2)*log2deg_v-1 -: log2deg_v];
			neighbor_index_to_var_2 <= neighbor_index_to_var[((check_iter+1)*deg_c-3)*log2deg_v-1 -: log2deg_v];
			neighbor_index_to_var_1 <= neighbor_index_to_var[((check_iter+1)*deg_c-4)*log2deg_v-1 -: log2deg_v];
			neighbor_index_to_var_0 <= neighbor_index_to_var[((check_iter+1)*deg_c-5)*log2deg_v-1 -: log2deg_v];

			vn_5_ind <= c_neighbor[((check_iter+1)*deg_c)*log2n-1 -: log2n];
			vn_4_ind <= c_neighbor[((check_iter+1)*deg_c-1)*log2n-1 -: log2n];
			vn_3_ind <= c_neighbor[((check_iter+1)*deg_c-2)*log2n-1 -: log2n];
			vn_2_ind <= c_neighbor[((check_iter+1)*deg_c-3)*log2n-1 -: log2n];
			vn_1_ind <= c_neighbor[((check_iter+1)*deg_c-4)*log2n-1 -: log2n];
			vn_0_ind <= c_neighbor[((check_iter+1)*deg_c-5)*log2n-1 -: log2n];

			vn_cn_msgs_0_5 <= v_msg[(vn_5_ind*deg_v-neighbor_index_to_var_5)*(INT+FRAC)-1 -: INT+FRAC];
			vn_cn_msgs_0_4 <= v_msg[(vn_4_ind*deg_v-neighbor_index_to_var_4)*(INT+FRAC)-1 -: INT+FRAC];
			vn_cn_msgs_0_3 <= v_msg[(vn_3_ind*deg_v-neighbor_index_to_var_3)*(INT+FRAC)-1 -: INT+FRAC];
			vn_cn_msgs_0_2 <= v_msg[(vn_2_ind*deg_v-neighbor_index_to_var_2)*(INT+FRAC)-1 -: INT+FRAC];
			vn_cn_msgs_0_1 <= v_msg[(vn_1_ind*deg_v-neighbor_index_to_var_1)*(INT+FRAC)-1 -: INT+FRAC];
			vn_cn_msgs_0_0 <= v_msg[(vn_0_ind*deg_v-neighbor_index_to_var_0)*(INT+FRAC)-1 -: INT+FRAC];
		end

		if (iter_num < max_iter) begin
			if(check_iter == 103)begin
				check_iter <= 1;
				FSM <= 2;

				cn_vn_msgs_0 <= c_msg[v_neighbor[deg_v*log2m-1 -: log2m]];
				cn_vn_msgs_1
				cn_vn_msgs_2
			end
		end
	end
	else if(FSM == 2) begin
		
		if (data_iter == 205) begin
			data_iter <= 1;
			FSM <= 4;
		end
	end
end

endmodule
