library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
library altera;
use altera.altera_primitives_components.all;

entity sync_HC_VC is
port (
    clk     : in std_logic;
    clearHC : in std_logic;
	 clearVC : in std_logic;
	 enableHC	:	in std_logic;
	 count_value_HC	:	out	std_logic_vector (9 downto 0);
	 count_value_VC	:	out	std_logic_vector (9 downto 0)
);
end sync_HC_VC;


architecture basic of sync_HC_VC is

component counter_10_bit is 
port(
	clk		: 	in		std_logic;
	zero		:	in		std_logic;
	enable	:	in		std_logic;
	count_value	:	out	std_logic_vector (9 downto 0)
);
end component;

signal	count_value_HC_tmp	:	std_logic_vector (9 downto 0);
signal	count_value_VC_tmp	:	std_logic_vector (9 downto 0);

begin

--- Replace this with your code ---
HC	:	counter_10_bit port map(
	clk		=>		clk,
--	-- HARD CODED DECIMAL VALUE OF 800
--	zero		=>		(count_value_HC_tmp(9) AND count_value_HC_tmp(8) AND NOT count_value_HC_tmp(7) AND NOT count_value_HC_tmp(6) 
--						AND count_value_HC_tmp(5) AND NOT count_value_HC_tmp(4) AND NOT count_value_HC_tmp(3) 
--						AND NOT count_value_HC_tmp(2)	AND NOT count_value_HC_tmp(1) AND NOT count_value_HC_tmp(0)) or clearHC,
	-- HARD CODED DECIMAL VALUE OF 799
	zero		=>		(count_value_HC_tmp(9) AND count_value_HC_tmp(8) AND NOT count_value_HC_tmp(7) AND NOT count_value_HC_tmp(6) 
						AND NOT count_value_HC_tmp(5) AND count_value_HC_tmp(4) AND count_value_HC_tmp(3) 
						AND count_value_HC_tmp(2)	AND count_value_HC_tmp(1) AND count_value_HC_tmp(0)) or clearHC,


	enable	=>		enableHC,
	count_value	=>	count_value_HC_tmp
);

vC	:	counter_10_bit port map(
	clk		=>		clk,
--	-- HARD CODED DECIMAL VALUE OF 524
--	zero		=>		(count_value_VC_tmp(9) AND NOT count_value_VC_tmp(8) AND NOT count_value_VC_tmp(7) AND NOT count_value_VC_tmp(6) 
--						AND NOT count_value_VC_tmp(5) AND NOT count_value_VC_tmp(4) AND count_value_VC_tmp(3) 
--						AND count_value_VC_tmp(2)	AND NOT count_value_VC_tmp(1) AND NOT count_value_VC_tmp(0)) or clearVC,

	-- HARD CODED DECIMAL VALUE OF 523
	zero		=>		(count_value_VC_tmp(9) AND NOT count_value_VC_tmp(8) AND NOT count_value_VC_tmp(7) AND NOT count_value_VC_tmp(6) 
						AND NOT count_value_VC_tmp(5) AND NOT count_value_VC_tmp(4) AND count_value_VC_tmp(3) 
						AND NOT count_value_VC_tmp(2)	AND count_value_VC_tmp(1) AND count_value_VC_tmp(0)) or clearVC,


--	-- HARD CODED DECIMAL VALUE OF 800
--	enable	=>		count_value_HC_tmp(9) AND count_value_HC_tmp(8) AND NOT count_value_HC_tmp(7) AND NOT count_value_HC_tmp(6) 
--						AND count_value_HC_tmp(5) AND NOT count_value_HC_tmp(4) AND NOT count_value_HC_tmp(3) 
--						AND NOT count_value_HC_tmp(2)	AND NOT count_value_HC_tmp(1) AND NOT count_value_HC_tmp(0),
						
	-- HARD CODED DECIMAL VALUE OF 799
	enable		=>		(count_value_HC_tmp(9) AND count_value_HC_tmp(8) AND NOT count_value_HC_tmp(7) AND NOT count_value_HC_tmp(6) 
						AND NOT count_value_HC_tmp(5) AND count_value_HC_tmp(4) AND count_value_HC_tmp(3) 
						AND count_value_HC_tmp(2)	AND count_value_HC_tmp(1) AND count_value_HC_tmp(0)) or clearHC,
	count_value	=>	count_value_VC_tmp
);

count_value_HC <= count_value_HC_tmp;
count_value_VC <= count_value_VC_tmp;

end basic;