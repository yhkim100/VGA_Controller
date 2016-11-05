library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;


entity d_latch is 
port(
	enable	: 	in		std_logic;
	data		:	in		std_logic;
	q			:	out	std_logic;
	q_not		:	out	std_logic 
);
end d_latch;

architecture arch of d_latch is

	signal 	r						:	std_logic;
	signal	s						:	std_logic;
	signal 	q_loopBack			:	std_logic;
	signal 	q_not_loopBack		:	std_logic;

begin

	r					<=		(enable AND (Not data));
	s					<=		(enable AND data);
	q_loopBack		<=		(q_not_loopBack NOR r);
	q_not_loopBack	<=		(q_loopBack NOR s);
	
	q		<=		q_loopBack;
	q_not	<=		q_not_loopBack;

end arch;