
--Comparator between ints
--Constrained to 4 bits as opposed to 32
--Reduces the amount of hardware synthesized
library ieee;
use ieee.std_logic_1164.all;

entity compare_int is 
    port
        (
            --synthesizer translates integer range to std_logic_vector (3 down to 0)
            a, b : in integer range 0 to 15;    --4 bits
            equal : out boolean
        );
end compare_int;

architecture behavioral of compare_int is 
begin
    process(a,b)
    begin
        if(a = b) then 
            equal <= true;
        else
            equal <= false;
        end if;
    end process;
end behavioral;