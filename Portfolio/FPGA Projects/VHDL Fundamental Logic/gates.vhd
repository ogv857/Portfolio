--2 input and gate 
library ieee;
use ieee.std_logic_1164.all;

entity and2 is
    port
    (
        a, b : in std_logic;
        z_out : out std_logic
    );
end and2;

architecture dataflow of and2 is
begin
  z_out <= a and b;
end dataflow;

library ieee;
use ieee.std_logic_1164.all;


--2 input Or gate 
library ieee;
use ieee.std_logic_1164.all;

entity or2 is
    port
    (
        a, b : in std_logic;
        z_out : out std_logic
    );
end or2;

architecture dataflow of or2 is
begin
  z_out <= a or b;
end dataflow;



--3 input NAND gate
library ieee;
use ieee.std_logic_1164.all;

entity nand3 is
    port
    (
        a, b, c :   in std_logic;
        z_out   :   out std_logic
    );
end nand3;

architecture dataflow of nand3 is
    begin
      z_out <= not(a and b and c);
    end dataflow;



--3 input NOR gate
library ieee;
use ieee.std_logic_1164.all;

entity nor3 is
    port
    (
        a, b, c :   in std_logic;
        z_out   :   out std_logic
    );
end nor3;

architecture dataflow of nor3 is
    begin
      z_out <= not(a or b or c);
end dataflow;


--Not Gate
library ieee;
use ieee.std_logic_1164.all;

entity mynot is
    port
    (
        a :   in std_logic;
        z_out   :   out std_logic
    );
end mynot;

architecture dataflow of mynot is
    begin
      z_out <= not a;
end dataflow;

