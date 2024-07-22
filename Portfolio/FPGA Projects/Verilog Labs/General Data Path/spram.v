module spram(clk, data, opd, writeaddr, WE);
input clk;
input WE;					//Write Enable
input [3:0]writeaddr;
input [7:0]data;	
output wire [7:0]opd;

reg [7:0]ram[0:15];		//8 Bits of data width, 16 address locations


always @(posedge clk)
	begin
	if(WE == 1)
		ram[writeaddr] <= data; 	
	end


assign opd = ram[writeaddr];		//Continuous assignment

endmodule