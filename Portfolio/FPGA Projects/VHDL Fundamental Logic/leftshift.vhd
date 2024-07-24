library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity leftshift is
    port
        (
            din : in unsigned (31 downto 0);
            dout : out unsigned (31 downto 0)
        );
end leftshift;

architecture behavior of leftshift is
signal t1: unsigned (33 downto 0);

begin
    t1 <= (din sll 2) & "00";
    dout <= t1 (33 downto 2);

end behavior;


--shift register
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter is
    generic (REGSIZE: integer := 8);
    port
        (
            clk, Data_in : in std_logic;
            data_out : out std_logic_vector ((regsize-1) downto 0)
        );
end shifter;

architecture bhv of shifter is
signal shift_reg : std_logic_vector ((regsize - 1) downto 0) := (others => '0');
begin
    process(clk)
    begin
        if (clk'event and clk ='1') then
            shift_reg <= shift_reg(regsize -2 downto 0) & data_in;
        end if;
    end process;
    data_out <= shift_reg;
end bhv;

