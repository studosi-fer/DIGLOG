library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity tenk_toplevel is
    port (
	clk_25m: in std_logic;
	sw: in std_logic_vector(1 downto 0);
	btn_up, btn_down, btn_center: in std_logic;
	led: out std_logic_vector(7 downto 0);
	p_tip: out std_logic_vector(3 downto 0);
	p_ring: out std_logic
    );
end tenk_toplevel;

architecture arch of tenk_toplevel is
    signal R_clk_div: std_logic_vector(23 downto 0);
    signal clk, rf, start, stop: std_logic;
    signal brzina: std_logic_vector(1 downto 0);
    signal motor, strojnica: std_logic;
    signal top_lijevo, top_desno, top_visina, top_zvuk: std_logic;
    signal naprijed, natrag, lijevo, desno: std_logic;

begin

    -- Generator takta cca. 1.5 Hz (25 MHz / 2^24)
    R_clk_div <= R_clk_div + 1 when rising_edge(clk_25m);
    clk <= R_clk_div(23);
    led(7) <= clk;

    automat: entity work.tenk_automat
    port map (
	clk => clk,
	start => btn_up, stop => btn_down,
	brzina => brzina,
	naprijed => naprijed, natrag => natrag,
	lijevo => lijevo, desno => desno,
	top_lijevo => top_lijevo, top_desno => top_desno,
	top_zvuk => top_zvuk, top_visina => top_visina,
	strojnica => strojnica, motor => motor,
	stanje => led(6 downto 0)
    );

    odasiljac: entity work.rf_modulator
    port map (
	clk => clk_25m,
	kanal => sw(1 downto 0),
	brzina => brzina,
	naprijed => naprijed, natrag => natrag,
	lijevo => lijevo, desno => desno,
	top_lijevo => top_lijevo, top_desno => top_desno,
	top_zvuk => top_zvuk, top_visina => top_visina,
	top_granata => '0',
	strojnica => strojnica, motor => motor,
	rf => rf
    );

    -- Izlazni FM signal
    p_tip <= rf & rf & rf & rf;
    p_ring <= rf;
end;
