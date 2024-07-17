------------------TOP LEVEL ENTITY---------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity topEntity is
port(
subnetmask : in std_logic_vector(7 downto 0);

--IP Address		
first_octet : in std_logic_vector(7 downto 0);
second_octet : in std_logic_vector(7 downto 0);
third_octet: in std_logic_vector(7 downto 0);
fourth_octet: in std_logic_vector(7 downto 0);	

--Network IP		
network_ip : out std_logic_vector(31 downto 0);

--Broadcast IP
broadcast_ip : out std_logic_vector (31 downto 0));
end topEntity;

architecture structural of topEntity is

component SubnetCalculator
port(
mask : in std_logic_vector(7 downto 0);		
first_octet : in std_logic_vector(7 downto 0);
second_octet : in std_logic_vector(7 downto 0);
third_octet: in std_logic_vector(7 downto 0);
fourth_octet: in std_logic_vector(7 downto 0);	
mask_octet: in std_logic_vector (1 downto 0);

network_ip : out std_logic_vector (31 downto 0)
);
end component;

component conversion
port( mask_binary : in std_logic_vector(7 downto 0);
	mask_bits : out std_logic_vector(7 downto 0);
	mask_octet : out std_logic_vector (1 downto 0));
end component;

signal subnetbits : std_logic_vector (7 downto 0);
signal mask_octet : std_logic_vector (1 downto 0);

begin
	u1: conversion port map(subnetmask, subnetbits, mask_octet);
	u2: subnetcalculator port map(subnetbits, first_octet, second_octet,third_octet,fourth_octet, mask_octet,network_ip);
end structural;


------------------SUBNET CALCULATOR ENTITY--------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity SubnetCalculator is
port(
--Subnet Mask
mask : in std_logic_vector(7 downto 0);	
first_octet : in std_logic_vector(7 downto 0);
second_octet : in std_logic_vector(7 downto 0);
third_octet: in std_logic_vector(7 downto 0);
fourth_octet: in std_logic_vector(7 downto 0);	
mask_octet: in std_logic_vector (1 downto 0);

network_ip : out std_logic_vector (31 downto 0)
);

end SubnetCalculator;

architecture behavorial of SubnetCalculator is
signal conversion : std_logic_vector(7 downto 0) := "11111111"; 
begin
	process (mask,first_octet,second_octet,third_octet,fourth_octet)
	begin
		if(mask_octet = "00") --first octet
			then
			network_ip(31 downto 24) <= first_octet and mask;
			network_ip(23 downto 16) <= (others => '0');
			network_ip(15 downto 8) <= (others => '0');
			network_ip(7 downto 0) <= (others => '0');
		elsif(mask_octet = "01")	--second octet
			then
			network_ip(31 downto 24) <= first_octet;
			network_ip(23 downto 16) <= second_octet and mask;
			network_ip(15 downto 8) <= (others => '0');
			network_ip(7 downto 0) <= (others => '0');
		elsif(mask_octet = "10")	--third octet
			then
			network_ip(31 downto 24) <= first_octet;
			network_ip(23 downto 16) <= second_octet;
			network_ip(15 downto 8) <= third_octet and mask;
			network_ip(7 downto 0) <= (others => '0');
		elsif(mask_octet = "11")	--fourth octet
			then
			network_ip(31 downto 24) <= first_octet;
			network_ip(23 downto 16) <= second_octet;
			network_ip(15 downto 8) <= third_octet;
			network_ip(7 downto 0) <= fourth_octet and mask;
		end if;	
		end process;
end behavorial;



--CONVERT SUBNET MASK ENTITY
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity conversion is 
port( mask_binary : in std_logic_vector(7 downto 0);
	mask_bits : out std_logic_vector(7 downto 0);
	mask_octet : out std_logic_vector (1 downto 0));			--Which octet to mask
end conversion;

architecture behavorial_conversion of conversion is
signal octet : std_logic_vector (1 downto 0);

begin
				mask_bits <= "10000000" when mask_binary = "00000000" else
				"11000000" when mask_binary = "00000001" else
				"11100000" when mask_binary = "00000010" else
				"11110000" when mask_binary = "00000011" else
				"11111000" when mask_binary = "00000100" else
				"11111100" when mask_binary = "00000101" else
				"11111110" when mask_binary = "00000110" else
				"11111111" when mask_binary = "00000111" else
				"00000000";
				mask_octet <= "00" when (mask_binary <= "00000111") else
				"01" when ((mask_binary > "00000111") and (mask_binary <= "00001111")) else
				"10" when ((mask_binary > "00001111") and (mask_binary <= "00010111")) else
				"11" when ((mask_binary > "00010111") and (mask_binary <= "00011111")) else
				"00";			
				
end behavorial_conversion;
