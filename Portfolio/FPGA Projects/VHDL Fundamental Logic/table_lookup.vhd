--Single output lookup up table
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity table_lookup_vector is
    port
        (
            a, b , c : in std_logic;
            z_out : out std_logic
        );
end table_lookup_vector;


architecture lookup of table_lookup_vector is

constant output :std_logic_vector (7 downto 0) := "01-01-10";   --Based off a system of 3 inputs for 1 output'
begin
    z_out <= output(to_integer(unsigned'(a,b,c)));  --inputs are assigned as an unsigned vector
                                                    --to_integer converts the input values to integer
end lookup;                                         --Once converted lookups up as an index into the constant output lookup table
