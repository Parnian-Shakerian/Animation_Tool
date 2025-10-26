library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library animation;
use animation.types;

entity tb_animation is
end tb_animation;

architecture behavioral of tb_animation is
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal play : std_logic := '0';
    signal data_in : types.data_type := (others => (others => (others => '0')));
    signal data_out : types.data_type;

    component animation is
        port (
            clk : in std_logic;
            reset : in std_logic;
            play : in std_logic;
            data_in : in types.data_type;
            data_out : out types.data_type
        );
    end component;

begin
    uut: animation
        port map (
            clk => clk,
            reset => reset,
            play => play,
            data_in => data_in,
            data_out => data_out
        );

    clk_process: process
    begin
        while true loop
            wait for 5 ns;
            clk <= not clk;
        end loop;
    end process;

    stim_process: process
    begin
        wait for 10 ns;
        reset <= '0';
        wait for 10 ns;
        for i in 0 to types.w-1 loop
            for j in 0 to types.w-1 loop
                data_in(i, j) <= std_logic_vector(to_unsigned(i * types.w + j, 24));
                wait for 10 ns;
            end loop;
        end loop;
        play <= '1';
        wait;
        play <= '0';
        wait for 10 ns;
        for i in 0 to types.w-1 loop
            for j in 0 to types.w-1 loop
                data_in(i, j) <= std_logic_vector(to_unsigned(255 - (i * types.w + j), 24));
                wait for 10 ns;
            end loop;
        end loop;
        wait;
    end process;

end behavioral;
