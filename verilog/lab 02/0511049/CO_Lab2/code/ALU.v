//Subject:     CO project 2 - ALU
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

module ALU(
    src1_i,
	src2_i,
	ctrl_i,
	result_o,
	zero_o
	);
     
//I/O ports
input  [32-1:0]  src1_i;
input  [32-1:0]	 src2_i;
input  [4-1:0]   ctrl_i;

output [32-1:0]	 result_o;
output           zero_o;

//Internal signals
reg    [32-1:0]  result_o;
wire             zero_o;

//Parameter
assign zero_o = result_o ? 1'b0 : 1'b1;
//Main function
always @(src1_i, src2_i, ctrl_i) begin
	case (ctrl_i)
		1 : result_o <= src1_i + src2_i; //add
		2 : result_o <= src1_i - src2_i; //sub
		3 : result_o <= src1_i | src2_i; //or
		4 : result_o <= src1_i & src2_i; //and
		5 : result_o <= (src1_i < src2_i)? 1'b1 : 1'b0; //slt
		6 : result_o <= src1_i + src2_i; //addi
		7 : result_o <= (src1_i < src2_i)? 1'b1 : 1'b0; //slti
		8 : result_o <= (src1_i == src2_i)? 1'b0 : 1'b1; //beq
		default : result_o <= 1'b0;
	endcase
end
endmodule
