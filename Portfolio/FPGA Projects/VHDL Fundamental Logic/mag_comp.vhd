--4-bit comparator using multiple conditional assignment statements
library ieee;
use ieee.std_logic_1164.all;

entity mag_comp is 
    port
        (
            p, q: in std_logic_vector (3 downto 0);
            p_gt_bar, p_eq_bar, p_lt_bar: out std_logic
        );
end mag_comp;

architecture conditional of mag_comp is
begin
    p_gt_bar <= '0' when p > q else '1';
    p_eq_bar <= '0' when p = q else '1';
    p_lt_bar <= '0' when p < q else '1';
end conditional;    