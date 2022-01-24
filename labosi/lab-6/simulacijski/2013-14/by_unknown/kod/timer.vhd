library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity timer is
	port(	cp, reset, master_reset	: in std_logic;
		t							: out	std_logic_vector(4 downto 0)
	);
end timer;

architecture arch of timer is
	component brojilo is
		port(	cp, br_reset	: in std_logic;
				q				: out std_logic_vector(4 downto 0)
			);
	end component;
	
	signal sig_master_reset 	: std_logic;
	signal sig_q				: std_logic_vector(4 downto 0);
	
begin
	sig_master_reset <= reset or master_reset;
	brojilo_inst1 : brojilo port map(cp => cp, br_reset => sig_master_reset, q => sig_q);
	
	with sig_q select
		t <=	"10000" after 10 ns when "00001", -- t2
				"01000" after 10 ns when "00011", -- t4
				"00100" after 10 ns when "00111", -- t8
				"00010" after 10 ns when "01111", -- t16
				"00001" after 10 ns when "11111", -- t32
				"00000" after 10 ns when others;
			

end arch;