library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity alu is 
	port (
		A, B: in std_logic_vector(3 downto 0);
		ALUOp: in std_logic_vector(2 downto 0);
		Z: out std_logic_vector(3 downto 0)
	);
end alu;

architecture arch of ALU is
	signal andd: std_logic_vector(3 downto 0);
	signal norr: std_logic_vector(3 downto 0);
	signal srll: std_logic_vector(3 downto 0);
	signal orr:  std_logic_vector(3 downto 0);
	signal add:  std_logic_vector(3 downto 0);
	signal xorr: std_logic_vector(3 downto 0);
	signal subb: std_logic_vector(3 downto 0);
	signal mull: std_logic_vector(7 downto 0);
	
	begin
		andd <= A and B;
		norr <= not (A or B);
		srll <= shr(A, B);
		orr  <= A or B;
		add  <= A + B;
		xorr <= A xor B;
		subb <= A - B;
		mull <= A * B;
		
		with ALUOp select
		Z <=
			andd when "000",
			norr when "001",
			srll when "010",
			orr  when "011",
			add  when "100",
			xorr when "101",
			subb when "110",
			mull(3 downto 0) when "111";
					
end arch;
		
		
	

