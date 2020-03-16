//Subject:     CO project 2 - Simple Single CPU
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
module Simple_Single_CPU(
        clk_i,
		rst_i
		);
		
//I/O port
input         clk_i;
input         rst_i;

//Internal Signles
wire [32-1:0]pc_out;
//wire [32-1:0]pc_in;
wire [32-1:0]add1_out;
wire [32-1:0]add2_out;
wire [32-1:0]instr_memory_out;
wire [32-1:0]sign_ext_out;
wire [32-1:0]shift_two_out;
wire [4-1:0]alu_ctrl_out;
wire [32-1:0]alu_result;
wire alu_zero;
wire [32-1:0]mux_pc_src;
wire reg_dst;
wire [5-1:0]mux_reg_src;
wire reg_write;
wire [3-1:0]alu_op;
wire alu_src;
wire branch;
wire [32-1:0]reg_read_data1;
wire [32-1:0]reg_read_data2;
wire [32-1:0]mux_alu_src;

//Greate componentes
ProgramCounter PC(
        .clk_i(clk_i),      
	    .rst_i (rst_i),     
	    .pc_in_i(mux_pc_src) ,   
	    .pc_out_o(pc_out) 
	    );
	
Adder Adder1(
        .src1_i(32'd4),     
	    .src2_i(pc_out),     
	    .sum_o(add1_out)    
	    );
	
Instr_Memory IM(
        .pc_addr_i(pc_out),  
	    .instr_o(instr_memory_out)    
	    );

MUX_2to1 #(.size(5)) Mux_Write_Reg(
        .data0_i(instr_memory_out[20:16]), //I-type
        .data1_i(instr_memory_out[15:11]), //R-type
        .select_i(reg_dst),
        .data_o(mux_reg_src)
        );	
		
Reg_File RF(
        .clk_i(clk_i),      
	    .rst_i(rst_i) ,     
        .RSaddr_i(instr_memory_out[25:21]) , 
        .RTaddr_i(instr_memory_out[20:16]) ,  
        .RDaddr_i(mux_reg_src) ,  
        .RDdata_i(alu_result)  , 
        .RegWrite_i (reg_write),
        .RSdata_o(reg_read_data1) ,  
        .RTdata_o(reg_read_data2)   
        );
	
Decoder Decoder(
        .instr_op_i(instr_memory_out[31:26]), 
	    .RegWrite_o(reg_write), 
	    .ALU_op_o(alu_op),   
	    .ALUSrc_o(alu_src),   
	    .RegDst_o(reg_dst),   
		.Branch_o(branch)   
	    );

ALU_Ctrl AC(
        .funct_i(instr_memory_out[5:0]),   
        .ALUOp_i(alu_op),   
        .ALUCtrl_o(alu_ctrl_out) 
        );
	
Sign_Extend SE(
        .data_i(instr_memory_out[15:0]),
        .data_o(sign_ext_out)
        );

MUX_2to1 #(.size(32)) Mux_ALUSrc(
        .data0_i(reg_read_data2),
        .data1_i(sign_ext_out),
        .select_i(alu_src),
        .data_o(mux_alu_src)
        );	
		
ALU ALU(
        .src1_i(reg_read_data1),
	    .src2_i(mux_alu_src),
	    .ctrl_i(alu_ctrl_out),
	    .result_o(alu_result),
		.zero_o(alu_zero)
	    );
		
Adder Adder2(
        .src1_i(add1_out),     
	    .src2_i(shift_two_out),     
	    .sum_o(add2_out)      
	    );
		
Shift_Left_Two_32 Shifter(
        .data_i(sign_ext_out),
        .data_o(shift_two_out)
        ); 		
		
MUX_2to1 #(.size(32)) Mux_PC_Source(
        .data0_i(add1_out),
        .data1_i(add2_out),
        .select_i(branch & alu_zero),
        .data_o(mux_pc_src)
        );	

endmodule
		  


