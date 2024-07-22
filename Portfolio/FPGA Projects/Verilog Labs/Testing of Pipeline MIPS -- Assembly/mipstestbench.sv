//------------------------------------------------------------
// mipstest.sv
// David_Harris@hmc.edu & Sarah_Harris@hmc.edu, copyright 2012
// Testbench for MIPS processor
//-------------------------------------------------------------

module testbench();

  logic         clk;
  logic         reset;

  logic [31:0] writedata, dataadr;
  logic memwrite;

  // instantiate device to be tested
  top dut(clk, reset, writedata, dataadr, memwrite);
  
  // initialize test
  initial
    begin
      reset <= 1; # 22; reset <= 0;
    end

  // generate clock to sequence tests
  always
    begin
      clk <= 1; # 5; clk <= 0; # 5;
    end

  // check results
  always @(negedge clk)
    begin
      if(memwrite) begin
        /*if(dataadr === 84 & writedata === 7) begin
          $display("Simulation succeeded");
          $stop;
        end else if (dataadr !== 80) begin
          $display("Simulation failed");
          $stop;
        end*/
      end
      if(memwrite) begin
        $display("Value in matrix ", writedata);
        $display("Data Address", dataadr);
      end
      
    end
endmodule



