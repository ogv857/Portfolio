module maindec (input [2:0] op, input select, output memtoreg, memwrite, output branch, alusrc,
output regdst, regwrite, output jump, output [1:0] aluop);
reg [8:0] controls;

assign {regwrite, regdst, alusrc, branch, memwrite, memtoreg, jump, aluop}  = controls;
always @ (* )
 case(op)
3'b000 :  controls <= 9'b000000000; 							//pass through 
3'b001 :  controls <= 9'b110000011; 							//Rtype
3'b010 :  controls <= 9'b101000000; 							//ADDI
3'b011 :  controls <= 9'b101000001; 							//SUBI
3'b100 :  controls <= select ? 9'b101001000 : 9'b001010000; 	//LW  or SW
3'b101 :  controls <= 9'b000100001; 							//BEQ or BLT
3'b110 :  controls <= select ? 9'b110000100 : 9'b000000100; 	//JAL or JR
3'b111 :  controls <= 9'b000000100; 							//J
default:  controls <= 9'bXXXXXXXXX; 							//???
endcase
endmodule



