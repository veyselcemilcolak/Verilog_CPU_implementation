
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:56:53 05/27/2021 
// Design Name: 
// Module Name:    BLOCK_ALU16 
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
module BLOCK_ALU16 #(parameter FUNCTION_BITS = 4, DATA_LENGTH = 16)(
    input [DATA_LENGTH-1 : 0] I_a,
    input [DATA_LENGTH-1 : 0] I_b,
    input [FUNCTION_BITS-1 :0] I_sel,
	 input I_cmp,
	 input clk,
    output o_c,
    output [DATA_LENGTH-1:0] O_s,
	 output[15:0] O_psr
    );

	wire [DATA_LENGTH:0] W_carriers ;
	reg [15:0] W_psr;
	assign W_carriers[0] = I_sel[0];
	assign  o_c = W_carriers[DATA_LENGTH] ;

	
	genvar i;
	generate for (i=0; i<DATA_LENGTH; i= i+1) begin:ALU_ARRAY
		
		BLOCK_ALU1 #(.FUNCTION_BITS(FUNCTION_BITS)) A (.I_sel(I_sel), .i_a(I_a[i]), .i_b(I_b[i]), .o_s(O_s[i]), .i_c(W_carriers[i]), .o_c(W_carriers[i+1]) );
		
	end 
	endgenerate
	

	
	always @(posedge clk) begin
					W_psr [11:8] <= 4'b0;
					W_psr [4:3] <= 2'b0;
					W_psr [1] <= 1'b0;

		if( (~I_sel[3]) && (I_sel[2]) && (~I_sel[1]) )begin

				case (I_sel[0])
				1'b0:begin
					W_psr[0] <=W_carriers[DATA_LENGTH];//Carry
					W_psr[5] <= ^{W_carriers[DATA_LENGTH:DATA_LENGTH-1]};//OverFlow
				end
				1'b1:begin
					case (I_cmp)
					1'b0:begin
						W_psr[0] <= ~W_carriers[DATA_LENGTH];//Carry
						W_psr[5] <= ^{W_carriers[DATA_LENGTH:DATA_LENGTH-1]};//OverFlow										
					end
					1'b1:begin
						W_psr[2] <= ~W_carriers[DATA_LENGTH];//Lower	
						W_psr [6] <= ~|(O_s); //Zero
						W_psr [7] <= ^{O_s[DATA_LENGTH-1],W_carriers[DATA_LENGTH:DATA_LENGTH-1]}; //Negative	
					end
					endcase
				end				
				endcase
		end
		
	end

	assign O_psr=W_psr;
			

endmodule
