//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
//0511049

module Decoder(
    instr_op_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o
	);
     
//I/O ports
input  [6-1:0] instr_op_i;

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output         RegDst_o;
output         Branch_o;
 
//Internal Signals
wire    [3-1:0] ALU_op_o;
wire            ALUSrc_o;
wire            RegWrite_o;
wire            RegDst_o;
wire            Branch_o;

//Parameter
// 000 => R-type
// 001 => addi
// 100 => beq
// 010 => slti

assign RegDst_o = (instr_op_i == 6'b000000)? 1'b1 : 1'b0; //R-type <= 1
assign RegWrite_o = (instr_op_i == 6'b000000 || instr_op_i == 6'b001000 || instr_op_i == 6'b001010)? 1'b1 : 1'b0; //R-type <= 1 //addi => 1 //slti => 1
assign Branch_o = (instr_op_i == 6'b000100)? 1'b1:1'b0; //beq <= 1
assign ALUSrc_o = (instr_op_i == 6'b000000 || instr_op_i == 6'b000100)? 1'b0 : 1'b1;
assign ALU_op_o = (instr_op_i == 6'b000000)? 3'b000: //add //sub //or //and //slt
                  (instr_op_i == 6'b001000)? 3'b001: //addi
                  (instr_op_i == 6'b000100)? 3'b100: //beq
                  (instr_op_i == 6'b001010)? 3'b010: 3'b111; //slti
//Main function

endmodule





                    
                    
