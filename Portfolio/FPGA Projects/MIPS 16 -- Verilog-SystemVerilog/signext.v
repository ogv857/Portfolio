module signext (input [6:0] a,
output [15:0] y);
assign y = {{9{a[6]}}, a};
endmodule