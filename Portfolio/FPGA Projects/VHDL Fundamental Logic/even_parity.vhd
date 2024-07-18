--Even parity
library ieee;
use ieee.std_logic_1164.all;

entity even_parity is
    port
    (
        x   :   in std_logic;
        clk :   in std_logic;
        y   :   out std_logic
    );
end even_parity;

architecture fsm of even_parity is
type sreg0_type is (s1, s2);                    --Declare a type to include two states
signal  sreg0, nextstate_sreg0: sreg0_type;     --Two machine states

--Any state machine has two processes one for clock and one for state machine
begin
    process1: process (x, sreg0)        
    begin
        nextstate_sreg0 <= sreg0;       --when input or state sreg0 changes, nextstate gets sreg0
            case sreg0 is
                when s1 => y<='0';
                    if x ='1' then nextstate_sreg0 <= s2;
                    elsif x = '0' then nextstate_sreg0 <= s1;
                    end if;
                when s2 => y<='1';
                    if x ='1' then nextstate_sreg0 <= s1;
                    elsif x='0' then nextstate_sreg0 <=s2;
                    end if;
                when others => null;
            end case;
    end process;

    process2: process (clk)
    begin
        if clk'event and clk ='1' then
            sreg0 <= nextstate_sreg0;
        end if;
    end process;
end fsm;

--if select and when select are concurrent statements