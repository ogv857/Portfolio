//-------------------------------------------------------------
// toppipelined.sv
// David_Harris@hmc.edu & Sarah_Harris@hmc.edu, copyright 2012
// Top level system including MIPS pipelined
// processor and external data and instruction
// memories
//-------------------------------------------------------------

module top(input  logic         clk, reset, 
           output logic [31:0]  writedata, dataadr,
			  //output logic [6:0]   outw1,outw2,outw3,outw4,outw5,outw6,outw7,outw8,
			  //output logic [6:0]   outadr1,outadr2,outadr3,outadr4,outadr5,outadr6,outadr7,outadr8,
           output logic         memwrite);

  logic [31:0] pc, instr, readdata;
//  logic [31:0] writedata, dataadr;
  
  // instantiate processor and memories
  mips mips(clk, reset, pc, instr, memwrite, dataadr, writedata, readdata);
  imem imem(pc[7:2], instr);
  dmem dmem(clk, memwrite, dataadr, writedata, readdata);
  // transfer to hex for FPGA 7-segment display
  //hexdigit(pc[3:0],outw1);
  //hexdigit(pc[7:4],outw2);
  //hexdigit(pc[11:8],outw3);
  //hexdigit(pc[15:12],outw4);
  //hexdigit(pc[19:16],outw5);
  //hexdigit(pc[23:20],outw6);
  //hexdigit(pc[27:24],outw7);
  //hexdigit(pc[31:28],outw8);
  
  //hexdigit(instr[3:0],outadr1);
  //hexdigit(instr[7:4],outadr2);
  //hexdigit(instr[11:8],outadr3);
  //hexdigit(instr[15:12],outadr4);
  //hexdigit(instr[19:16],outadr5);
  //hexdigit(instr[23:20],outadr6);
  //hexdigit(instr[27:24],outadr7);
  //hexdigit(instr[31:28],outadr8);

endmodule

module dmem(input  logic        clk, we,
            input  logic [31:0] a, wd,
            output logic [31:0] rd);

  reg  [31:0] RAM[511:0];

  assign rd = RAM[a[31:2]]; // word aligned

  always @(posedge clk)
    if (we)
      RAM[a[31:2]] <= wd;
endmodule


module imem(input  logic [5:0]  a,
            output logic [31:0] rd);

  logic  [31:0] RAM[255:0];

  initial
    begin
      $readmemh("matrixmem.dat",RAM);
    end

  assign rd = RAM[a]; // word aligned
endmodule
module hexdigit(input logic [3:0] in,
					 output logic [6:0] out);
					 
	always_comb		
		case(in)
			4'b0000 : out = 7'b0000001;
			4'b0001 : out = 7'b1001111;
			4'b0010 : out = 7'b0010001;
			4'b0011 : out = 7'b0000110;
			4'b0100 : out = 7'b1001100;
			4'b0101 : out = 7'b0100100;
			4'b0110 : out = 7'b0100000;
			4'b0111 : out = 7'b0001111;
			4'b1000 : out = 7'b0000000;
			4'b1001 : out = 7'b0001100;
			4'b1010 : out = 7'b0001000;
			4'b1011 : out = 7'b1100000;
			4'b1100 : out = 7'b0110001;
			4'b1101 : out = 7'b1000010;
			4'b1110 : out = 7'b0110000;
			4'b1111 : out = 7'b0111000;
		endcase

		
endmodule
