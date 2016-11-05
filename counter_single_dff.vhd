library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
library altera;
use altera.altera_primitives_components.all;


entity counter_single_dff is 
port(
	clk			:	in		std_logic;
	enable		: 	in		std_logic;
	zero			:	in		std_logic;
	q				:	out	std_logic;
	out_enable	:	out	std_logic
);
end counter_single_dff;

architecture arch of counter_single_dff is
	signal	q_value_tmp			:	std_logic;
	
begin 

	dff_reg : dff port map (
	  clk => clk,
	  clrn => '1',
	  prn => '1',
	  d => (q_value_tmp xor enable) AND (NOT zero),
	  q => q_value_tmp
	);
	
	q <= q_value_tmp;
	out_enable	<=	q_value_tmp and enable;
end arch;