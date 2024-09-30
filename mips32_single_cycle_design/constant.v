
// constant.v - 32-bit constants for mips32_single_cycle_design

module constant #(parameter VALUE = 4) (
    output [31:0] out
);

assign out = VALUE;

endmodule
