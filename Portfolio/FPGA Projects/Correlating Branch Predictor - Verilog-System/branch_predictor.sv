module Correlating_Branch #(parameter m = 2, parameter n = 2 , parameter r = 8)(PC, Target, Result, Clk, Branch);
input logic [31:0]	PC;
input logic [31:0]	Target;
input logic Result;	
input logic Clk;
output logic Branch;



//Taken or Not Taken Branch variable
const int NDIV = n/2;

//Global history
logic [m-1:0] m_bit;	//Sets the branches to zero
int m_count = 0;
int minus_one = 0;
int branch_count=0;

//# of Entries
logic comb_branch;							//Combinational signal for branch logic	           
logic [r-1:0]PCindex;    //The modulus of the PC




//Signals for RAM
logic OE, WE, CS;
logic [r+m-1:0] RAM_ADDR;

reg [n-1:0]temp_bit;
//State logic(tristate logic)
reg [n-1:0]n_bit; 

wire [n-1:0]data;
wire [n-1:0]receive;

//instantiate RAM
RAM #(m,n,r)R(CS, WE, OE, RAM_ADDR, data);

//RAM inout assignments
assign data = (!WE) ? n_bit : 8'hZZ;
assign receive = data;


always @(posedge Clk) begin
	PCindex = PC[r-1:0];		//The masked address of how many entries there are
	m_count = 0;
	//Enable Read State
	WE = 1'b1;
	OE = 1'b0;
	CS = 1'b0;
	
	
	//Check global correlating branches
	if(m == 0)begin                  //Used to test the 0 case of m = 0
	RAM_ADDR = PCindex;
		end	
	else begin
	RAM_ADDR = {PCindex,m_bit};      //Concatenate the address
	end	
end	


assign Branch = comb_branch;	//Continuous Assignment	 

always @(negedge Clk) begin
	if(m == 0)begin

		//Initialize local state
		if(receive === 'x) //Need === for case-equality
		  n_bit = 2'b00;
		else   
		  n_bit = receive;    //Otherwise n_bit gets the value from RAM
		  	
		 	  
		if(n_bit<NDIV)	begin			//Less than half of the state logic 
			comb_branch = 0;		
		end
		else begin
			comb_branch = 1;
			
		end
		 
		if(Branch == Result)
		  if(n_bit != 2'b11)
			  n_bit++;//Decrement n_bit state
		else begin 
		if(n_bit != 2'b00)
				n_bit--;//Decrement n_bit state
		end
	end
	
	
	//2^m combinations 
	else begin
	  m_count=0;
	  if(receive === 'x) begin
	    n_bit = '0;
	    m_bit = '1;      //Default to logic to all 1's
	    minus_one = 1;
	  end
	  
	//Last m branches
	  else begin
	    while(m_count!=m)begin
	    m_count++;
	    m_bit--;
      if(minus_one == 1)begin
	     n_bit = '0;
	     minus_one = 0;
	     break;
	    end
      else begin
          n_bit = receive;
          //n_bit = receive;
          /*if(n_bit < temp_bit)
            n_bit = temp_bit;
          temp_bit = n_bit;*/
        end 
      end                //End while
	   end                 //End else begin
	   
	   
	  if(n_bit<NDIV)	begin			//Less than half of the state logic 
			comb_branch = 0;		
		end
		else begin
			comb_branch = 1;
			
	  end                  
	    
	  if(Branch == Result)
		  if(n_bit != 2'b11)
			  n_bit++;//Decrement n_bit state
		  else begin 
		    if(n_bit != 2'b00)
				n_bit--;//Decrement n_bit state
		end
	    
	 end 
	  
	  //Enable Write State
		CS = 1'b0;
		OE = 1'b0;
		WE = 1'b0;
		
end	

always@(m_bit)begin
  if(temp_bit < NDIV)begin
    branch_count++;
    n_bit = temp_bit; 
  end
  if(branch_count == m)begin
    m_bit += branch_count;
    branch_count = 0; 
  end
  
end



endmodule


