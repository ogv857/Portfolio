--D Flip Flop
--Behavioral implementation
library ieee;
use ieee.std_logic_1164.all;

entity dff_behavioral is
    port
    (
        d, clk : in std_logic;
        q, qb  : out std_logic
    );
end dff_behavioral;

architecture behavioral of dff_behavioral is
begin
    process (CLK, D)    --Sensitivity list
    begin
        if(clk'event and clk='1') then      --Rising Edge of the Clock
            if(D = '1') then                --Input is 1
                Q<=D;
                QB<=not D;
            elsif(D = '0') then
                Q <= '0';
                QB <= '1';
            end if;
        end if;
    end process;
end behavioral;