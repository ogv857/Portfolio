module sl1 (input [15:0] a, output [15:0] y);
// shift left by 1
assign y = {a[12:1], 1'b0};
endmodule