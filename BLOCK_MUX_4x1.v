
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:25:58 05/25/2021 
// Design Name: 
// Module Name:    BLOCK_MUX_4x1 
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
module BLOCK_MUX_4x1 #(parameter SEL_WIDTH = 2,DATA_WIDTH = 1 << SEL_WIDTH)
    (
    input [DATA_WIDTH-1:0] I,
    input [SEL_WIDTH-1:0] I_sel,
    output o
    );


wire [DATA_WIDTH -1 :0] BUS_CON [SEL_WIDTH:0];

assign BUS_CON [0] = I;
assign o = BUS_CON [SEL_WIDTH][0] ;

genvar i,j;
generate
		for (i=0; i<SEL_WIDTH ; i=i+1) begin: outer
					
				for (j=0; j< (1<<(SEL_WIDTH-i-1) ); j=j+1) begin :inner
			
				BLOCK_MUX_2x1 M ( .i0(BUS_CON[i][j+j])  , .i1(BUS_CON[i][j+j+1])  , .i_sel(I_sel[i]), .o(BUS_CON[i+1][j]) );
			
			   end	
				
		end
endgenerate

endmodule
