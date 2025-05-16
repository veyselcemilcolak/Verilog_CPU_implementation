
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:14:24 05/06/2021 
// Design Name: 
// Module Name:    
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
module BLOCK_FA(
    input in_c,
    input x1,
    input x2,
    output out_c,
    output s
    );
	 
	 wire w1,w2,w3,w4,w5,w6;

nor Gnor1 (w1,x1,x2);
nor Gnor2 (w2,x1,in_c);
nor Gnor3 (w3,x2,in_c);
nor Gnor4 (w4,w2,w1);

not GI(w5,w4);
nor Gnor5 (out_c,w5,w3);

xor GX1(w6,x1,x2);
xor GX2(s,w6,in_c);



endmodule
