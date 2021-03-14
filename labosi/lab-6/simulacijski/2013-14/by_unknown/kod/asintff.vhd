library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity asintff is
	PORT(	clk	:	in	std_logic;
			t	:	in	std_logic;
			clr	:	in	std_logic;
			st	:	in	std_logic;
			q	:	out	std_logic;
			qn	:	out	std_logic
		);
end entity;

architecture arhitektura of asintff is
BEGIN

PROCESS(clk, st, clr)
	variable stanje	:	std_logic := '0';
BEGIN
	if (clr = '1') then		--	ako je ulaz clear u jedinici, pazi ova oba ulaza su asinkrona!
		stanje := '0';
	elsif (st = '1') then	--	ako je ulaz set u jedinici, pazi ova oba ulaza su asinkrona!
		stanje := '1';
	elsif (falling_edge(clk)) then
			stanje := t xor stanje;		--	stanje bistabila
	end if;
		
	q <= stanje after 10 ns;
	qn <= not stanje after 10 ns;
END PROCESS;
END arhitektura;	