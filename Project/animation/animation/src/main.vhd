library ieee;
use ieee.std_logic_1164.all;

package types is  	  
	constant f : integer := 8; 
	constant w : integer := 2;
	type data_type is array (0 to w-1, 0 to w-1) of std_logic_vector(23 downto 0);
	type memory_type is array (0 to f-1) of std_logic_vector(23 downto 0);
end types;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library	animation;
use animation.serial_playback;
use animation.types;

entity animation is	
    port (
        clk : in std_logic;
        reset : in std_logic;
        play : in std_logic;
        data_in : in types.data_type; 
        data_out : out types.data_type 
    );
end animation; 

architecture Behavior of animation is 
component serial_playback
	port (
        clk : in std_logic;
        reset : in std_logic;
        play : in std_logic;
        shift_reg : in std_logic_vector(23 downto 0);
        data_out : out std_logic_vector(23 downto 0) := (others=>'0')
		);
end component;	
begin	
	G1: for i in 0 to types.w-1 generate 
		G2:	for j in 0 to types.w-1 generate
			sp: serial_playback port map (clk => clk, reset => reset, play => play, shift_reg =>data_in(i,j) , data_out=>data_out(i,j));
		end generate;	
	end generate;
		
end Behavior;