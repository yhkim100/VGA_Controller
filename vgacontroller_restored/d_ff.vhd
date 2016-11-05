library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;


entity d_ff is 
port(
	clk		: 	in		std_logic;
	d			:	in		std_logic;
	q			:	out	std_logic;
	q_not		:	out	std_logic 
);
end d_ff;

architecture arch of d_ff is
	
	component d_latch is 
	port(
		enable	: 	in		std_logic;
		data		:	in		std_logic;
		q			:	out	std_logic;
		q_not		:	out	std_logic 
	);
	end component;

	signal 	q1_tmp	:	std_logic;
	signal	q1_not	:	std_logic;
	
begin

	d_latch1	:	d_latch	port map(
		enable	=>	(NOT clk),
		data		=>	d,
		q			=>	q1_tmp,
		q_not		=>	q1_not
	);
	
	d_latch2	:	d_latch	port map(
		enable	=>	clk,
		data		=>	q1_tmp,
		q			=>	q,
		q_not		=>	q_not
	);
	
end arch;