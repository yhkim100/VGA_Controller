library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
USE ieee.numeric_std.ALL;
library altera;
use altera.altera_primitives_components.all;

entity VFSM is
port (
    clk     		: in std_logic;
    rst     		: in std_logic;
	 V_count_value	: in	std_logic_vector (9 downto 0);
    vsync   		: out std_logic;
	 enable_PC		: out std_logic;
	 reset_PC		: out	std_logic);
end VFSM;


architecture basic of VFSM is

	constant VAV		: std_logic_vector(4 downto 0) 	:= "00001";
	constant VFP		: std_logic_vector(4 downto 0)	:= "00010";
	constant VSP		: std_logic_vector(4 downto 0) 	:= "00100";
	constant VBP		: std_logic_vector(4 downto 0)	:= "01000";
	constant INIT		: std_logic_vector(4 downto 0)	:= "10000";

	signal next_state		: std_logic_vector(4 downto 0);
	signal present_state	: std_logic_vector(4 downto 0);
	signal not_rst 		: std_logic;

	component VFSM_next_state_logic is port (
		rst				: in std_logic;
		V_count_value	: in	std_logic_vector (9 downto 0);
		present_state	: in std_logic_vector(4 downto 0);
		next_state		: out std_logic_vector(4 downto 0)
	);
	end component;
	
begin

--- Replace this with your code ---
	not_rst <= not rst;

	next_state_logic_inst :  VFSM_next_state_logic port map(
		rst				=>	rst,
		V_count_value	=> V_count_value,
		present_state	=>	present_state,
		next_state		=> next_state
	);

--Moore output logic
	vsync <= '0' when present_state = VSP else
				'1';
	enable_PC <= '1' when present_state = VAV else '0';
	reset_PC	<= '0' when present_state = VAV else '1';


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