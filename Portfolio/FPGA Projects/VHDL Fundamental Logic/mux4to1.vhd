--Multiplexer 4 to 1 using concurrent signal statements using boolean expression
library ieee;
use ieee.std_logic_1164.all;

entity mux4to1 is
    port
        (
            c   :           in std_logic_vector (3 downto 0);
            g_bar, b, a:    in std_logic;
            y   :           inout std_logic
        );
end mux4to1;


architecture dataflow of mux4to1 is
begin
    y<=not g_bar and ((not b and not a and c(0)) --selection 00
    or (not b and a and c(1))                    --selection 01
    or (b and not a and c(2))                    --selection 10
    or (b and a and c(3)));                      --selection 11
end dataflow;



--Multiplexer 4 to 1 using selected signal statement
architecture selected of mux4to1 is
begin
    with std_logic_vector'(g_bar,b,a) select
    y <= c(0) when "000",
    y <= c(1) when "001",
    y <= c(2) when "010",
    y <= c(3) when "011",
    '0' when others;
end selected;


--Multiplexer 4 to 1 using case statement
library ieee;
use ieee.std_logic_1164.all;

entity mux4_1 is
    port
        (
            a,b,c,d:    in  std_logic;
            ctrl:       in  std_logic_vector (1 downto 0);
            z:          out std_logic
        );    
end mux4_1;

architecture mux_case of mux4_1 is
constant mux_delay: time := 10 ns;       --initialize to constant 10ns

begin
    pmux: process(a,b,c,d,ctrl)
    variable temp:  std_logic;
    begin
        case ctrl is 
            when "00" => temp := a;  --temp is given a when ctrl is 00
            when "01" => temp := b;  --temp is given b when ctrl is 01
            when "10" => temp := c;  --temp is given c when ctrl is 10
            when "11" => temp := d;  --temp is given d when ctrl is 11
            when others => temp := '-';
        end case;
        z <= temp after mux_delay;  --output z gets temp after 10 ns
    end process pmux;
end mux_case;



