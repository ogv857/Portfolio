module alu (a,b,sel, out, zero, less);
    input [15:0] a,b;
    input [2:0] sel; 
    output reg [15:0] out;
	output reg zero, less;
  
  initial
	  begin
	  out = 0;
	  less =1'b0; 
	  zero =1'b0;
	  end
    always @ (*) 
    begin 
        case(sel) 
            3'b000: 
			begin
				out=a+b;  
				if (out == 0)
					begin zero = 1; less = 0; end 
				else if (out < 0)
					begin zero = 0; less = 1; end 
				else
					begin zero = 0; less = 0; end 
			end   
			3'b001: 
			begin 
				out = a - b; 
				if (out == 0) 
					zero = 1;
				else 
					zero = 0; 
			end 
			3'b010: 
			begin 
				out = a * b; 
				if (out == 0)
					zero = 1; 
				else 
					zero = 0; 
			end 
			3'b011: 
			begin 
				out = a / b; 
				if (zero == 0)
					zero = 1; 
				else 
					zero = 0; 
			end 
			3'b100:
			begin
				out=a & b; 
				if (out == 0)
					zero = 1;  
				else
					zero = 0;
			end             
			3'b101: 
			begin
				out= a | b; 
				if (out == 0)
					zero = 1;  
				else
					zero = 0; 
			end 
			3'b110: 
			begin 
				out = a ^ b; 
				if (out == zero)
					zero = 1; 
				else 
					zero = 0; 
			end 
			3'b111: 
			begin 
				out = a ~^ b; 
				if (out == 0)
					zero = 1; 
				else 
					zero = 0; 
			end 
        endcase
    end
endmodule