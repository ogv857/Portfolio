module RAM #(parameter m = 2, parameter n = 2 , parameter r = 8)(CS, WE, OE, ADDR, DATA);
input logic CS;
input logic WE;
input logic OE;
input logic [r+m-1:0] ADDR;
inout logic [n-1:0] DATA;


//n wide, 2^ entries, 2^m combinations
reg[n-1:0] RAM1[0:2**(r+m)-1];    //Width RAM1 (2^(r+m)) - 1

assign DATA = (CS == 1'b1 | WE == 1'b0 | OE == 1'b1)? 8'bZZZZZZZZ : RAM1[ADDR]; //read from RAM

always @(negedge WE)  
begin
    if(CS == 1'b0) begin
	RAM1[ADDR] <= DATA;
      end
end
endmodule
