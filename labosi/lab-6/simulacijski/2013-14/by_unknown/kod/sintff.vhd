library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sintff is
	port(	clk	:	in std_logic;
			t	:	in std_logic;
			clr	:	in std_logic;
			st	:	in std_logic;
			q	:	out	std_logic;
			qn	:	out	std_logic
		);
end sintff;

architecture arhitektura of sintff IS
BEGIN
	process(clk)
		variable stanje	:	std_logic := '0';
	BEGIN
		if falling_edge(clk) then	--	ako je padajuci brid
			if (clr = '1') then		--	ako je ulaz clear u jedinici
				stanje := '0';
			elsif (st = '1') then	--	ako je ulaz set u jedinici
				stanje := '1';
			else
				stanje := t xor stanje;		--	stanje bistabila
			end if;
		end if;
		
		q <= stanje after 10 ns;
		qn <= not stanje after 10 ns;
	END process;
END arhitektura;