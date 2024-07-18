--D Flip flop
library ieee;
use ieee.std_logic_1164.all;

entity dff is
    port
    (
        clk, d  : in std_logic;
        q, qb   : out std_logic
    );
end dff;

architecture behavioral of dff is 
begin
    process(clk, d) --Sensitivity list
    begin
        if (clk'event and clk = '1') then   --Rising edge
            if(d = '1')then
                q <= d;
                qb <= not d;
            elsif(d='0') then
                q <= '0';
                qb <= '1';
            end if;
        end if;
    end process;
end behavioral;




--T Flip Flop
library ieee;
use ieee.std_logic_1164.all;

entity tff is
    port
    (
        t, clk :    in std_logic;
        q, qb  :    out std_logic
    );
end tff;

architecture behavioral of tff is
begin
    process(clk, t)
    begin
        if(clk'event and clk = '1') then
            if(t = '1')then
                q <= not T;
                qb <= T;
            else
                q <= t;
                qb <= not T;
            end if;
        end if;
    end process;
end behavioral;




--JK Flip Flop
library ieee;
use ieee.std_logic_1164.all;

entity jkff is
    port
    (
        j,k,clk : in std_logic;
        q, qb   : out std_logic
    );
end jkff;

architecture behavioral of jkff is
begin
    process(clk,j,k)
    begin
        if(clk'event = '1' and clk = '1') then
            if((j = '0') and (k = '1')) then              -- Truth Table 01
                q <= '0';                               
                qb <= '1';
            elsif(j = '1') and (k = '0') then                
                q <= '1';                               
                qb <= '0';
            elsif(j = '0') and (k ='0') then            --No change in output
                q <= q;
                qb <= qb;
            else
                q <= not Q;
                qb <= not QB;
            end if;
        end if;
    end process;
end behavioral;


--SR Flip flop
library ieee;
use ieee.std_logic_1164.all;

entity srff is
    port
    (
        s, r, clk :     in  std_logic;
        q, qb     :     out std_logic
    );
end srff;

architecture behavioral of srff is
begin
    process(clk, s, r)
    begin
        if(clk'event and clk ='1') then
            if((s = '0') and (r ='1')) then
                q <= '0';
                qb <= '1';
            elsif(s = '1') and (r = '0') then
                q <= '1';
                qb <= '0';
            elsif(s = '0') and (r = '0') then
                q <= q;
                qb <= qb;
            else
                q <= not q;
                qb <= not qb;
            end if;
        end if;
    end process;
end behavioral;

                


