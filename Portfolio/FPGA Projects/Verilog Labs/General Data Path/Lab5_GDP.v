/////////////// GCD //////////////////////////////////////////////////////

module Lab5_GDP(Sum, start, restart, clk, n, done);
	input start, clk, restart;
	input [7:0] n;
	output [7:0] Sum;
	output done;
	wire WE, RAE, RBE, OE, nEqZero, IE, AgreaterB;
	wire [1:0] WA, RAA, RBA, SH;
	wire [2:0] ALU;
	
	CU control (IE, WE, WA, RAE, RAA, RBE, RBA, ALU, SH, OE, ~start, clk, ~restart, nEqZero, AgreaterB);
	DP datapath (AgreaterB, nEqZero, Sum, n, clk, IE, WE, WA, RAE, RAA, RBE, RBA, ALU, SH, OE);
	
	assign done = OE;
endmodule

/////////////// control unit //////////////////////////////////////////////

module CU(IE, WE, WA, RAE, RAA, RBE, RBA, ALU, SH, OE, start, clk,
	restart, nEqZero, AgreaterB);
	input 		start, clk, restart;
	output 		IE, WE, RAE, RBE, OE;
	output [1:0] WA, RAA, RBA, SH;
	output [2:0] ALU;
	input wire 	nEqZero, AgreaterB;
	reg [2:0] 	state;
	reg [2:0] 	nextstate;
	
	parameter S0 = 3'b000;
	parameter S1 = 3'b001;
	parameter S2 = 3'b010;
	parameter S3 = 3'b011;
	parameter S4 = 3'b100;
	parameter S5 = 3'b101;
	
	initial
	state = S0;
	// State register
	always @ (posedge clk)
		begin
		state <= nextstate;
		end
	// NS logic
	always @ (*)
		case(state)
			S0: if(start) 			nextstate = S1;
				else 				nextstate = S0;
			S1: if (restart) 		nextstate = S0; 
				else if(start) 		nextstate = S2;
				else 				nextstate = S1;
			S2: if (nEqZero)		nextstate = S5;
				else if (AgreaterB)	nextstate = S3; 
				else 				nextstate = S4; 
			S3: 					nextstate = S2; 
			S4: 					nextstate = S2;
			S5: if (restart) 		nextstate = S0; 
				else 				nextstate = S5; 
			default: nextstate = S0;
		endcase
	// output logic
	assign IE = state == S0 || state == S1;
	assign WE = state == S0 || state == S1 || state == S3 || state == S4;
	assign WA[1] = 0;
	assign WA[0] = state == S1 || state == S4;
	assign RAE = state == S2 || state == S3 || state == S4 || state == S5;
	assign RAA[1] = 0;
	assign RAA[0] = state == S4;
	assign RBE = state == S2 || state == S3 || state == S4;
	assign RBA[1] = 0;
	assign RBA[0] = state == S2 || state == S3;
	
	assign ALU[2] = state == S3 || state == S4;
	assign ALU[1] = 0; 
	assign ALU[0] = state == S3 || state == S4;
	
	assign SH[1] = 0;
	assign SH[0] = 0;
	assign OE = state == S5;
endmodule

/////////////// data path /////////////////////////////////////////////////

module DP(AgreaterB, nEQZero, sum, nIn, clk, IE, WE, WA, RAE, RAA, RBE, RBA, ALU, SH, OE);
	input clk, IE, WE, RAE, RBE, OE;
	input [1:0] WA, RAA, RBA, SH;
	input [2:0] ALU;
	input [7:0] nIn;
	output nEQZero, AgreaterB;
	output wire [7:0] sum;
	reg [7:0] rfIn;
	wire [7:0] RFa, RFb, aluOut, shOut, n;
	reg tmp [7:0];
	
	initial
		rfIn = 0;
		
	always @ (*)
		rfIn = n;

		
	mux8 muxs (n, shOut, nIn, IE);
	Regfile RF (clk, RAA, RFa, RBA, RFb, WE, WA, rfIn, RAE, RBE);
	alu theALU (aluOut, RFa, RFb, ALU);
	shifter SHIFT (shOut, aluOut, SH);
	buff buffer1 (sum, shOut, OE);
	
	
	assign AgreaterB = (RFa > RFb); 
	assign nEQZero = (RFa == RFb); //note: checks the false //condition
	
endmodule

////////////////////////// ALU /////////////////////////////////////////////

module alu (out,a,b,sel);
    input [7:0] a,b;
    input [2:0] sel; 
    output [7:0] out;
    reg [7:0] out;

    always @ (*) 
    begin 
        case(sel) 
            3'b000: out=a;                  
            3'b001: out=a&b;                  
            3'b010: out=a|b;                  
            3'b011: out=!a;                  
            3'b100: out=a+b;                  
            3'b101: out=a-b;     
            3'b110: out=a+1;                 
            3'b111: out=a-1;                  
        endcase
    end
endmodule

/////////////////////// buffer //////////////////////////////////////////////

module buff(output reg [7:0] result, input[7:0] a, input buf1);
	always @(*)
		if(buf1 == 1)
			result = a;
		else 
			result = 8'bzzzz_zzzz;		
endmodule

////////////////////// mux /////////////////////////////////////////////////

module mux8(result, a, b, sel);

	output reg[7:0] result;
	input[7:0] a;
	input[7:0] b;
	input sel;
	
	always @(*)
		if(sel == 0)
			result = a;
		else
			result = b;
			
endmodule

/////////////////////// register file //////////////////////////////////////

module Regfile(	input 		  clk,
				input   [1:0] RAA, 		// Port A Read address 
				output  [7:0] ReadA,   	// Port A
				input   [1:0] RBA,   	// Port B Read address 
				output  [7:0] ReadB,   	// Port B
				input   	  WE,    	// Write enable 
				input   [1:0] WA,  		// Write port register address
				input   [7:0] INPUT_D,  // Write data port
				input   	  RAE,  	// Port A decoder enable
				input   	  RBE 		// Port B decoder enable
			   ); 
	// width          depth
	reg [7:0]  REG_F [0:3];

	always @(posedge clk) 
	if (WE == 1)  REG_F[WA] <= INPUT_D;
		 
	  //reading to Port A and B, combinational
	  assign ReadA = (RAE)? REG_F [RAA]:0; 
	  assign ReadB = (RBE)? REG_F [RBA]:0;
			  
	endmodule
	
////////////// shifter //////////////////////////////////////////////////////

	module shifter (out,a,sh);
		input [7:0] a;
		input [1:0] sh;
		output reg [7:0] out;

		always @ (*) 
		begin 
			case(sh) 
				3'b00: out=a;                  
				3'b01: out=a << 1;                  
				3'b10: out=a >> 1;                  
				3'b11: out={a[6],a[5],a[4],a[3],a[2],a[1],a[0], a[7]} ;
			endcase
		end
endmodule
