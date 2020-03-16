`timescale 1ns/1ps

//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    15:15:11 08/18/2013
// Design Name:
// Module Name:    alu
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

//1.set less than not yet = OK
//2.always@ begin end not yet
//3.signed / unsigned algorithsm not yet
//4.alu_32th less & overflow not yet


module alu(
           clk,           // system clock              (input)
           rst_n,         // negative reset            (input)
           src1,          // 32 bits source 1          (input)
           src2,          // 32 bits source 2          (input)
           ALU_control,   // 4 bits ALU control input  (input)
			  //bonus_control, // 3 bits bonus control input(input) 
           result,        // 32 bits result            (output)
           zero,          // 1 bit when the output is 0, zero must be set (output)
           cout,          // 1 bit carry out           (output)
           overflow       // 1 bit overflow            (output)
           );

input           clk;
input           rst_n;
input  [32-1:0] src1;
input  [32-1:0] src2;
input   [4-1:0] ALU_control;
//input   [3-1:0] bonus_control; 

output [32-1:0] result;
output          zero;
output          cout;
output          overflow;

reg    [32-1:0] result;
reg             zero;
reg             cout;
reg             overflow;

wire   [32-1:0] cout_temp;
wire   [32-1:0] result_temp;
wire	        set_less;

alu_top alu1(
               .src1(src1[0]),       //1 bit source 1 (input)
               .src2(src2[0]),       //1 bit source 2 (input)
               .less(set_less),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(ALU_control[2] ^ ALU_control[3]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[0]),     //1 bit result   (output)
               .cout(cout_temp[0])       //1 bit carry out(output)
               );

alu_top alu2(
               .src1(src1[1]),       //1 bit source 1 (input)
               .src2(src2[1]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[0]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[1]),     //1 bit result   (output)
               .cout(cout_temp[1])      //1 bit carry out(output)
               );

alu_top alu3(
               .src1(src1[2]),       //1 bit source 1 (input)
               .src2(src2[2]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[1]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[2]),     //1 bit result   (output)
               .cout(cout_temp[2])       //1 bit carry out(output)
               );

alu_top alu4(
               .src1(src1[3]),       //1 bit source 1 (input)
               .src2(src2[3]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[2]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[3]),     //1 bit result   (output)
               .cout(cout_temp[3])       //1 bit carry out(output)
               );

alu_top alu5(
               .src1(src1[4]),       //1 bit source 1 (input)
               .src2(src2[4]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[3]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[4]),     //1 bit result   (output)
               .cout(cout_temp[4])       //1 bit carry out(output)
               );

alu_top alu6(
               .src1(src1[5]),       //1 bit source 1 (input)
               .src2(src2[5]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[4]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[5]),     //1 bit result   (output)
               .cout(cout_temp[5])       //1 bit carry out(output)
               );

alu_top alu7(
               .src1(src1[6]),       //1 bit source 1 (input)
               .src2(src2[6]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[5]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[6]),     //1 bit result   (output)
               .cout(cout_temp[6])       //1 bit carry out(output)
               );

alu_top alu8(
               .src1(src1[7]),       //1 bit source 1 (input)
               .src2(src2[7]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[6]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[7]),     //1 bit result   (output)
               .cout(cout_temp[7])       //1 bit carry out(output)
               );

alu_top alu9(
               .src1(src1[8]),       //1 bit source 1 (input)
               .src2(src2[8]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[7]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[8]),     //1 bit result   (output)
               .cout(cout_temp[8])       //1 bit carry out(output)
               );

alu_top alu10(
               .src1(src1[9]),       //1 bit source 1 (input)
               .src2(src2[9]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[8]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[9]),     //1 bit result   (output)
               .cout(cout_temp[9])       //1 bit carry out(output)
               );

alu_top alu11(
               .src1(src1[10]),       //1 bit source 1 (input)
               .src2(src2[10]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[9]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[10]),     //1 bit result   (output)
               .cout(cout_temp[10])       //1 bit carry out(output)
               );

alu_top alu12(
               .src1(src1[11]),       //1 bit source 1 (input)
               .src2(src2[11]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[10]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[11]),     //1 bit result   (output)
               .cout(cout_temp[11])       //1 bit carry out(output)
               );

alu_top alu13(
               .src1(src1[12]),       //1 bit source 1 (input)
               .src2(src2[12]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[11]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[12]),     //1 bit result   (output)
               .cout(cout_temp[12])       //1 bit carry out(output)
               );

alu_top alu14(
               .src1(src1[13]),       //1 bit source 1 (input)
               .src2(src2[13]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[12]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[13]),     //1 bit result   (output)
               .cout(cout_temp[13])       //1 bit carry out(output)
               );

alu_top alu15(
               .src1(src1[14]),       //1 bit source 1 (input)
               .src2(src2[14]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[13]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[14]),     //1 bit result   (output)
               .cout(cout_temp[14])       //1 bit carry out(output)
               );

alu_top alu16(
               .src1(src1[15]),       //1 bit source 1 (input)
               .src2(src2[15]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[14]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[15]),     //1 bit result   (output)
               .cout(cout_temp[15])       //1 bit carry out(output)
               );

alu_top alu17(
               .src1(src1[16]),       //1 bit source 1 (input)
               .src2(src2[16]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[15]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[16]),     //1 bit result   (output)
               .cout(cout_temp[16])       //1 bit carry out(output)
               );

alu_top alu18(
               .src1(src1[17]),       //1 bit source 1 (input)
               .src2(src2[17]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[16]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[17]),     //1 bit result   (output)
               .cout(cout_temp[17])       //1 bit carry out(output)
               );

alu_top alu19(
               .src1(src1[18]),       //1 bit source 1 (input)
               .src2(src2[18]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[17]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[18]),     //1 bit result   (output)
               .cout(cout_temp[18])       //1 bit carry out(output)
               );

alu_top alu20(
               .src1(src1[19]),       //1 bit source 1 (input)
               .src2(src2[19]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[18]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[19]),     //1 bit result   (output)
               .cout(cout_temp[19])       //1 bit carry out(output)
               );

alu_top alu21(
               .src1(src1[20]),       //1 bit source 1 (input)
               .src2(src2[20]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[19]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[20]),     //1 bit result   (output)
               .cout(cout_temp[20])       //1 bit carry out(output)
               );

alu_top alu22(
               .src1(src1[21]),       //1 bit source 1 (input)
               .src2(src2[21]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[20]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[21]),     //1 bit result   (output)
               .cout(cout_temp[21])       //1 bit carry out(output)
               );

alu_top alu23(
               .src1(src1[22]),       //1 bit source 1 (input)
               .src2(src2[22]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[21]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[22]),     //1 bit result   (output)
               .cout(cout_temp[22])       //1 bit carry out(output)
               );

alu_top alu24(
               .src1(src1[23]),       //1 bit source 1 (input)
               .src2(src2[23]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[22]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[23]),     //1 bit result   (output)
               .cout(cout_temp[23])       //1 bit carry out(output)
               );

alu_top alu25(
               .src1(src1[24]),       //1 bit source 1 (input)
               .src2(src2[24]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[23]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[24]),     //1 bit result   (output)
               .cout(cout_temp[24])       //1 bit carry out(output)
               );

alu_top alu26(
               .src1(src1[25]),       //1 bit source 1 (input)
               .src2(src2[25]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[24]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[25]),     //1 bit result   (output)
               .cout(cout_temp[25])       //1 bit carry out(output)
               );

alu_top alu27(
               .src1(src1[26]),       //1 bit source 1 (input)
               .src2(src2[26]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[25]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[26]),     //1 bit result   (output)
               .cout(cout_temp[26])       //1 bit carry out(output)
               );

alu_top alu28(
               .src1(src1[27]),       //1 bit source 1 (input)
               .src2(src2[27]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[26]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[27]),     //1 bit result   (output)
               .cout(cout_temp[27])       //1 bit carry out(output)
               );

alu_top alu29(
               .src1(src1[28]),       //1 bit source 1 (input)
               .src2(src2[28]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[27]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[28]),     //1 bit result   (output)
               .cout(cout_temp[28])       //1 bit carry out(output)
               );

alu_top alu30(
               .src1(src1[29]),       //1 bit source 1 (input)
               .src2(src2[29]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[28]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[29]),     //1 bit result   (output)
               .cout(cout_temp[29])       //1 bit carry out(output)
               );

alu_top alu31(
               .src1(src1[30]),       //1 bit source 1 (input)
               .src2(src2[30]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[29]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[30]),     //1 bit result   (output)
               .cout(cout_temp[30])       //1 bit carry out(output)
               );

alu_32th alu32(
               .src1(src1[31]),       //1 bit source 1 (input)
               .src2(src2[31]),       //1 bit source 2 (input)
               .less(1'b0),       //1 bit less     (input)
               .A_invert(ALU_control[3]),   //1 bit A_invert (input)
               .B_invert(ALU_control[2]),   //1 bit B_invert (input)
               .cin(cout_temp[30]),        //1 bit carry in (input)
               .operation(ALU_control[1:0]),  //operation      (input)
               .result(result_temp[31]),     //1 bit result   (output)
               .cout(cout_temp[31]),       //1 bit carry out(output)
	       .set_less(set_less)
	       //.overflow(overflow)
               );

integer i;
always@( posedge clk or negedge rst_n ) 
begin
	if(!rst_n) begin

	end
	else begin
		overflow = cout_temp[31] ^ cout_temp[30];
		result = result_temp;
		if (cout_temp[31]) begin 
			cout = 1;
		end
		else begin
			cout = 0;
		end

		/*for (i = 0; i < 32; i = i+1) begin
			if (result[i] != 0) begin
				zero <= 1;
				disable loop;
			end
			else begin
				zero <= 0;
			end
		end*/
		if (result == 0) zero <= 1;
		else zero <= 0;
	end
end

endmodule
