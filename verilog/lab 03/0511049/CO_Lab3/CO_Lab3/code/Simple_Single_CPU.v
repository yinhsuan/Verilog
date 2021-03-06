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
wire [32-1:0]add1_out;
wire [32-1:0]add2_out;
wire [32-1:0]instr_memory_out;
wire [32-1:0]sign_ext_out;
wire [32-1:0]shift_two_out;
wire [4-1:0]alu_ctrl_out;
wire [32-1:0]alu_result;
wire alu_zero;
wire [32-1:0]mux_pc_src;
wire [2-1:0]reg_dst;
wire [5-1:0]mux_reg_src;
wire reg_write;
wire [3-1:0]alu_op;
wire alu_src;
wire branch;
wire [32-1:0]reg_read_data1;
wire [32-1:0]reg_read_data2;
wire [32-1:0]mux_alu_src;
wire [32-1:0]mux_write_data_src;
wire [32-1:0]data_mem_read_data;
wire [2-1:0] mem_to_reg;
wire [2-1:0] jump;
wire   mem_read;
wire   mem_write;
wire [32-1:0]mux_add_out;
wire [32-1:0]jump_addr_o;
//wire read_reg1;
//wire [5-1:0]read_reg1_o;

assign jump_addr_o[1:0] = 2'b00;
assign jump_addr_o[27:2] = instr_memory_out[25:0];
assign jump_addr_o[31:28] = add1_out[31:28];

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

MUX_3to1 #(.size(5)) Mux_Write_Reg(
	.data0_i(instr_memory_out[20:16]), //I-type
        .data1_i(instr_memory_out[15:11]), //R-type
	.data2_i(5'd31), //jal
        .select_i(reg_dst),
        .data_o(mux_reg_src)
        );	

//MUX_2to1 #(.size(5)) Mux_READ_REG1(
//        .data0_i(instr_memory_out[25:21]),
//        .data1_i(5'd31),
//        .select_i(read_reg1),
//        .data_o(read_reg1_o)
//        );	
		
Reg_File Registers(
        .clk_i(clk_i),      
	.rst_i(rst_i) ,     
        .RSaddr_i(instr_memory_out[25:21]) , 
        .RTaddr_i(instr_memory_out[20:16]) ,  
        .RDaddr_i(mux_reg_src),  
	.RDdata_i(mux_write_data_src),
        .RegWrite_i(reg_write),
        .RSdata_o(reg_read_data1) ,  
        .RTdata_o(reg_read_data2) 
        );
	
Decoder Decoder(
        .instr_op_i(instr_memory_out[31:26]), 
	.instr_func_i(instr_memory_out[5:0]),   
	.RegWrite_o(reg_write), 
	.ALU_op_o(alu_op),   
	.ALUSrc_o(alu_src),   
	.RegDst_o(reg_dst),   
	.Branch_o(branch),
	.MemToReg_o(mem_to_reg),
	.Jump_o(jump),
	.MemRead_o(mem_read),
	.MemWrite_o(mem_write)
	//.ReadReg_o(read_reg1)
	//.pc_out_i(pc_out),
	//.pc_in_o(mux_pc_src)
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
	.zero_o(alu_zero),
	.RS_i(reg_read_data1),
	.imm_i(instr_memory_out[15:0]),
	.instr_mem_i(add1_out)
	    );
	
Data_Memory Data_Memory(
	.clk_i(clk_i),
	.addr_i(alu_result),
	.data_i(reg_read_data2),
	.MemRead_i(mem_read),
	.MemWrite_i(mem_write),
	.data_o(data_mem_read_data)
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
		

MUX_2to1 #(.size(32)) Mux_ADD(
        .data0_i(add1_out),
        .data1_i(add2_out),
        .select_i(branch & alu_zero),
        .data_o(mux_add_out)
        );	
	
//MUX_2to1 #(.size(32)) Mux_PC_Source(
//        .data0_i(jump_addr_o),
//        .data1_i(mux_add_out),
//        .select_i(jump),
//        .data_o(mux_pc_src)
//        );	

MUX_3to1 #(.size(32)) Mux_PC_Source(
        .data0_i(jump_addr_o),
        .data1_i(mux_add_out),
	.data2_i(reg_read_data1), 
        .select_i(jump),
        .data_o(mux_pc_src)
        );	

//MUX_2to1 #(.size(32)) Mux_WriteData(
//        .data0_i(alu_result),
//        .data1_i(data_mem_read_data),
//        .select_i(mem_to_reg),
//        .data_o(mux_write_data_src)
//        );	

MUX_3to1 #(.size(32)) Mux_WriteData(
                .data0_i(alu_result),
                .data1_i(data_mem_read_data),
                .data2_i(sign_ext_out),
//		.data2_i(pc_out),
                .select_i(mem_to_reg),
                .data_o(mux_write_data_src)
                );  

endmodule
		  


