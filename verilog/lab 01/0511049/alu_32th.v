`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:58:01 10/10/2013
// Design Name: 
// Module Name:    alu_top 
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

module alu_32th(
               src1,       //1 bit source 1 (input)
               src2,       //1 bit source 2 (input)
               less,       //1 bit less     (input)
               A_invert,   //1 bit A_invert (input)
               B_invert,   //1 bit B_invert (input)
               cin,        //1 bit carry in (input)
               operation,  //operation      (input)
               result,     //1 bit result   (output)
               cout,       //1 bit carry out(output)
	       set_less
	       //overflow
               );

input         src1;
input         src2;

input         A_invert;
input         B_invert;
input         cin;
input [2-1:0] operation;

output        result;
output reg        cout;
//output        overflow;
output	      set_less;

reg           result; //WHY SET REG ???
reg  	      overflow;
input	      less;

wire	      src1_temp;
wire	      src2_temp;
reg          set_less;

assign src1_temp = (A_invert ? ~src1 : src1);
assign src2_temp = (B_invert ? ~src2 : src2);
//assign cout = (src1_temp & src2_temp) | (src1_temp & cin) | (src2_temp & cin); //sequential


always@( src1_temp or src2_temp or operation  or cin)
begin
	//SIGNED NOT CONSIDERED YET
	if (operation == 2'b00) begin
		result = src1_temp & src2_temp;
		cout = 1'b0;
	end
	else if (operation == 2'b01) begin
		result = src1_temp | src2_temp;
		cout = 1'b0;
	end
	else if (operation == 2'b10) begin
		result = src1_temp ^ src2_temp ^ cin;
		cout = (src1_temp & src2_temp) | (src1_temp & cin) | (src2_temp & cin);
	end
	else if (operation == 2'b11) begin
		set_less = src1_temp ^ src2_temp ^ cin;
		cout = (src1_temp & src2_temp) | (src1_temp & cin) | (src2_temp & cin);
		result = 0;
	end
	//overflow = cout;
end

endmodule
