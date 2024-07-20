library ieee;
use ieee.std_logic_1164.all;

entity half_adder is
    port
        (
            a, b:       in  std_logic;
            sum, c_out: out std_logic
        );

        --User-Defined Attributes
        --by Lattice Semiconductor
        attribute loc: string;                    --pin assignment attribute
        attribute loc of a: signal is "P3";       --pin assignments
        attribute loc of b: signal is "P4";
        attribute loc of sum: signal is "P25";
        attribute loc of c_out: signal is "P24";

end half_adder;

architecture dataflow of half_adder is
begin
    sum <= (a and not b) or (not a and b);
    c_out <= (a and b);
end dataflow;                         