`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:07:04 06/16/2021 
// Design Name: 
// Module Name:    CONTROL_UNIT 
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
module CONTROL_UNIT(
    input [15:0] INSTRUCTIONS,
    input [15:0] PSR,
    input clk,
    output [3:0] Rdest,
    output [7:0] R2_im,
    output reg ImFlag,
    output reg [3:0] ALUcode,
    output reg shiftFlag,
    output reg mem_r,
    output reg mem_w,
    output reg reg_w,
	 output reg comp_flag,
    output reg jal,
    output reg jcond,
	 output reg branch,
	 output reg s_ext
    );
//extended OP field
	//if OP CODE is 4'b0000
		localparam ADD = 4'b0101;
		localparam SUB = 4'b1001;
		localparam CMP = 4'b1011;
		localparam AND = 4'b0001;
		localparam OR  = 4'b0010;
		localparam XOR = 4'b0011;
		localparam MOV = 4'b1101;
	
	//OP CODES
	localparam ADDI = 4'b0101;
	localparam SUBI = 4'b1001;
	localparam CMPI = 4'b1011;
	localparam ANDI = 4'b0001;
	localparam ORI  = 4'b0010;
	localparam XORI = 4'b0011;
	localparam MOVI = 4'b1101;
	localparam SHFT = 4'b1000;
		localparam LSH  = 4'b0100;
		localparam LSHI = 3'b000; //check MSBs
	//localparam LUI = 4'b1111;
	localparam LO_ST_J = 4'b0100;
		localparam LOAD = 4'b0000;
		localparam STOR = 4'b0100;
	localparam BCOND = 4'b1100;
			localparam EQ = 4'b0000;
	localparam JUMPS = 4'b0100;
		localparam JCOND = 4'b1100; 	
		localparam JAL   = 4'b1000;
		
		reg[15:0] INST_REG;
		always @(*)begin
			INST_REG = INSTRUCTIONS;
		end
		
		
		
		wire[3:0] block3 ;
		wire[3:0] block2 ;
		wire[3:0] block1 ;
		wire[3:0] block0 ;
		
		assign block3 = INST_REG[15:12];
		assign block2 = INST_REG[11:8];
		assign block1 = INST_REG[7:4];
		assign block0 = INST_REG[3:0];
		
		assign Rdest = block2;
		assign R2_im = {block1,block0};
		

		
		
		always@(*) begin
		
		
			case (block3)
			4'b0000: begin
					ImFlag =1'b0;
					shiftFlag =1'b0;
					mem_r =1'b0;
					mem_w =1'b0;
					reg_w =1'b1;
					branch = 1'b0;
					s_ext = 1'b0;	
					jal = 1'b0;	
					jcond = 1'b0;					
					case (block1)
					ADD: begin
						ALUcode =4'b0100;
						comp_flag =1'b0;
					end
					SUB: begin
						ALUcode =4'b0101;
						comp_flag =1'b0;
					end
					CMP: begin
						ALUcode =4'b0101;
						comp_flag =1'b1;
						reg_w =1'b0;
					end
					AND: begin
						ALUcode =4'b1000;
						comp_flag =1'b0;
					end
					OR: begin
						ALUcode =4'b1010;
						comp_flag =1'b0;
					end
					XOR: begin
						ALUcode =4'b0000;
						comp_flag =1'b0;
					end
					MOV: begin
						ALUcode =4'b1110;
						comp_flag =1'b0;
					end					
					endcase					
			end
			ADDI: begin
					ImFlag =1'b1;
					shiftFlag =1'b0;
					mem_r =1'b0;
					mem_w =1'b0;
					reg_w =1'b1;
					ALUcode =4'b0100;
					comp_flag =1'b0;
					branch = 1'b0;	
					s_ext = 1'b1;
					jal = 1'b0;	
					jcond = 1'b0;	
			end
			SUBI: begin
					ImFlag =1'b1;
					shiftFlag =1'b0;
					mem_r =1'b0;
					mem_w =1'b0;
					reg_w =1'b1;
					ALUcode =4'b0101;
					comp_flag =1'b0;
					branch = 1'b0;	
					s_ext = 1'b1;
					jal = 1'b0;	
					jcond = 1'b0;	
			end
			CMPI: begin
					ImFlag =1'b1;
					shiftFlag =1'b0;
					mem_r =1'b0;
					mem_w =1'b0;
					reg_w =1'b0;
					ALUcode =4'b0101;
					comp_flag =1'b1;
					branch = 1'b0;	
					s_ext = 1'b1;
					jal = 1'b0;	
					jcond = 1'b0;	
			end
			ANDI: begin
					ImFlag =1'b1;
					shiftFlag =1'b0;
					mem_r =1'b0;
					mem_w =1'b0;
					reg_w =1'b1;
					ALUcode =4'b1000;
					comp_flag =1'b0;
					branch = 1'b0;	
					s_ext = 1'b0;
					jal = 1'b0;	
					jcond = 1'b0;	
			end
			ORI: begin
					ImFlag =1'b1;
					shiftFlag =1'b0;
					mem_r =1'b0;
					mem_w =1'b0;
					reg_w =1'b1;
					ALUcode =4'b1010;
					comp_flag =1'b0;
					branch = 1'b0;	
					s_ext = 1'b0;
					jal = 1'b0;	
					jcond = 1'b0;	
			end
			XORI: begin
					ImFlag =1'b1;
					shiftFlag =1'b0;
					mem_r =1'b0;
					mem_w =1'b0;
					reg_w =1'b1;
					ALUcode =4'b0000;
					comp_flag =1'b0;
					branch = 1'b0;	
					s_ext = 1'b0;
					jal = 1'b0;	
					jcond = 1'b0;	
			end
			MOVI: begin
					ImFlag =1'b1;
					shiftFlag =1'b0;
					mem_r =1'b0;
					mem_w =1'b0;
					reg_w =1'b1;
					ALUcode =4'b1110;
					comp_flag =1'b0;
					branch = 1'b0;	
					s_ext = 1'b0;
					jal = 1'b0;	
					jcond = 1'b0;	
			end
			SHFT: begin
					shiftFlag =1'b1;
					mem_r =1'b0;
					mem_w =1'b0;
					reg_w =1'b1;
					ALUcode =4'b1111;
					comp_flag =1'b0;
					branch = 1'b0;	
					s_ext = 1'b0;
					jal = 1'b0;	
					jcond = 1'b0;						
					case (block1[3:1])
					LSHI: begin
						ImFlag =1'b1;
					end
					LSH[3:1]: begin
						ImFlag =1'b0;
					end
					endcase
			end
			LO_ST_J: begin

					case(block1)
					LOAD: begin
						ImFlag =1'b0;
						shiftFlag =1'b0;
						ALUcode =4'b1111;
						comp_flag =1'b0;
						branch = 1'b0;	
						s_ext = 1'b0;
						jal = 1'b0;	
						jcond = 1'b0;	
						mem_r =1'b1;
						mem_w =1'b0;
						reg_w =1'b1;
					end
					STOR: begin
						ImFlag =1'b0;
						shiftFlag =1'b0;
						ALUcode =4'b1111;
						comp_flag =1'b0;
						branch = 1'b0;	
						s_ext = 1'b0;
						jal = 1'b0;	
						jcond = 1'b0;	
						mem_r =1'b0;
						mem_w =1'b1;
						reg_w =1'b0;
					end
					JCOND:begin
						ImFlag =1'b0;
						shiftFlag =1'b0;
						mem_r =1'b0;
						mem_w =1'b0;
						ALUcode =4'b1111;
						comp_flag =1'b0;
						s_ext = 1'b0;
						branch = 1'b0;				
						reg_w =1'b0;
							case (block2)
							EQ: begin
								if(PSR[6]) begin
									jcond=1'b1;
									jal=1'b0;
								end else begin
									jcond= 1'b0;
									jal=1'b0;							
								end
							end
							endcase
					end
					JAL:begin
							ImFlag =1'b0;
							shiftFlag =1'b0;
							mem_r =1'b0;
							mem_w =1'b0;
							ALUcode =4'b1111;
							comp_flag =1'b0;
							s_ext = 1'b0;
							branch = 1'b0;
							reg_w =1'b1;
							jal =1'b1;
							jcond= 1'b0;
					end
					endcase	
			end
			BCOND: begin
					ImFlag =1'b0;
					shiftFlag =1'b0;
					mem_r =1'b0;
					mem_w =1'b0;
					reg_w =1'b0;
					ALUcode =4'b1111;
					comp_flag =1'b0;
					s_ext = 1'b0;
					jal = 1'b0;	
					jcond = 1'b0;	
					case (block2)
					EQ: begin
						if(PSR[6]) begin
							branch=1'b1;
						end else begin
							branch = 1'b0;	
						end
					end
					endcase
			end
			endcase		
			
		end	
	

endmodule
