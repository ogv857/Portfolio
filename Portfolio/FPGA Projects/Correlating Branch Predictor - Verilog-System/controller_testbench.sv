module controller_testbench();
    reg [64:0]HISTORY_RAM [0:5375];
    
    logic clk;
    logic [31:0]PC;
    logic [31:0]Target;
    logic Result;
    logic branch;
    
    initial begin
        $display("Loading RAM");
        $readmemh("history.dat.txt", HISTORY_RAM);
        
    end
    
  int index = 0;
  int accuracy = 0;
  
  parameter int m = 2;
  parameter int n = 2;
  parameter int r = 8;
  
  Correlating_Branch #(m,n,r)CB (PC,Target,Result,clk,branch);
   
  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end
    
    
  always @(posedge clk)
    begin
      PC <= HISTORY_RAM[0+index];
      Target <= HISTORY_RAM[1+index];
      Result <= HISTORY_RAM[2+index];
      index += 3;
      if(Result == branch)
          accuracy++;
      if(index > 5375)begin
        $stop;
      	end
    end
    
  

    

endmodule
