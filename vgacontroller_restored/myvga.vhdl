library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_misc.all;
library altera;
use altera.altera_primitives_components.all;

entity myvga is
port (
    clk     : in std_logic;
    rst     : in std_logic;
    red     : out std_logic_vector (7 downto 0);
    green   : out std_logic_vector (7 downto 0);
    blue    : out std_logic_vector (7 downto 0);
    blank   : out std_logic;
    hsync   : out std_logic;
    vsync   : out std_logic);
end myvga;


architecture basic of myvga is

component vmem is
	port (
		address		: in std_logic_vector  (15 downto 0);
		clock		: in std_logic;
		q		    : out std_logic_vector (8 downto 0));
end component;

component sync_HC_VC is
port (
    clk     : in std_logic;
    clearHC : in std_logic;
	 clearVC : in std_logic;
	 enableHC	:	in std_logic;
	 count_value_HC	:	out	std_logic_vector (9 downto 0);
	 count_value_VC	:	out	std_logic_vector (9 downto 0)
	 );
end component;

component HFSM is
port (
    clk     		: in std_logic;
    rst     		: in std_logic;
	 H_count_value	: in	std_logic_vector (9 downto 0);
	 enable_PC		: out std_logic;
    blank   		: out std_logic;
    hsync   		: out std_logic
	 );
end component;

component VFSM is
port (
    clk     		: in std_logic;
    rst     		: in std_logic;
	 V_count_value	: in	std_logic_vector (9 downto 0);
    vsync   		: out std_logic;
	 enable_PC		: out std_logic;
	 reset_PC		: out std_logic
	 );
end component;


component counter_19_bit is
   port (
		clk		: 	in		std_logic;
		zero		:	in		std_logic;
		enable	:	in		std_logic;
		count_value	:	out	std_logic_vector (18 downto 0)
	);
end component;


signal 	pixel_index			   :  std_logic_vector (18 downto 0) := "0000000000000000000";
signal	count_value_HC_tmp	:	std_logic_vector (9 downto 0) := "0000000000";
signal	count_value_VC_tmp	:	std_logic_vector (9 downto 0)	:= "0000000000";
signal	RGB						:	std_logic_vector (8 downto 0) := "000000000";
signal	enable_PC_tmp_from_Hc:	std_logic := '0';
signal	enable_PC_tmp_from_VC:	std_logic := '0';
signal	not_rst					: 	std_logic;
signal	reset_PC					: 	std_logic;

begin

--- Replace this with your code ---

not_rst <= not rst;

H_V_Counters : sync_HC_VC 
port map(
    clk     	=>	clk,
    clearHC 	=> rst,
	 clearVC 	=> rst,
	 enableHC	=> '1',
	 count_value_HC	=> count_value_HC_tmp,
	 count_value_VC	=> count_value_VC_tmp
);


Horizontal_FSM : HFSM 
port map(
    clk     		=> clk,
    rst     		=> rst,
	 H_count_value	=> count_value_HC_tmp,
	 enable_PC		=> enable_PC_tmp_from_HC,
    blank   		=> blank,
    hsync   		=>	hsync
);

Vertical_FSM : VFSM 
port map(
    clk     		=> clk,
    rst     		=> rst,
	 V_count_value	=> count_value_VC_tmp,
    vsync   		=>	vsync,
	 enable_PC		=> enable_PC_tmp_from_Vc,
	 reset_PC 		=> reset_PC
);


pixel_counter : counter_19_bit
port map(
	clk 			 => clk,
	enable       => enable_PC_tmp_from_Hc AND enable_PC_tmp_from_VC,
	zero         => rst or reset_PC,
	count_value  => pixel_index
);

rom	:	 vmem 
port map(
	address		=> pixel_index (18 downto 3),
	clock			=>	clk,
	q			   => RGB
);

red 	<= RGB(8 downto 6) & "00000";
green <= RGB(5 downto 3) & "00000";
blue 	<= RGB(2 downto 0) & "00000";

--red <= "11111111";
--green <= "11111111";
--blue <= "11111111";




end basic;