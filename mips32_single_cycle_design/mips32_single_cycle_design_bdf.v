// Copyright (C) 2019  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions
// and other software and tools, and any partner logic
// functions, and any output files from any of the foregoing
// (including device programming or simulation files), and any
// associated documentation or information are expressly subject
// to the terms and conditions of the Intel Program License
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details, at
// https://fpgasoftware.intel.com/eula.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 19.1.0 Build 670 09/22/2019 SJ Lite Edition"
// CREATED		"Sun Oct  8 09:20:19 2023"

module mips32_single_cycle_design_bdf(
	clk,
	rst,
	mem_wr_en,
	mem_wr_addr,
	mem_wr_data,
	pc,
	instr
);


input wire	clk;
input wire	rst;
output wire	mem_wr_en;
output wire	[31:0] instr;
output wire	[31:0] mem_wr_addr;
output wire	[31:0] mem_wr_data;
output wire	[31:0] pc;

wire	[31:0] instr_ALTERA_SYNTHESIZED;
wire	[31:0] mem_wr_addr_ALTERA_SYNTHESIZED;
wire	[31:0] mem_wr_data_ALTERA_SYNTHESIZED;
wire	mem_wr_en_ALTERA_SYNTHESIZED;
wire	[31:0] pc_ALTERA_SYNTHESIZED;
wire	[31:0] rd_data_mem;





data_mem	b2v_dmem_inst(
	.clk(clk),
	.wr_en(mem_wr_en_ALTERA_SYNTHESIZED),
	.wr_addr(mem_wr_addr_ALTERA_SYNTHESIZED),
	.wr_data(mem_wr_data_ALTERA_SYNTHESIZED),
	.rd_data_mem(rd_data_mem));
	defparam	b2v_dmem_inst.ADDR_WIDTH = 32;
	defparam	b2v_dmem_inst.DATA_WIDTH = 32;
	defparam	b2v_dmem_inst.MEM_SIZE = 64;


instr_mem	b2v_imem_inst(
	.instr_addr(pc_ALTERA_SYNTHESIZED[7:2]),
	.instr(instr_ALTERA_SYNTHESIZED));
	defparam	b2v_imem_inst.ADDR_WIDTH = 6;
	defparam	b2v_imem_inst.DATA_WIDTH = 32;
	defparam	b2v_imem_inst.MEM_SIZE = 64;


processor_bdf	b2v_processor_bdf_inst(
	.clk(clk),
	.rst(rst),
	.instr(instr_ALTERA_SYNTHESIZED),
	.rd_data_mem(rd_data_mem),
	.mem_wr_en(mem_wr_en_ALTERA_SYNTHESIZED),
	.alu_result(mem_wr_addr_ALTERA_SYNTHESIZED),
	.mem_wr_data(mem_wr_data_ALTERA_SYNTHESIZED),
	.pc(pc_ALTERA_SYNTHESIZED));

assign	mem_wr_en = mem_wr_en_ALTERA_SYNTHESIZED;
assign	instr = instr_ALTERA_SYNTHESIZED;
assign	mem_wr_addr = mem_wr_addr_ALTERA_SYNTHESIZED;
assign	mem_wr_data = mem_wr_data_ALTERA_SYNTHESIZED;
assign	pc = pc_ALTERA_SYNTHESIZED;

endmodule
