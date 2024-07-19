module dandimem (input clk, we,	//write enable and read enable
input [5:0] b,		//address
input [15:0] a, wd,
output [15:0] ird); 

//output [31:0] drd);	//Readdata

reg [15:0] DRAM[63:0];		//64 Data addresses
reg [15:0] IRAM[17:0];		//18 Instructions

//Imem
initial
begin
	$readmemh ("memfile.dat",IRAM);
end

assign ird = IRAM[b]; // word aligned
assign drd = DRAM[a[15:2]]; // word aligned


always @ (posedge clk)
if (we)
DRAM[a[15:2]] <= wd;


endmodule