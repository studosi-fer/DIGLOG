library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity enkoder is
    port (
	btn_left, btn_right, btn_up, btn_down, btn_center: in std_logic;
	code: out std_logic_vector(6 downto 0)
    );
end enkoder;


architecture behavioral of enkoder is
    signal btns: std_logic_vector(4 downto 0);

begin

    btns <= btn_down & btn_left & btn_center & btn_up & btn_right;

    with btns select
    code <=--ovo vrijedi samo za moj jmbag!!!!!!!!!!!!
		"0000000" when "00000", -- no tone
        "0000000" when "10000", -- no tone
        "1001010" when "01000", -- MIDI #74
        "1001100" when "00100", -- MIDI #76
        "1001101" when "00010", -- MIDI #77
        "1001111" when "00001", -- MIDI #79
        "1010001" when "11000", -- MIDI #81
        "1010010" when "10100", -- MIDI #82
        "1010100" when "10010", -- MIDI #84
        "1010110" when "10001", -- MIDI #86
        "-------" when others ; -- don't care 

end;
