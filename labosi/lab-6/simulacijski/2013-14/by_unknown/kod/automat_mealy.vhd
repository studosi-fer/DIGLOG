library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity automat_mealy is
	port(	t		:	in std_logic_vector(4 downto 0);
		cp		:	in std_logic;
		master_reset	:	in std_logic;
		reset		:	out std_logic;
		cr, cy, cg, wr	:	out std_logic
	);
end automat_mealy;
architecture mealy of automat_mealy is
	
	
	constant t2  : std_logic_vector(4 downto 0) := "10000";
	constant t4  : std_logic_vector(4 downto 0) := "01000";
	constant t8  : std_logic_vector(4 downto 0) := "00100";
	constant t16 : std_logic_vector(4 downto 0) := "00010";
	constant t32 : std_logic_vector(4 downto 0) := "00001";
	
	-- stanja automata
	constant S0 : std_logic_vector(2 downto 0) := "000";
	constant S1 : std_logic_vector(2 downto 0) := "001";
	constant S2 : std_logic_vector(2 downto 0) := "010";
	constant S3 : std_logic_vector(2 downto 0) := "011";
	constant S4 : std_logic_vector(2 downto 0) := "100";
	constant S5 : std_logic_vector(2 downto 0) := "101";
	constant S6 : std_logic_vector(2 downto 0) := "110";
	signal trenutno_stanje, sljedece_stanje : std_logic_vector(2 downto 0);
	

	signal izlaz : std_logic_vector(4 downto 0);

begin
	
	process(cp) 
	begin
		if falling_edge(cp) then
			if master_reset = '1' then
				trenutno_stanje <= S0;
			else
				trenutno_stanje <= sljedece_stanje;
			end if;
			cr    <= izlaz(4)  after 10 ns;
			cy    <= izlaz(3)  after 10 ns;
			cg    <= izlaz(2)  after 10 ns;
			wr    <= izlaz(1)  after 10 ns;
			reset <= izlaz(0)  after 10 ns;
		end if;
	end process;
	
	process(t, trenutno_stanje)
	begin
		case trenutno_stanje is
			when S0 =>
				if t = t8 then
					sljedece_stanje <= S1;
					izlaz <= "11001";
				else
					sljedece_stanje <= S0;
					izlaz <= "10000";
				end if;
			when S1 =>
				if t = t2 then
					sljedece_stanje <= S2;
					izlaz <= "00101";
				else
					sljedece_stanje <= S1;
					izlaz <= "11000";
				end if;
			when S2 => 
				if t = t32 then
					sljedece_stanje <= S3;
					izlaz <= "01001";
				else
					sljedece_stanje <= S2;
					izlaz <= "00100";
				end if;
			when S3 => 
				if t = t4 then
					sljedece_stanje <= S4;
					izlaz <= "10001";
				else
					sljedece_stanje <= S3;
					izlaz <= "01000";
				end if;
			when S4 => 
				if t = t2 then
					sljedece_stanje <= S5;
					izlaz <= "10011";
				else
					sljedece_stanje <= S4;
					izlaz <= "10000";
				end if;
			when S5 =>
				if t = t16 then
					sljedece_stanje <= S6;
					izlaz <= "10001";
				else
					sljedece_stanje <= S5;
					izlaz <= "10010";
				end if;
			when S6 => 
				if t = t4 then
					sljedece_stanje <= S1;
					izlaz <= "11001";
				else
					sljedece_stanje <= S6;
					izlaz <= "10000";
				end if;
		end case;
	end process;
	


end mealy;