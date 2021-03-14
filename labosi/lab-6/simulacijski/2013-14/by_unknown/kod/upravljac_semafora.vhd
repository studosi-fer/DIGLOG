library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity upravljac is
	port( 	master_reset 	: in std_logic;
			cp				: in std_logic;
			cr, cy, cg, wr 	: out std_logic
		);
end upravljac;

architecture arch of upravljac is

	component automat is
		port(	t				:	in std_logic_vector(4 downto 0);
				cp				:	in std_logic;
				master_reset	:	in std_logic;
				reset			:	out std_logic;
				cr, cy, cg, wr	:	out	std_logic
			);
	end component;

	component timer is
		port(	cp, reset, master_reset	:	in std_logic;
				t						:	out	std_logic_vector(4 downto 0)
			);
	end component;

	signal sig_reset : std_logic;
	signal sig_t : std_logic_vector(4 downto 0);
begin
	timer_instance   : timer   port map(cp => cp, reset => sig_reset, master_reset => master_reset, t => sig_t);
	automat_instance : automat port map(cp => cp, reset => sig_reset, master_reset => master_reset, t => sig_t, cr => cr, cy => cy, cg => cg, wr => wr);
end arch;