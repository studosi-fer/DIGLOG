library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all; 

entity ALU is
	generic (
	C_data_width: integer := 4
	);
	port( 
		A,B : in std_logic_vector ((C_data_width-1) downto 0);
		Z : out std_logic_vector((C_data_width-1) downto 0);
		ALUOp : in std_logic_vector(2 downto 0)
	);
end ALU;

	architecture x of ALU is
	signal mul: std_logic_vector(((C_data_width*2)-1) downto 0);

begin

	mul <= A * B;

	with ALUOp select--vrijedi samo za moj jmbag!!!!!!!!!!!!!!!!
	Z<=
	A xor B when "000",
	A and B when "001",
	not(A or B) when "010",
	mul((C_data_width-1) downto 0) when "011",
	A - B when "100",
	shr(A, B) when "101",
	A + B when "110",
	A or B when "111";
	
end; 