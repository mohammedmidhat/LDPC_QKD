always @(posedge clk or posedge rst) begin
	if (rst) begin
		FSM <= 0;
		circ_iter <= 0;
		iter_num <= 0;

		nop <= 0;

		success_dec <= 0;
		dec_cw <= data;
		non_zero_syn <= 0;
		chk_r <= 0;
		chk_w <= 0;		
	end

	else if (FSM == 0) begin
		if(circ_iter == circ) begin
			if(nop == 0) begin
				if(non_zero_syn) begin
					FSM <= 1;

					chk_r <= 1;
				
					non_zero_syn <= 0;
				end
				else begin
					FSM <= 3;
				end
			
				circ_iter <= 0;
				circ_iter_ <= 0;
			end
			else begin
				if(syn_res) begin
					non_zero_syn <= 1;
				end

				nop <= 0;
			end
		end
		else begin
			if(nop == 1) begin
				if(syn_res) begin
					non_zero_syn <= 1;
				end
			end

			circ_iter <= circ_iter + 1;

			nop <= 1;
		end
	end

	// Update Variable Node messages
	else if (FSM == 1) begin
		if(circ_iter == circ) begin
			if(nop == 2) begin
				circ_iter_ <= circ_iter_ + 1;

				nop <= 1;
			end
			else if (nop == 1) begin
				nop <= 0;
				FSM <= 2;

				chk_r <= 0;
				chk_w <= 1;

				circ_iter <= 0;
				circ_iter_ <= 0;
			end