library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity brojilo is
	port(	cp, br_reset	:	in	std_logic;
			q				:	out	std_logic_vector(4 downto 0)
		);
end brojilo;

architecture brojilo_ar of brojilo is

	component sekvsklop is
		port(	clk		:	in	std_logic;
				reset	:	in	std_logic;
				p		:	in	std_logic;
				q		:	out	std_logic_vector(4 downto 0)
			);
	end component;
	
begin
	bin_broj : 	sekvsklop PORT MAP( clk => cp, reset => br_reset, p => '1', q => q);
end brojilo_ar;