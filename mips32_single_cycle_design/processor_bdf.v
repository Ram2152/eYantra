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
// CREATED		"Sat Oct  7 23:50:06 2023"

module processor_bdf(
	clk,
	rst,
	instr,
	rd_data_mem,
	mem_wr_en,
	alu_result,
	mem_wr_data,
	pc
);


input wire	clk;
input wire	rst;
input wire	[31:0] instr;
input wire	[31:0] rd_data_mem;
output wire	mem_wr_en;
output wire	[31:0] alu_result;
output wire	[31:0] mem_wr_data;
output wire	[31:0] pc;

wire	[2:0] alu_ctrl;
wire	alu_src_sel;
wire	jump;
wire	mem_to_reg_wr;
wire	pc_src;
wire	reg_wr_dst_sel;
wire	reg_wr_en;
wire	zero_flag;





controller_bdf	b2v_ctrl_bdf_inst(
	.zero_flag(zero_flag),
	.funct(instr[5:0]),
	.opcode(instr[31:26]),
	.pc_src(pc_src),
	.mem_wr_en(mem_wr_en),
	.mem_to_reg_wr(mem_to_reg_wr),
	.reg_wr_en(reg_wr_en),
	.reg_file_dst_sel(reg_wr_dst_sel),
	.jump(jump),
	.alu_src_sel(alu_src_sel),
	.alu_ctrl(alu_ctrl));


datapath_bdf	b2v_dpath_bdf_inst(
	.clk(clk),
	.rst(rst),
	.pc_src(pc_src),
	.mem_to_reg_wr(mem_to_reg_wr),
	.reg_wr_en(reg_wr_en),
	.reg_file_dst_sel(reg_wr_dst_sel),
	.alu_src_sel(alu_src_sel),
	.jump(jump),
	.alu_ctrl(alu_ctrl),
	.instr(instr),
	.rd_data_mem(rd_data_mem),
	.zero_flag(zero_flag),
	.alu_result(alu_result),
	.pc(pc),
	.reg_file_rd_data2(mem_wr_data));


endmodule
