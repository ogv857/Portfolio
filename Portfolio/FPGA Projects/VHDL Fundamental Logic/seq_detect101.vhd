--Sequence Detector
library ieee;
use ieee.std_logic_1164.all;

entity seq101 is
    port
        (
        x, clk  :   in std_logic;
        z       :   out std_logic
        );
end seq101;

architecture structural of seq101 is        

component and_2                             --indirect instantiation
        port
        (
            a, b  : in std_logic;
            z_out : out std_logic
        );
end component;

component mynot                         
    port
    (
        a :   in std_logic;
        z_out   :   out std_logic
    );
end component;

component d_ff 
    port
    (
        d, clk : in std_logic;
        q, qb  : out std_logic
    );
end component;

--End components

--Declare signals
signal xnot, a, anot, b, bnot, da, db: std_logic;

begin
    --instantiate components
    u1: mynot port map (x, xnot);          --gives xnot the complement of x
    u2: and_2 port map (xnot, b, Da);     
    u3: and_2 port map (x, anot, Db);
    u4: d_ff port map (da, clk, a, anot);
    u5: d_ff port map (db, clk, b, bnot);
    u6: and_2 port map(x, a, z);            --output is given from x and a;

end structural;
    

