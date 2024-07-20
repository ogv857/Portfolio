library ieee;
use ieee.std_logic_1164.all;

entity and_vector is 
    port
        (
            x, y: in std_logic_vector (3 downto 0);
            z:  out std_logic_vector (3 downto 0)
        );
end and_vector;

architecture dataflow1 of and_vector is
    begin
        z(3) <= x(3) and y(3);
        z(2) <= x(2) and y(2);
        z(1) <= x(1) and y(1);
        z(0) <= x(0) and y(0);
end dataflow1; 



--Since x, y and z are the same length and type
--we can apply the logical operator to the entire array
architecture dataflow2 of and_vector is
begin
    z <= x and y;
end dataflow2;
