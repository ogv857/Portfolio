module testbench;


  logic         clk;
  
  logic         we;
  logic         oe;
  logic         cs;
  logic  [0:7] addr;
  
  reg [7:0] data_write;
  wire [7:0] data;    
  wire [7:0] receive;
     
  integer count, rcount;
  
  //reg[7:0] RAM1[0:255];

  
  // instantiate device to be tested
  RAM #(.n(8), .m(0), .r(8)) dut(.CS(cs), .WE(we), .OE(oe), .ADDR(addr), .DATA(data));
  //RAM dut(.CS(cs), .WE(we), .OE(oe), .ADDR(addr), .DATA(data));

  
  // initialize test
  initial
    begin
		cs <= 1'b0;
		we <= 1'b1;
		oe <= 1'b0;
		
		rcount <= 0;
		count <= 0;
		addr <= 8'h00;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  
  assign data = (!we) ? data_write : 8'hZZ;
  assign receive = data;
  
  // check results
  always @(negedge clk)
    begin

      we <= 0;
		if(count % 2) begin
			data_write <= 8'b01010101;
			//RAM1[addr] <= data;
			$display("Value in Even Address ", data);
			$display("Data Address ", addr);
      count = count + 1;
		  end else
		  begin 
			data_write <= 8'b10101010;
			//RAM1[addr] <= data;
			$display("Value in Even Address ", data);
			$display("Data Address ", addr);
			count = count + 1;
      end
      if(count == 256)begin
        count <= 0;
        rcount <= rcount + 1;
        addr <= 0;
        we <= 1'b1;
        cs <= 1'b1;
        oe <= 1'b1;
      end
      if((count == 256) & (rcount == 2))
        $stop;  
    end


always @(posedge clk)
  begin
    if(count == 0)begin
      end
    else
   			addr <= addr + 1'b1;
      we <= 1'b1;
  end   
 endmodule