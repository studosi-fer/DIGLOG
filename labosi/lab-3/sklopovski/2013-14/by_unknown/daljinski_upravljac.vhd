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
    signal naprijed, natrag, motor: std_logic;

begin

    motor <= btn_up and btn_down and not btn_center;

    naprijed <= btn_up and not btn_center;
    natrag <= btn_down and not btn_center;

    odasiljac: entity rf_modulator
    port map (
	clk => clk_25m,
	kanal => sw(1 downto 0), brzina => sw(3 downto 2),
	naprijed => naprijed, natrag => natrag,
	lijevo => '0', desno => '0',
	top_lijevo => '0', top_desno => '0',
	top_zvuk => '0', top_visina => '0',
	top_granata => '0', strojnica => '0',
	motor => motor, rf => rf
    );

    -- Izlazni FM signal
    p_tip <= rf & rf & rf & rf;
    p_ring <= rf;
end;
