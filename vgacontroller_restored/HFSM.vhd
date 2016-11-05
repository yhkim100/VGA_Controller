library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
USE ieee.numeric_std.ALL;
library altera;
use altera.altera_primitives_components.all;

entity HFSM is
port (
    clk     		: in std_logic;
    rst     		: in std_logic;
	 H_count_value	: in	std_logic_vector (9 downto 0);
    blank   		: out std_logic;
	 enable_PC		: out std_logic;
    hsync   		: out std_logic);
end HFSM;


architecture basic of HFSM is

	constant AV		: std_logic_vector(4 downto 0) 		:= "00001";
	constant FP		: std_logic_vector(4 downto 0)		:= "00010";
	constant SP		: std_logic_vector(4 downto 0) 		:= "00100";
	constant BP		: std_logic_vector(4 downto 0)		:= "01000";
	constant INIT	: std_logic_vector(4 downto 0)		:= "10000";
	

	signal next_state		: std_logic_vector(4 downto 0);
	signal present_state	: std_logic_vector(4 downto 0);
	signal not_rst 		: std_logic;

	component HFSM_next_state_logic is port (
		rst				: in std_logic;
		H_count_value	: in	std_logic_vector (9 downto 0);
		present_state	: in std_logic_vector(4 downto 0);
		next_state		: out std_logic_vector(4 downto 0)
	);
	end component;
	
begin

--- Replace this with your code ---
	not_rst <= not rst;

	next_state_logic_inst :  HFSM_next_state_logic port map(
		rst				=>	rst,
		H_count_value	=> H_count_value,
		present_state	=>	present_state,
		next_state		=> next_state
	);
	

--Moore output logic
	hsync <= '1' when present_state = AV else
				'1' when present_state = FP else
				'0' when present_state = SP else
				'1' when present_state = BP else
				'0' when present_state = INIT;
				
	blank <= '1' when present_state = AV else
				'0' when present_state = FP else
				'0' when present_state = SP else
				'0' when present_state = BP else
				'0' when present_state = INIT;
				
	enable_PC <= '1' when present_state = AV else '0';


--next state registers
	gen_dffs: for i in 4 downto 0 generate
		next_to_present_dffs : dff port map (
		  clk => clk,
		  clrn => not_rst,
		  prn => '1',
		  d => next_state(i),
		  q => present_state(i)
		);
	end generate gen_dffs;

end basic;