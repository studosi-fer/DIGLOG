library ieee;
use ieee.std_logic_1164.all;

entity brojke is 
	port(
	      iv_left, iv_right, iv_up, iv_down, iv_center: in std_logic;
	      iv_code: out std_logic_vector(7 downto 0)
	      );
end brojke;

architecture arch of brojke is
	signal iv_btns: std_logic_vector(4 downto 0);

begin
	iv_btns <= iv_down & iv_left & iv_center & iv_up & iv_right;
	
	with iv_btns select
	iv_code <=
		   "00000000" when "00000", 
		   "00000000" when "10000",
		   "00110011" when "01000", --ASCII 3 
		   "00110110" when "00100", --ASCII 6 
		   "00110101" when "00010", --ASCII 5  
		   "00110001" when "00001", --ASCII 1  
		   "00110000" when "11000", --ASCII 0  
		   "00110110" when "10100", --ASCII 6  
		   "00111000" when "10010", --ASCII 8  
		   "00111000" when "10001", --ASCII 8  
		   "--------" when others;
end;