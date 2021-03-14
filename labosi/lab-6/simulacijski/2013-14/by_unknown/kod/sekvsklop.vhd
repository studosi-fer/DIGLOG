library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sekvsklop is
	port(	clk		:	in	std_logic;
			reset	:	in	std_logic;
			p		:	in	std_logic;
			q		:	out	std_logic_vector(4 downto 0)
		);
end sekvsklop;

architecture strukturalna of sekvsklop is

	component sintff is
		port(	clk	:	in std_logic;
				t	:	in std_logic;
				clr	:	in std_logic;
				st	:	in std_logic;
				q	:	out	std_logic;
				qn	:	out	std_logic
			);
	end component;
	
	signal sig_s0 		: std_logic; -- sa ovoga se ocitava Q0; izlaz iz bistabila B0
	signal sig_s1 		: std_logic; -- sa ovoga se ocitava Q1; izlaz iz bistabila B1
	signal sig_s2i 		: std_logic; -- kombinacija izlaza bistabila B1 i izlaza bistabila B0
	signal sig_s3 		: std_logic; -- izlaz bistabila B2, sa ovoga se ocitava Q2
	signal sig_s3i 		: std_logic; -- kombinacija izlaza bistabila B2 i izlaza bistabila B1 i izlaza bistabila B0
	signal sig_s4 		: std_logic; -- izlaz bistabila B3, sa ovog se ocitava izlaz Q3
	signal sig_s4i 		: std_logic; -- kombinacija izlaza bistabila B3, B2, B1 i B0
	signal sig_clr_b0 	: std_logic; -- clear ulaz bistabila B0
	signal sig_set_b0 	: std_logic; -- set ulaz bistabila B0
begin
	sig_clr_b0 	<= (not p) and reset;
	sig_set_b0 	<= p and reset;
	sig_s2i 	<= sig_s0 and sig_s1;
	sig_s3i 	<= sig_s2i and sig_s3;
	sig_s4i 	<= sig_s3i and sig_s4;
	
	b0	:	sintff PORT MAP(clk => clk, t => '1',     clr => sig_clr_b0, st => sig_set_b0, q => sig_s0, qn => open);
	b1	:	sintff PORT MAP(clk => clk, t => sig_s0,  clr => reset,      st => '0',        q => sig_s1, qn => open);
	b2	:	sintff PORT MAP(clk => clk, t => sig_s2i, clr => reset,      st => '0',        q => sig_s3, qn => open);
	b3	:	sintff PORT MAP(clk => clk, t => sig_s3i, clr => reset,      st => '0',        q => sig_s4, qn => open);
	b4	:	sintff PORT MAP(clk => clk, t => sig_s4i, clr => reset,      st => '0',        q => q(4),   qn => open);
	
	q(0) <= sig_s0;
	q(1) <= sig_s1;
	q(2) <= sig_s3;
	q(3) <= sig_s4;
end strukturalna;