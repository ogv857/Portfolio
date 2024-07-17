--D Flip Flop
--Dataflow/Gate Level implementation
library ieee;
use ieee.std_logic_1164.all;

entity d_ff is
    port
    (
        d, clk : in std_logic;
        q, qb  : out std_logic
    );
end d_ff;

architecture dataflow of d_ff is
signal d1, s1, r1:  std_logic;

begin
    --Temporary signals/wires
    s1 <= d nand clk;
    d1 <= d nand d;
    r1 <= d1 nand clk;

    --Outputs
    q  <= s1 nand qb;
    qb <= r1 nand q;
end dataflow;