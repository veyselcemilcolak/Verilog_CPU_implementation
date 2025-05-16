
`timescale 1ns / 1ps
//1 bit register cell
module DFF(
    output reg q,
	 input wire d,en,clk
	 );
	always @(posedge clk) 
		if(en)
			q<=d;
		
endmodule
