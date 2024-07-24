library ieee;
use ieee.std_logic_1164.all;

entity sync_counter3 is
	port (
	clk: in std_logic;
	en: in std_logic;
	rst: in std_logic;
	pre : in std_logic;
	z: inout std_logic_vector (2 downto 0):= "000");
end sync_counter3;


architecture structural of sync_counter3 is 

component TFF 
	port(
	CLK, T: in std_logic; 
	en, pre, rst: in std_logic;
	Q, QB: out std_logic
	);
end component; 					 


component myand3
port (

	a: in STD_LOGIC;
	b: in STD_LOGIC;
	c: in STD_LOGIC;
	x: out STD_LOGIC

	);	  
end component;

component and2
    port
        (
            a, b : in std_logic;
            z_out : out std_logic
        );
end component;

signal x, Tb, Ta: std_logic;
begin
	u1: entity work.and2 port map(x, z(0), tb);	--direct instantiation with position association
	u2: myand3 port map(z(0), z(1), ta);			--indirect instantiation with position association
	u3: tff port map (clk=>clk, t=>x, en=>en, rst=>rst, pre=>pre, q=>z(0), qb => open); -- indirect instantiation with position association    
	u4: tff port map (clk=>clk, t=>tb, en=>en, rst=>rst, pre=>pre, q=>z(0), qb => open); -- indirect instantiation with position association 
	u5: tff port map (clk=>clk, t=>ta, en=>en, rst=>rst, pre=>pre, q=>z(2), qb => open); -- indirect instantiation with position association 
	
	
end structural;
