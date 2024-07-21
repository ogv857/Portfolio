--BCD digit greater than 5
library ieee;
use ieee.std_logic_1164.all;

entity bcd_gt5 is 
    port
        (
            bcd :   in  std_logic_vector(3 downto 0);
            z_out:  out std_logic
        );
end bcd_gt5;

architecture csa_sel of bcd_gt5 is

signal temp : std_logic_vector (3 downto 0);

begin

temp <= (bcd(3), bcd(2), bcd(1),bcd(0));

with temp select
z_out <= '1' when "0110" | "0111" | "1000" | "1001",    --greater than 5
        '0' when others;

end csa_sel;