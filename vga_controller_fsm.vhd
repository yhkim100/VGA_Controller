library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
--add the dffs!!
library altera;
use altera.altera_primitives_components.all;

entity vga_controller_fsm is port(
	clk				: in std_logic;
	rst				: in std_logic;
	blank				: out std_logic;
	h_sync			: out std_logic;
	v_sync			: out std_logic);
end entity;

architecture arch of vga_controller_fsm is
	
	constant INIT				: std_logic_vector(16 downto 0) 	:= "00000000000000001";
	constant AV_VAV			: std_logic_vector(16 downto 0)	:= "00000000000000010";
	constant FP_VAV			: std_logic_vector(16 downto 0)	:= "00000000000000100";
	constant SP_VAV			: std_logic_vector(16 downto 0)	:= "00000000000001000";
	constant BP_VAV			: std_logic_vector(16 downto 0)	:= "00000000000010000";
	constant VFP_AV			: std_logic_vector(16 downto 0)	:= "00000000000100000";
	constant VFP_FP			: std_logic_vector(16 downto 0)	:= "00000000001000000";
	constant VFP_SP			: std_logic_vector(16 downto 0)	:= "00000000010000000";
	constant VFP_BP			: std_logic_vector(16 downto 0)	:= "00000000100000000";
	constant VSP_AV			: std_logic_vector(16 downto 0)	:= "00000001000000000";
	constant VSP_FP			: std_logic_vector(16 downto 0)	:= "00000010000000000";
	constant VSP_SP			: std_logic_vector(16 downto 0)	:= "00000100000000000";
	constant VSP_BP			: std_logic_vector(16 downto 0)	:= "00001000000000000";
	constant VBP_AV			: std_logic_vector(16 downto 0)	:= "00010000000000000";
	constant VBP_FP			: std_logic_vector(16 downto 0)	:= "00100000000000000";
	constant VBP_SP			: std_logic_vector(16 downto 0)	:= "01000000000000000";
	constant VBP_BP			: std_logic_vector(16 downto 0)	:= "10000000000000000";
	
	signal next_state		: std_logic_vector(5 downto 0);
	signal present_state	: std_logic_vector(5 downto 0);
	signal not_rst 		: std_logic;
	
	
	--CREATE THE COUNTERS HERE 
	
	component counter_12_bit is 
	port(
		clk		: 	in		std_logic;
		zero		:	in		std_logic;
		enable	:	in		std_logic;
		count_value	:	out	std_logic_vector (11 downto 0)
	);
	end component;
	
	
	component next_state_logic is port (
		horizontal_count		: 	in	std_logic_vector (11 downto 0);
		vertical_count			: 	in	std_logic_vector (11 downto 0);
		rom_count				:	in	std_logic_vector (11 downto 0);
		present_state	: in std_logic_vector(5 downto 0);
		next_state		: out std_logic_vector(5 downto 0)
	);
	end component;
	
begin

--	not_rst <= not rst;
--
--	next_state_logic_inst :  next_state_logic port map(
--		left_sensor		=> left_sensor,
--		right_sensor	=> right_sensor,
--		present_state	=> present_state,
--		next_state		=> next_state
--	);
						
--Moore output logic
--	spin_right <= '1' when present_state = GOING_RIGHT else '0';
--	spin_left <= '1' when present_state = GOING_LEFT else '0';
--		
--Mealey output logic



--next state registers
	gen_dffs: for i in 16 downto 0 generate
		next_to_present_dffs : dff port map (
		  clk => clk,
		  clrn => not_rst,
		  prn => '1',
		  d => next_state(i),
		  q => present_state(i)
		);
	end generate gen_dffs;


end arch;