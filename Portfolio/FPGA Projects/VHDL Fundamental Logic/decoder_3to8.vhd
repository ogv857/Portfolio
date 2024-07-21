--3 to 8 decoder
library ieee;
use ieee.std_logic_1164.all;

entity decoder_3to8 is
    port
        (
            dec : in    std_logic_vector (2 downto 0);
            g1, g2a_bar, g2b_bar    :   in std_logic;
            z_out : out std_logic_vector (7 downto 0)
        );
end decoder_3to8;

architecture csa_cond of decoder_3to8 is

signal enables, dec_temp : std_logic_vector (2 downto 0);

begin
    enables <= (g1, g2a_bar, g2b_bar);      
    dec_temp <= (dec(2), dec(1), dec(0));

    z_out <= "11111110" when enables = "100" and dec_temp = "000" else
            "11111101"  when enables = "100" and dec_temp = "001" else
            "11111011" when enables = "100" and dec_temp = "010" else
            "11110111" when enables = "100" and dec_temp = "011" else
            "11101111" when enables = "100" and dec_temp = "100" else
            "11011111" when enables = "100" and dec_temp = "101" else
            "10111111" when enables = "100" and dec_temp = "110" else
            "01111111" when enables = "100" and dec_temp = "111" else
            "11111111";

end csa_cond;

