library ieee;
use ieee.std_logic_1164.all;

entity circuit_tb is
end circuit_tb;

architecture behavior of circuit_tb is
signal tb_a : std_logic;       --input 
signal tb_out : std_logic;   --output

begin
--Instantiate the design under test
    uut : entity circuit port map (tb_a, tb_out);

tb : process
    constant period: time := 25 ns;
    begin
        wait for period;            --Waits for 25 ns;
        tb_a <= '1';               --applies 1 to tb_a

        wait for period;            --Waits for 25 ns;
            assert (tb_out = '0');  --Assert whether the output is 0, basically inverting
                report "Test incorrect, tb_out is 1" severity error;  --If assert failed, report message with severity error
        
        tb_a <= '0';               --applies 0 to tb_a

        wait for period;            --Waits for 25 ns;
            assert (tb_out = '1');  --Assert whether the output is 1
                report "Test incorrect, tb_out is 0" severity error; --If assert failed, report message with severity error

        wait;
    end process;
end behavior;
