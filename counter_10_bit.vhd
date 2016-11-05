library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
library altera;
use altera.altera_primitives_components.all;


entity counter_10_bit is 
port(
	clk		: 	in		std_logic;
	zero		:	in		std_logic;
	enable	:	in		std_logic;
	count_value	:	out	std_logic_vector (9 downto 0)
);
end counter_10_bit;

architecture arch of counter_10_bit is

	component counter_single_dff is 
	port(
		clk			:	in		std_logic;
		enable		: 	in		std_logic;
		zero			:	in		std_logic;
		q				:	out	std_logic;
		out_enable	:	out	std_logic
	);
	end component;


	signal	not_rst				:	std_logic;
	signal	count_values_tmp	:	std_logic_vector (9 downto 0) := "0000000000";
	signal	enable_values_tmp	:	std_logic_vector (9 downto 0) := "0000000000";
	
begin 
		
	counter_head : counter_single_dff port map (
			clk			=>		clk,
			enable		=>		enable,	
			zero			=>		zero,
			q				=>		count_values_tmp(0),
			out_enable	=>		enable_values_tmp(0)
		);

	
	gen_dffs: for i in 1 to 9 generate
		counter : counter_single_dff port map (
			clk			=>		clk,
			enable		=>		enable_values_tmp(i-1),
			zero			=>		zero,
			q				=>		count_values_tmp(i),
			out_enable	=>		enable_values_tmp(i)
		);
	end generate gen_dffs;
	
	count_value <= count_values_tmp;
end arch;