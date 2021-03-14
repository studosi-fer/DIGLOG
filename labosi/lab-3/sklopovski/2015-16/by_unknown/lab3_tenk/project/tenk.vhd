library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
entity daljinski_upravljac is
 port (
 clk_25m: in std_logic;
 sw: in std_logic_vector(3 downto 0);
 btn_left, btn_right, btn_up, btn_down, btn_center: in std_logic;
 p_tip: out std_logic_vector(3 downto 0);
 p_ring: out std_logic
 );
end daljinski_upravljac;
architecture behavioral of daljinski_upravljac is
 signal rf: std_logic;
 signal naprijed, natrag, motor, lijevo, desno, top_lijevo, top_desno, top_visina, top_zvuk, strojnica: std_logic;
begin
 motor <= btn_up and btn_down and not btn_center;
 naprijed <= btn_up and not btn_center;
 natrag <= btn_down and not btn_center;
 lijevo <= btn_left AND NOT btn_center;
 desno <= btn_right AND NOT btn_center;
 top_lijevo <= btn_left AND btn_center;
 top_desno <= btn_right AND btn_center;
 top_visina <= btn_down AND btn_center;
 top_zvuk <= btn_up AND btn_center;
 strojnica <= btn_left AND btn_right;
 
 odasiljac: entity rf_modulator
 port map (
	 clk => clk_25m,
	 kanal => sw(1 downto 0), brzina => sw(3 downto 2),
	 naprijed => naprijed, natrag => natrag,
	 lijevo => lijevo, desno => desno,
	 top_lijevo => top_lijevo, top_desno => top_desno,
	 top_zvuk => top_zvuk, top_visina => top_visina,
	 top_granata => '0', strojnica => strojnica,
	 motor => motor, rf => rf
 );
 -- Izlazni FM signal
 p_tip <= rf & rf & rf & rf; -- grupiranje jednobitnih u visebitni signal
 p_ring <= rf;
end;