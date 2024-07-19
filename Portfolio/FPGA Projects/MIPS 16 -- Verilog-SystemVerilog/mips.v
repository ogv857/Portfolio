module mips (input clk, reset,
	output [15:0] pc,
	input [15:0] instr,
	output memwrite,
	output [15:0] aluout, writedata,
	input [15:0] readdata);
	
	wire memtoreg, branch, alusrc, regdst, regwrite, jump;
	wire [2:0] alucontrol;
	
	//instr 15:13 opcode
	//instr 6:3 function
	//instr 0 select
	controller c(instr[15:13], instr[6:3], instr[0], zero,memtoreg, memwrite, pcsrc,
	alusrc, regdst, regwrite, jump, branch, alucontrol);
	
	datapath dp(clk, reset, memtoreg, pcsrc,
	alusrc, regdst, regwrite, jump, branch, 
	alucontrol,zero, less, pc, instr,
	aluout, writedata, readdata);
	
	//assign branchType =  
endmodule