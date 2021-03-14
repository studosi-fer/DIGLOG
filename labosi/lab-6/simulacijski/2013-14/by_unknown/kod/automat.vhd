library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity automat is
	port(	t		:	in std_logic_vector(4 downto 0);
		cp		:	in std_logic;
		master_reset	:	in std_logic;
		reset		:	out std_logic;
		cr, cy, cg, wr	:	out std_logic
	);
end automat;

architecture moore of automat is
	

	constant t2  : std_logic_vector(4 downto 0) := "10000";
	constant t4  : std_logic_vector(4 downto 0) := "01000";
	constant t8  : std_logic_vector(4 downto 0) := "00100";
	constant t16 : std_logic_vector(4 downto 0) := "00010";
	constant t32 : std_logic_vector(4 downto 0) := "00001";
	
	-- tablica stanja automata
	constant S0 : std_logic_vector(3 downto 0) := "0000";
	constant S1 : std_logic_vector(3 downto 0) := "0001";
	constant S2 : std_logic_vector(3 downto 0) := "0010";
	constant S3 : std_logic_vector(3 downto 0) := "0011";
	constant S4 : std_logic_vector(3 downto 0) := "0100";
	constant S5 : std_logic_vector(3 downto 0) := "0101";
	constant S6 : std_logic_vector(3 downto 0) := "0110";
	constant S7 : std_logic_vector(3 downto 0) := "0111";
	constant S8 : std_logic_vector(3 downto 0) := "1000";
	constant S9 : std_logic_vector(3 downto 0) := "1001";
	constant S10 : std_logic_vector(3 downto 0) := "1011";
	constant S11 : std_logic_vector(3 downto 0) := "1100";
	constant S12 : std_logic_vector(3 downto 0) := "1101";
	-- kraj tablice stanja automata
	
	signal trenutno_stanje, sljedece_stanje : std_logic_vector(3 downto 0);

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
		end if;
	end process;
	
	process(trenutno_stanje) 
	begin
		case trenutno_stanje is
			when S0  => izlaz <= "10000"; 
			when S1  => izlaz <= "11001"; 
			when S2  => izlaz <= "11000"; 
			when S3  => izlaz <= "00101"; 
			when S4  => izlaz <= "00100"; 
			when S5  => izlaz <= "01001"; 
			when S6  => izlaz <= "01000"; 
			when S7  => izlaz <= "10001"; 
			when S8  => izlaz <= "10000"; 
			when S9  => izlaz <= "10011"; 
			when S10 => izlaz <= "10010"; 
			when S11 => izlaz <= "10001"; 
			when S12 => izlaz <= "10000"; 
			
		end case;
	end process;
	
	process(t, trenutno_stanje) 
	begin
		case trenutno_stanje is
			when S0 =>
				if t = t8 then
					sljedece_stanje <= S1;
				else
					sljedece_stanje <= S0;
				end if;
			when S1 => sljedece_stanje <= S2;
			when S2 =>
				if t = t2 then
					sljedece_stanje <= S3;
				else
					sljedece_stanje <= S2;
				end if;
			when S3 => sljedece_stanje <= S4;
			when S4 => 
				if t = t32 then
					sljedece_stanje <= S5;
				else
					sljedece_stanje <= S4;
				end if;
			when S5 => sljedece_stanje <= S6;
			when S6 =>
				if t = t4 then
					sljedece_stanje <= S7;
				else
					sljedece_stanje <= S6;
				end if;
			when S7 => sljedece_stanje <= S8;
			when S8 =>
				if t = t2 then
					sljedece_stanje <= S9;
				else
					sljedece_stanje <= S8;
				end if;
			when S9 => sljedece_stanje <= S10;
			when S10 =>
				if t = t16 then
					sljedece_stanje <= S11;
				else
					sljedece_stanje <= S10;
				end if;
			when S11 => sljedece_stanje <= S12;
			when S12 =>
				if t = t4 then
					sljedece_stanje <= S1;
				else
					sljedece_stanje <= S12;
				end if;
			
		end case;
	end process;
	
	cr    <= izlaz(4) after 10 ns;
	cy    <= izlaz(3) after 10 ns;
	cg    <= izlaz(2) after 10 ns;
	wr    <= izlaz(1) after 10 ns;
	reset <= izlaz(0) after 10 ns;

end moore;
