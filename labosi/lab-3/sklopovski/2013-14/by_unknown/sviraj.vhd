library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity sviraj is
    port (
	clk_25m: in std_logic;
	sw: in std_logic_vector(3 downto 0);
	btn_left, btn_right, btn_up, btn_down, btn_center: in std_logic;
	led: out std_logic_vector(7 downto 0);
	p_tip: out std_logic_vector(3 downto 0);
	p_ring: out std_logic
    );
end sviraj;


architecture behavioral of sviraj is
    signal code: std_logic_vector(6 downto 0);
    signal tone_out: std_logic;

begin
    I_tonegen: entity tonegen
    port map (
	clk_25m => clk_25m, code => code, volume => sw(1 downto 0),
	tone_out => tone_out
    );

    I_enkoder: entity enkoder
    port map (
	btn_up => btn_up, btn_right => btn_right, btn_left => btn_left,
	btn_down => btn_down, btn_center => btn_center,
	code => code
    );

    led <= '0' & code;

    p_ring <= tone_out;
    p_tip(3) <= tone_out;
    p_tip(2) <= tone_out;
    p_tip(1) <= tone_out;
    p_tip(0) <= tone_out;
end;
