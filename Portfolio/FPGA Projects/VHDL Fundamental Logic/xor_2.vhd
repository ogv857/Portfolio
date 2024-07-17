library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xor_2 is
    port
    (
        a, b:   in    std_logic;
        o:      out   std_logic
    );
end xor_2;

architecture dataflow of xor_2 is
begin
    o <= a xor b;
end dataflow;