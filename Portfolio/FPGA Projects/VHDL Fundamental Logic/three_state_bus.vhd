--Three state buffer
library ieee;
use ieee.std_logic_1164.all;

entity three_state_buffer is
    port
        (
            a, en_bar : in std_logic;
            z_out: out std_logic
        );

end three_state_buffer;

architecture tsb of three_state_buffer is
begin
    z_out <= a when en_bar = '0' else
        'z';
end tsb;

--Two three state buffers with outupts connected

library ieee;
use ieee.std_logic_1164.all;

entity three_state_bus is
    port
        (
            d_a : in std_logic;
            en_a: in std_logic;
            d_b: in std_logic;
            en_b: in std_logic;
            d_bus: out std_logic
        );
end three_state_bus;

architecture ts_bus of three_state_bus is


begin
    --Both share the same bus
    --If both en_a and en_b are enabled, then the resulting output is a don't care
    u1:  entity three_state_buffer port map(d_a, en_a, d_bus);  
    u2:  entity three_state_buffer port map(d_b, en_b, d_bus);
end ts_bus;