`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:25:53 05/25/2021 
// Design Name: 
// Module Name:    BLOCK_MUX_2x1 
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
module BLOCK_MUX_2x1(
    input i_sel,
    input i1,
    input i0,
    output o
    );

wire w1,w2,w3;

not GI(w1,i_sel);
nand N1 (w2,i1,i_sel);
nand N2 (w3,i0,w1);
nand N3 (o,w2,w3);

endmodule
