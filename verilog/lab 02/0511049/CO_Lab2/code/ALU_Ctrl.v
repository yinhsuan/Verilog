//Subject:     CO project 2 - ALU Controller
//--------------------------------------------------------------------------------
//Version:     1
//--------------------------------------------------------------------------------
//Writer:      
//----------------------------------------------
//Date:        
//----------------------------------------------
//Description: 
//--------------------------------------------------------------------------------
//0511049

module ALU_Ctrl(
          funct_i,
          ALUOp_i,
          ALUCtrl_o
          );
          
//I/O ports 
input      [6-1:0] funct_i;
input      [3-1:0] ALUOp_i;

output     [4-1:0] ALUCtrl_o;    
     
//Internal Signals
wire        [4-1:0] ALUCtrl_o;

//Parameter
//Select exact operation
//000 => R-type 
//add //sub //or //and //slt
//001 => addi
//010 => slti
//100 => beq
assign ALUCtrl_o = (ALUOp_i == 3'b000 && funct_i == 6'b100000)? 4'b0001: //add 1
                   (ALUOp_i == 3'b000 && funct_i == 6'b100010)? 4'b0010: //sub 2
                   (ALUOp_i == 3'b000 && funct_i == 6'b100101)? 4'b0011: //or 3
                   (ALUOp_i == 3'b000 && funct_i == 6'b100100)? 4'b0100: //and 4
                   (ALUOp_i == 3'b000 && funct_i == 6'b101010)? 4'b0101: //slt 5
                   (ALUOp_i == 3'b001)? 4'b0110: //addi 6
		  		   (ALUOp_i == 3'b010)? 4'b0111: //slti 7
                   (ALUOp_i == 3'b100)? 4'b1000: 4'b0000; //beq 8 //else 0         
endmodule     





                    
                    
