`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:39:15 05/27/2021 
// Design Name: 
// Module Name:    BLOCK_ALU1 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module BLOCK_ALU1 #(parameter FUNCTION_BITS = 4)(

    input [FUNCTION_BITS-1:0] I_sel,
    input i_a,
    input i_b,
    input i_c,
    output o_s,
    output o_c
	 
    );
		
		wire wi,ws,wo;
		
		BLOCK_MUX_2x1 MI(.i0(i_b), .i1(!i_b), .i_sel(I_sel[0]), .o(wi));
		BLOCK_MUX_4x1 MS(.I_sel(I_sel[2:1]), .I({i_b,i_c,1'b1,1'b0}), .o(ws) );
		BLOCK_FA F1(.in_c(ws), .x1(i_a), .x2(wi), .s(wo), .out_c(o_c) );  
		BLOCK_MUX_2x1 MO(.i0(wo), .i1(o_c), .i_sel(I_sel[3]), .o(o_s));


endmodule
