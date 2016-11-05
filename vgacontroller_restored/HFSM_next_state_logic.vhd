library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity HFSM_next_state_logic is port (
		rst				: in std_logic;
		H_count_value	: in	std_logic_vector (9 downto 0);
		present_state	: in std_logic_vector(4 downto 0);
		next_state		: out std_logic_vector(4 downto 0)
		);
end entity;

architecture arch of HFSM_next_state_logic is

	constant AV		: std_logic_vector(4 downto 0) 		:= "00001";
	constant FP		: std_logic_vector(4 downto 0)		:= "00010";
	constant SP		: std_logic_vector(4 downto 0) 		:= "00100";
	constant BP		: std_logic_vector(4 downto 0)		:= "01000";
	--constant INIT	: std_logic_vector(4 downto 0)		:= "10000";


begin
	next_state <= 	AV when (rst = '1') else 
						AV when present_state = AV and to_integer(unsigned(H_count_value)) < 639 else
						--transitions from AV
						FP when ((present_state = AV) and to_integer(unsigned(H_count_value)) = 639) else
						FP when ((present_state = FP) and to_integer(unsigned(H_count_value)) < 655 and to_integer(unsigned(H_count_value)) > 639) else
						--transitions from FP
						SP when ((present_state = FP) and to_integer(unsigned(H_count_value)) = 655) else
						SP when ((present_state = SP) and to_integer(unsigned(H_count_value)) < 751 and to_integer(unsigned(H_count_value)) > 655) else
						--transitions from SP
						BP when ((present_state = SP) and to_integer(unsigned(H_count_value)) = 751) else
						BP when ((present_state = BP) and to_integer(unsigned(H_count_value)) < 799 and to_integer(unsigned(H_count_value)) > 751) else
						--transitions from BP
						AV when ((present_state = BP) and to_integer(unsigned(H_count_value)) = 799) else
						--include IDLE to cover missed cases.  Avoids inferred latches (which are bad).
						AV;


end arch;