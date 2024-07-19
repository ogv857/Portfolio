module imem (input [2:0] a, output [15:0] rd);
reg [15:0] RAM[17:0]; // limited memory, 18 instructions
initial
begin
$readmemh ("memfile.dat",RAM);
end
assign rd = RAM[a]; // word aligned
endmodule
