`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:         MIT Quantum Photonics Group
// Author:        Mohammed Al Ai Baky
// 
// Create Date:     6/6/2018 
// Design Name:     LDPC_decoder_Frolov_1024_0.5
// Module Name:     clock_divider 
// Project Name:    LDPC_decoder_Frolov_1024_0.5
// Target Devices:  VC707 Virtex-7 FPGA
// Tool versions:   Vivado 2017.4
// Description:     Clock Divider
//
// Dependencies: 
//
// Revision: 
// Revision 0.0
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module clock_divider #(parameter WIDTH = 8, parameter clk_div_factor = 200)(
        input clk_in,
        output clk_out
    );
    
    reg [WIDTH-1:0] count = 0;
    reg clk_track = 0;
    assign clk_out = clk_track;
    
    always @(negedge clk_in) begin
        if (count == clk_div_factor/2-1) begin
             count <= 0;
             clk_track <= ~clk_track;
        end else begin
            count <= count + 1;
        end
    end
        
endmodule

