library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity VFSM_next_state_logic is port (
		rst				: in std_logic;
		V_count_value	: in	std_logic_vector (9 downto 0);
		present_state	: in std_logic_vector(4 downto 0);
		next_state		: out std_logic_vector (4 downto 0)
		);
end entity;

architecture arch of VFSM_next_state_logic is

	constant VAV		: std_logic_vector(4 downto 0) 	:= "00001";
	constant VFP		: std_logic_vector(4 downto 0)	:= "00010";
	constant VSP		: std_logic_vector(4 downto 0) 	:= "00100";
	constant VBP		: std_logic_vector(4 downto 0)	:= "01000";
	--constant INIT		: std_logic_vector(4 downto 0)	:= "10000";

begin
	next_state <= 	VAV when (rst = '1') else 
						VAV when present_state = VAV and to_integer(unsigned(V_count_value)) < 479 else
						--transitions from VAV
						VFP when ((present_state = VAV) and to_integer(unsigned(V_count_value)) = 479) else
						VFP when ((present_state = VFP) and to_integer(unsigned(V_count_value)) < 490 and to_integer(unsigned(V_count_value)) >= 479) else
						--transitions from VFP
						VSP when ((present_state = VFP) and to_integer(unsigned(V_count_value)) = 490) else
						VSP when ((present_state = VSP) and to_integer(unsigned(V_count_value)) < 492 and to_integer(unsigned(V_count_value)) >= 490) else
						--transitions from VSP
						VBP when ((present_state = VSP) and to_integer(unsigned(V_count_value)) = 492) else
						VBP when ((present_state = VBP) and to_integer(unsigned(V_count_value)) < 523 and to_integer(unsigned(V_count_value)) >= 492) else
						--transitions from VBP
						VAV when ((present_state = VBP) and to_integer(unsigned(V_count_value)) = 523) else
						--include IDLE to cover missed cases.  Avoids inferred latches (which are bad).
						VAV;


end arch;