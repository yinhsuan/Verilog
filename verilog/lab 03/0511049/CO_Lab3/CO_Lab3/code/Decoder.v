//Subject:     CO project 2 - Decoder
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      Luke
//----------------------------------------------
//Date:        2010/8/16
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
//0511049

module Decoder(
/////////////////
        instr_op_i,
	instr_func_i,
	RegWrite_o,
	ALU_op_o,
	ALUSrc_o,
	RegDst_o,
	Branch_o,
	MemToReg_o,
	Jump_o,
	MemRead_o,
	MemWrite_o
//	ReadReg_o
//	pc_out_i,
//	pc_in_o
////////////////
	);
     
//I/O ports
input  [6-1:0] instr_op_i;
input  [6-1:0] instr_func_i;//////////////
//input  [32-1:0]pc_out_i;///////////

output         RegWrite_o;
output [3-1:0] ALU_op_o;
output         ALUSrc_o;
output [2-1:0] RegDst_o;
output         Branch_o;
output [2-1:0] MemToReg_o;//////////////
output	       Jump_o;//////////////////
output	       MemRead_o;///////////////
output	       MemWrite_o;//////////////
//output	       ReadReg_o;///////////
//output  [32-1:0]pc_in_o;/////////
 
//Internal Signals
wire    [3-1:0] ALU_op_o;
wire            ALUSrc_o;/////////////////
wire            RegWrite_o;//////////////////
wire    [2-1:0] RegDst_o;///////////////
wire            Branch_o;///////////////
wire	[2-1:0] MemToReg_o;//////////////
wire		MemRead_o;///////////////
wire		MemWrite_o;//////////////
wire	[2-1:0]	Jump_o;//////////////////
//wire  signed [32-1:0] REGISTER_BANK [0:32-1];//////////////

//Parameter
// 0000 => R-type
// 1000 => addi
// 0100 => beq
// 1010 => slti
// 0011 => lw
// 1011 => sw
// 0010 => jump
// 0111 => jal
// 1111 => default

// op-code
// 001000 => addi
// 000100 => beq
// 001010 => slti
// 100011 => lw
// 101011 => sw
// 000010 => j
// 000011 => jal
///////////////////////////////////
assign RegDst_o = (instr_op_i == 6'b000000)? 2'b01 : (instr_op_i == 6'b000011 ? 2'b10 : 2'b00); //R-type <= 1 //jal <= 2
assign RegWrite_o = ((instr_op_i == 6'b000000 && instr_func_i != 6'b001000) || instr_op_i == 6'b001000 ||
		      instr_op_i == 6'b001010 || instr_op_i == 6'b100011 || instr_op_i == 6'b000011)? 1'b1 : 1'b0; 
		     //R-type <= 1 (!jr) //addi => 1 //slti => 1 //lw => 1 // jal => 1 
assign Branch_o = (instr_op_i == 6'b000100)? 1'b1 : 1'b0; //beq <= 1
assign ALUSrc_o = (instr_op_i == 6'b000000 || instr_op_i == 6'b000100)? 1'b0 : 1'b1; //R-type <= 0 //beq <= 0
assign ALU_op_o = (instr_op_i == 6'b000000)? 3'b000: //add //sub //or //and //slt
                  (instr_op_i == 6'b001000)? 3'b001: //addi
                  (instr_op_i == 6'b000100)? 3'b100: //beq
                  (instr_op_i == 6'b001010)? 3'b010: //slti
		  (instr_op_i == 6'b100011)? 3'b011: //lw
		  (instr_op_i == 6'b101011)? 3'b110: //sw
		  (instr_op_i == 6'b000011)? 3'b101: 3'b111; //jal
		  //(instr_op_i == 6'b000010)? 4'b0010: //jump
assign MemToReg_o = (instr_op_i == 6'b100011) ? 2'b01 : 2'b00; //lw <= 1 //jal <= 0
//assign MemToReg_o = (instr_op_i == 6'b100011) ? 2'b01 : (instr_op_i == 6'b000011 ? 2'b10 : 2'b00); //lw <= 1 //jal <= 0
assign MemWrite_o = (instr_op_i == 6'b101011) ? 1'b1 : 1'b0; //sw <= 1
assign MemRead_o = (instr_op_i == 6'b100011) ? 1'b1 : 1'b0; //lw <= 1
assign Jump_o = (instr_op_i == 6'b000010 || instr_op_i == 6'b000011) ? 2'b00 : ((instr_op_i == 6'b000000 && instr_func_i == 6'b001000) ? 2'b10 : 2'b01); //jump <= 0 //jr <= 2
//assign ReadReg_o = (instr_op_i == 6'b000000 && instr_func_i == 6'b001000) ? 1'b1 : 1'b0; // jr <= 1

//assign REGISTER_BANK[31] = (instr_op_i == 6'b000011) ? (pc_out_i) : 32'b0;
//assign pc_in_o = (instr_op_i == 6'b000000 && instr_func_i == 6'b001000) ? REGISTER_BANK[31] : 32'b0;
///////////////////////////////////
//Main function


endmodule





                    
                    