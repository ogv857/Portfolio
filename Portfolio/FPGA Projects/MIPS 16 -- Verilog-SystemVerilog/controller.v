module controller (input [2:0] op, input [3:0] funct, input select,
	input zero,
	output memtoreg, memwrite,
	output pcsrc, alusrc,
	output regdst, regwrite,
	output jump, branch, 
	output [2:0] alucontrol);
	
	wire [1:0] aluop;
	
	maindec md(op,select, memtoreg, memwrite, branch,
	alusrc, regdst, regwrite, jump, aluop);
	
	aludec ad (funct, aluop, alucontrol);
	
	assign pcsrc = branch & zero;

endmodule