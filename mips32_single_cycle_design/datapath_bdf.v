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
// CREATED		"Sat Oct  7 23:36:56 2023"

module datapath_bdf(
	clk,
	rst,
	pc_src,
	pc,
	mem_to_reg_wr,
	reg_wr_en,
	reg_file_dst_sel,
	alu_src_sel,
	alu_ctrl,
	alu_result,
	zero_flag,
	reg_file_rd_data2,
	rd_data_mem,
	instr,
	jump
);


input wire	mem_to_reg_wr;
input wire	clk;
input wire	rst;
input wire	reg_wr_en;
input wire	alu_src_sel;
input wire	reg_file_dst_sel;
input wire	pc_src;
input wire	jump;
input wire	[2:0] alu_ctrl;
input wire	[31:0] instr;
input wire	[31:0] rd_data_mem;
output wire	zero_flag;
output wire	[31:0] alu_result;
output wire	[31:0] pc;
output wire	[31:0] reg_file_rd_data2;

wire	[31:0] alu_result_ALTERA_SYNTHESIZED;
wire	[31:0] alu_src_b;
wire	[31:0] pc_ALTERA_SYNTHESIZED;
wire	[31:0] pc_branch;
wire	[31:0] pc_next;
wire	[31:0] pc_next_br;
wire	[31:0] pc_plus_4;
wire	[31:0] reg_file_rd_data1;
wire	[31:0] reg_file_rd_data_ALTERA_SYNTHESIZED2;
wire	[4:0] reg_file_wr_addr;
wire	[31:0] reg_file_wr_data;
wire	[31:0] sign_imm_ext;
wire	[27:0] sl2_jtgt_addr;
wire	[31:0] SYNTHESIZED_WIRE_0;
wire	[31:0] SYNTHESIZED_WIRE_1;

wire	[31:0] GDFX_TEMP_SIGNAL_0;


assign	GDFX_TEMP_SIGNAL_0 = {pc_plus_4[31:28],sl2_jtgt_addr[27:0]};


alu	b2v_alu_inst(
	.a(reg_file_rd_data1),
	.alu_ctrl(alu_ctrl),
	.b(alu_src_b),
	.zero(zero_flag),
	.alu_out(alu_result_ALTERA_SYNTHESIZED));
	defparam	b2v_alu_inst.WIDTH = 32;


mux2	b2v_alu_src_mux_inst(
	.sel(alu_src_sel),
	.d0(reg_file_rd_data_ALTERA_SYNTHESIZED2),
	.d1(sign_imm_ext),
	.y(alu_src_b));
	defparam	b2v_alu_src_mux_inst.WIDTH = 32;


constant	b2v_const_inst(
	.out(SYNTHESIZED_WIRE_1));
	defparam	b2v_const_inst.VALUE = 4;


sign_ext	b2v_imm_sign_ext_inst(
	.a(instr[15:0]),
	.y(sign_imm_ext));
	defparam	b2v_imm_sign_ext_inst.IN_WIDTH = 16;
	defparam	b2v_imm_sign_ext_inst.OUT_WIDTH = 32;


sl2	b2v_jump_tgt_addr_sl2_inst(
	.a(instr[27:0]),
	.y(sl2_jtgt_addr));
	defparam	b2v_jump_tgt_addr_sl2_inst.WIDTH = 28;


adder	b2v_pc_branch_adder_inst(
	.a(SYNTHESIZED_WIRE_0),
	.b(pc_plus_4),
	.sum(pc_branch));
	defparam	b2v_pc_branch_adder_inst.WIDTH = 32;


adder	b2v_pc_incr_inst(
	.a(pc_ALTERA_SYNTHESIZED),
	.b(SYNTHESIZED_WIRE_1),
	.sum(pc_plus_4));
	defparam	b2v_pc_incr_inst.WIDTH = 32;


mux2	b2v_pc_next_br_jump_mux_inst(
	.sel(jump),
	.d0(pc_next_br),
	.d1(GDFX_TEMP_SIGNAL_0),
	.y(pc_next));
	defparam	b2v_pc_next_br_jump_mux_inst.WIDTH = 32;


mux2	b2v_pc_next_br_mux2_inst(
	.sel(pc_src),
	.d0(pc_plus_4),
	.d1(pc_branch),
	.y(pc_next_br));
	defparam	b2v_pc_next_br_mux2_inst.WIDTH = 32;


reset_ff	b2v_pc_reg_inst(
	.clk(clk),
	.rst(rst),
	.d(pc_next),
	.q(pc_ALTERA_SYNTHESIZED));
	defparam	b2v_pc_reg_inst.WIDTH = 32;


reg_file	b2v_reg_file_inst(
	.clk(clk),
	.wr_en(reg_wr_en),
	.rd_addr1(instr[25:21]),
	.rd_addr2(instr[20:16]),
	.wr_addr(reg_file_wr_addr),
	.wr_data(reg_file_wr_data),
	.rd_data1(reg_file_rd_data1),
	.rd_data2(reg_file_rd_data_ALTERA_SYNTHESIZED2));
	defparam	b2v_reg_file_inst.DATA_WIDTH = 32;


mux2	b2v_reg_file_wr_addr_mux_inst(
	.sel(reg_file_dst_sel),
	.d0(instr[20:16]),
	.d1(instr[15:11]),
	.y(reg_file_wr_addr));
	defparam	b2v_reg_file_wr_addr_mux_inst.WIDTH = 5;


mux2	b2v_reg_file_wr_data_mux_inst(
	.sel(mem_to_reg_wr),
	.d0(alu_result_ALTERA_SYNTHESIZED),
	.d1(rd_data_mem),
	.y(reg_file_wr_data));
	defparam	b2v_reg_file_wr_data_mux_inst.WIDTH = 32;


sl2	b2v_sign_imm_ext_sl2_inst(
	.a(sign_imm_ext),
	.y(SYNTHESIZED_WIRE_0));
	defparam	b2v_sign_imm_ext_sl2_inst.WIDTH = 32;

assign	alu_result = alu_result_ALTERA_SYNTHESIZED;
assign	pc = pc_ALTERA_SYNTHESIZED;
assign	reg_file_rd_data2 = reg_file_rd_data_ALTERA_SYNTHESIZED2;

endmodule
