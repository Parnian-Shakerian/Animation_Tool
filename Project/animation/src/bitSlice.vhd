library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library	animation;
use animation.types;

entity serial_playback is
    port (
        clk : in std_logic;
        reset : in std_logic;
        play : in std_logic;
        shift_reg : in std_logic_vector(23 downto 0);
        data_out : out std_logic_vector(23 downto 0) := (others=>'0')
    );
	
end serial_playback;

architecture behavioral of serial_playback is
    signal memory : types.memory_type;
    signal counter_play : integer range 0 to types.f-1;
    signal counter_record : integer range 0 to types.f-1;
	
begin
    process (clk, reset)
    begin
		
        if reset = '1' then
            counter_play <= 0;
            counter_record <= 0;
         elsif rising_edge(clk) then
            if play = '0' then
                if rising_edge(clk) then
                    if counter_record = types.f-1 then
                        memory(counter_record) <= shift_reg;
                        counter_record <= 0;
                    else
                        memory(counter_record) <= shift_reg;
                        counter_record <= counter_record + 1;
                    end if;
                end if;
            else
                if rising_edge(clk) then
                    if counter_play = types.f-1 then
                        data_out <= memory(counter_play); 
						report "counter_play";
                        counter_play <= 0;
                    else
						report integer'image(counter_play);
                        data_out <= memory(counter_play);
                        counter_play <= counter_play + 1;
                    end if;
                end if;
            end if;
        end if;
    end process;
end behavioral;
