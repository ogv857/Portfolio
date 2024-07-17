library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity and_2 is
    port
    (
        a, b  : in std_logic;
        z_out : out std_logic
    );
end and_2;

architecture dataflow of and_2 is
begin
  z_out <= a and b;
end dataflow;
