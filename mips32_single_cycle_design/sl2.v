
// sl2.v - logic for shift left by 2 (multiply by 4)

module sl2 #(parameter WIDTH = 32) (
    input       [WIDTH-1:0] a,
    output      [WIDTH-1:0] y
);

assign y = { a[WIDTH-3:0], 2'b00 };

endmodule
