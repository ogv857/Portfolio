--4-to-2 priority encoder
library ieee;
use ieee.std_logic_1164.all;

entity priority_encoder is
    port
        (
            enc :   in std_logic_vector (3 downto 0);
            zout :  out std_logic_vector (1 downto 0)
        );
end priority_encoder;

architecture csa_cond of priority_encoder is
begin
    --Must be Conditional Signal Assignment for priority     
    zout <= "00" when enc(3) = '0' else      --Prioritizes enc(3) first
        "01" when enc(2) = '0' else         --then enc(2)
        "10" when enc(1) = '0' else         --then enc(1)
        "11";                           --default assignment
end csa_cond;



--4-to-priority encoder using don't cares and numeric_std package
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity encoder_dc is
    port
        (
            enc :   in std_logic_vector (3 downto 0);
            zout :  out std_logic_vector (1 downto 0)
        );
end encoder_dc;

architecture dc of encoder_dc is
signal tempi: std_logic_vector (3 downto 0);

begin
    tempi <= (enc(3), enc(2), enc(1), enc(0));

    --std_match compare two vectors
    --Used mainly because of don't care values for simulator and synthesizer  
    zout <= "00" when std_match (tempi, "0---") else        
            "01" when std_match (tempi, "10--") else
            "10" when std_match (tempi, "110-") else
            "11";
end dc;

