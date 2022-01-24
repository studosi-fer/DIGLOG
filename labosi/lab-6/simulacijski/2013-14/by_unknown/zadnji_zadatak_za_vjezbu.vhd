library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity brojac_ponasajna is
	 port(
	 	 reset : in std_logic;
	 	 smjer: in std_logic; -- 1 za brojanje od 0 do 31, 0 za brojanje od 31 do 0
		 clk : in std_logic;
		 izlaz : out std_logic_vector(0 to 4)
	     );
end brojac_ponasajna;

architecture brojac of brojac_ponasajna is
begin 
	process(clk)
		variable qa : std_logic := '0';
		variable qb : std_logic := '0';
		variable qc : std_logic := '0';
		variable qd : std_logic := '0';
		variable qe : std_logic := '0';
	begin
		if reset = '1' then
			qa := '0';
			qb := '0';
			qc := '0';
			qd := '0';
			qe := '0';
		elsif falling_edge(clk) then
			qa := not qa;
			qb := qb xor qa;
			qc := qc xor (qa and qb);
			qd := qd xor (qa and qb and qc);
			qe := qe xor (qa and qb and qc and qd);
		end if;
		
		izlaz <= (qe xor smjer) & (qd xor smjer) & (qc xor smjer) & (qb xor smjer) & (qa xor smjer);
	end process;

end brojac;
