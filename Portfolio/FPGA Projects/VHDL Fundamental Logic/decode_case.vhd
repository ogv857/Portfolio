--Decoder using case statements
library ieee;
use ieee.std_logic_1164.all;

entity decode_case is
    port
        (
            e_bar, a, b : in std_logic;
            z_out: out std_logic_vector (3 downto 0)
        );
end decode_case;

architecture dcase of decode_case is
begin
    --Case statements are in a process
    process(e_bar, a, b) --sensitivty list
    begin
        --Assign default value to output
        z_out <= "1111";

    case std_logic_vector'(e_bar, a, b) is
        when "000" => z_out(3) <= '0';      --0111
        when "001" => z_out(2) <= '0';      --1011
        when "010" => z_out(1) <= '0';      --1101
        when "011" => z_out(0) <= '0';      --1110
        when others => null;                --Default Case
    end case;

end process;
end dcase;

