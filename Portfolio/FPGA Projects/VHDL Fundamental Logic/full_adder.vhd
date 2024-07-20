library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
    port
        (
            a, b, c_in: in std_logic;
            sum, carry_out: out std_logic
        );
end full_adder;

architecture structural of full_adder is 

    --Indirect instantiation
    component half_adder is
        port
            (
                a, b:       in  std_logic;
                sum, c_out: out std_logic
            );
    end component;

    component or2 is
        port
        (
            a, b : in std_logic;
            z_out : out std_logic
        );
        end component;

    --Create signals
    signal s1,s2,s3 : std_logic;    --Interconnect

    begin
        ha1: half_adder port map(a, b , s1, s2);        --Indirect, positional instantiation
        ha2: half_adder port map(s1, c_in , sum, s3);
        or1: or2 port map(s3, s2, carry_out);
end structural;

