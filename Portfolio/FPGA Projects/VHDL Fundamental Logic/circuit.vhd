library ieee;
use ieee.std_logic_1164.all;

entity not_gate is
    port
        (
            a : in std_logic;
            z_out : out std_logic
        );
end not_gate;

architecture dataflow of not_gate is
begin
    z_out <= not a;
end dataflow;

library ieee;
use ieee.std_logic_1164.all;

entity circuit is
    port
        (
            a : in std_logic;
            z_out : out std_logic
        );
end circuit;

architecture structural of circuit is
begin
    u0 : entity not_gate port map(a, z_out);
end structural;