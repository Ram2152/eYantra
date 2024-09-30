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
// CREATED		"Sat Oct  7 22:14:33 2023"

module controller_bdf(
	funct,
	opcode,
	zero_flag,
	pc_src,
	mem_wr_en,
	mem_to_reg_wr,
	reg_wr_en,
	reg_file_dst_sel,
	jump,
	alu_src_sel,
	alu_ctrl
);


input wire	zero_flag;
input wire	[5:0] funct;
input wire	[5:0] opcode;
output wire	mem_to_reg_wr;
output wire	mem_wr_en;
output wire	reg_file_dst_sel;
output wire	reg_wr_en;
output wire	pc_src;
output wire	alu_src_sel;
output wire	jump;
output wire	[2:0] alu_ctrl;

wire	branch;
wire	[1:0] SYNTHESIZED_WIRE_0;





alu_decoder	b2v_alu_dec_inst(
	.alu_op(SYNTHESIZED_WIRE_0),
	.funct(funct),
	.alu_ctrl(alu_ctrl));

assign	pc_src = zero_flag & branch;


main_decoder	b2v_main_dec_inst(
	.opcode(opcode),
	.mem_to_reg_wr(mem_to_reg_wr),
	.mem_wr_en(mem_wr_en),
	.branch(branch),
	.alu_src_sel(alu_src_sel),
	.reg_file_dst_sel(reg_file_dst_sel),
	.reg_wr_en(reg_wr_en),
	.jump(jump),
	.alu_op(SYNTHESIZED_WIRE_0));


endmodule
