
// data_mem.v - data memory for single-cycle MIPS32 CPU

module data_mem #(parameter DATA_WIDTH = 32, ADDR_WIDTH = 32, MEM_SIZE = 64) (
    input       clk, wr_en,
    input       [ADDR_WIDTH-1:0] wr_addr,
    input       [DATA_WIDTH-1:0] wr_data,
    output      [DATA_WIDTH-1:0] rd_data_mem
);

// array of 64 32-bit words or data
reg [DATA_WIDTH-1:0] data_ram [0:MEM_SIZE-1];

// word-aligned memory access
// combinational read logic
assign rd_data_mem = data_ram[wr_addr[DATA_WIDTH-1:2]];

// synchronous write logic
always @(posedge clk) begin
    if (wr_en) data_ram[wr_addr[DATA_WIDTH-1:2]] <= wr_data;
end

endmodule
