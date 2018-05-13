			end
			else if (nop == 1) begin
				nop <= 2;
			end
			else begin
				nop <= 1;
			end

			circ_iter <= circ_iter + 1;
		end
	end

	// Update Check Node messages
	else if (FSM == 2) begin
		if(circ_iter == circ) begin
			if(nop == 2) begin
				circ_iter_ <= circ_iter_ + 1;

				if(syn_res) begin
					non_zero_syn <= 1;
				end

				nop <= 1;
			end
			else if (nop == 1) begin
				if(non_zero_syn) begin
					if(iter_num < max_iter) begin
						nop <= 0;
						FSM <= 1;

						chk_r <= 1;
						chk_w <= 0;

						non_zero_syn <= 0;

						iter_num <= iter_num + 1;

						circ_iter <= 0;
						circ_iter_ <= 0;
					end
					else begin
						FSM <= 4;
					end
				end
				else begin
					FSM <= 3;
				end
			end
		end
		else begin
			if(nop == 2) begin
				circ_iter_ <= circ_iter_ + 1;

				if(syn_res) begin
					non_zero_syn <= 1;
				end
			end
			else if (nop == 1) begin
				if(syn_res) begin
					non_zero_syn <= 1;
				end

				nop <= 2;
			end
			else begin
				nop <= 1;
			end

			circ_iter <= circ_iter + 1;
		end
	end

	else if (FSM == 3) begin
		success_dec <= 1;
	end
	else if (FSM == 4) begin
		success_dec <= 0;
	end
end

endmodule
