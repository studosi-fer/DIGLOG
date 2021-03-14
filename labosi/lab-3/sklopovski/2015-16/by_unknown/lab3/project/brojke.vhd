library ieee;
use ieee.std_logic_1164.all;

entity brojke is
 port (
	mi_left, mi_right, mi_up, mi_down, mi_center: in std_logic; -- ulazi
	code: out std_logic_vector(7 downto 0) -- izlaz
 );
end brojke;


architecture behavioral of brojke is
    signal btns: std_logic_vector(4 downto 0);
begin

    btns <= mi_down & mi_left & mi_center & mi_up & mi_right;

    with btns select
    code <=
        "00000000" when "00000", -- ASCII NULL
		"00000000" when "10000", -- ASCII NULL
		"00110011" when "01000", -- ASCII 3
		"00110110" when "00100", -- ASCII 6
		"00110100" when "00010", -- ASCII 4
		"00111001" when "00001", -- ASCII 9
		"00110000" when "11000", -- ASCII 0
		"00110101" when "10100", -- ASCII 5
		"00110010" when "10010", -- ASCII 2
		"00110101" when "10001", -- ASCII 5
        "--------" when others ; -- ASCII NULL				
end;
