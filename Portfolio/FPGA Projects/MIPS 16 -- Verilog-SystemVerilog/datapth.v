module datapath (input clk, reset,
	input memtoreg, pcsrc,
	input alusrc, regdst,
	input regwrite, jump, branch, 
	input [2:0] alucontrol,
	output zero, less,
	output [15:0] pc, 
	input [15:0] instr,
	output [15:0] aluout, writedata,
	input [15:0] readdata);

wire [2:0] writereg;		//Write to register
wire [15:0] pcnext, pcnextbr, pcplus2, pcbranch;
wire [15:0] signimm, signimmsh;
wire [15:0] srca, srcb;
wire [15:0] result;

// next PC logic
flopr #(16) pcreg(clk, reset, pcnext, pc);	//16 bit PC
adder pcadd1 (pc, 16'b10, pcplus2);	//PC + 2
sl1 immsh(signimm, signimmsh); 	//Jump address
adder pcadd2(pcplus2, signimmsh, pcbranch);	//Sign extend PC
mux2 #(16) pcbrmux(pcplus2, pcbranch, pcsrc, pcnextbr);

//15:14 is the adder of PC+2 added onto the PC shifted with the instruction PC shifted to the left
mux2 #(16) pcmux(pcnextbr, {pcplus2[15:13], instr[12:1], 1'b0},jump, pcnext);

// register file logic
regfile rf(clk, regwrite, 
	instr[12:10], 	// destination register 
	instr[9:7], 	// source register 
	writereg, 		// destination to register file 
	result, srca, writedata);
	
	
mux2 #(3) wrmux(instr[9:7], instr[2:0],regdst, writereg); // stores desired register into register destination R-type
mux2 #(16) resmux(aluout, readdata, memtoreg, result);	// result mux 
signext se(instr[6:0], signimm);	// sign extends immediate value 

// ALU logic
mux2 #(16) srcbmux(writedata, signimm, alusrc, srcb);
alu alu(srca, srcb, alucontrol, aluout, zero, less);
endmodule