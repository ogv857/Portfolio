module aludec (input [3:0] funct,
input [1:0] aluop,
output reg [2:0] alucontrol);
always @ (*)

case (aluop)
2'b00: alucontrol <= 3'b000; // add
2'b01: alucontrol <= 3'b001; // sub
default: case(funct) // RTYPE
4'b0000: alucontrol <= 3'b000; // ADD
4'b0001: alucontrol <= 3'b001; // SUB
4'b0010: alucontrol <= 3'b010; // MUL
4'b0011: alucontrol <= 3'b011; // DIV
4'b0100: alucontrol <= 3'b100; // AND
4'b0101: alucontrol <= 3'b101; // OR 
4'b0110: alucontrol <= 3'b110; // XOR
4'b0111: alucontrol <= 3'b111; // XNOR 
default: alucontrol <= 3'bxxx; // ???
endcase
endcase
endmodule