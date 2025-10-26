library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_serial_playback is
end tb_serial_playback;

architecture behavioral of tb_serial_playback is
    constant n : integer := 8;
    signal clk : std_logic := '0';
    signal reset : std_logic := '1';
    signal play : std_logic := '0';
    signal shift_reg : std_logic_vector(n-1 downto 0) := (others => '0');
    signal data_out : std_logic_vector(n-1 downto 0);
    signal clk_play : std_logic := '0';
    signal clk_record : std_logic := '0';

    component serial_playback is
        generic (
            n : integer := 8
        );
        port (
            clk : in std_logic;
            reset : in std_logic;
            play : in std_logic;
            shift_reg : in std_logic_vector(n-1 downto 0);
            data_out : out std_logic_vector(n-1 downto 0);
            clk_play : in std_logic;
            clk_record : in std_logic
        );
    end component;

begin
    uut: serial_playback
        generic map (
            n => n
        )
        port map (
            clk => clk,
            reset => reset,
            play => play,
            shift_reg => shift_reg,
            data_out => data_out,
            clk_play => clk_play,
            clk_record => clk_record
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
		shift_reg <= "00000011";
        wait for 10 ns;
        shift_reg <= "00000001";
        wait for 10 ns;
        shift_reg <= "00000010";
        wait for 10 ns;
        shift_reg <= "00000100";
        wait for 10 ns;
        shift_reg <= "00001000";
        wait for 10 ns;
        shift_reg <= "00010000";
        wait for 10 ns;
        shift_reg <= "00100000";
        wait for 10 ns;
        shift_reg <= "01000000";
        wait for 10 ns;
        play <= '1';
        wait for 80 ns;
        play <= '0';
        wait for 10 ns;
        shift_reg <= "11111111";
        wait for 80 ns;
    end process;

end behavioral;
