library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity sviraj is port (
	clk_25m: in std_logic;
	sw: in std_logic_vector(3 downto 0);
	btn_left, btn_right, btn_up, btn_down, btn_center: in std_logic;
	led: out std_logic_vector(7 downto 0);
	p_tip: out std_logic_vector(3 downto 0);
	p_ring: out std_logic;
	j2: out std_logic_vector (5 downto 2) );
end sviraj;


architecture behavioral of sviraj is
	signal code: std_logic_vector(6 downto 0);
	signal tone_out: std_logic;
	signal tone_out1: std_logic;
	signal mux1: std_logic_vector (6 downto 0);
	signal mux2: std_logic_vector (6 downto 0);
	signal s: std_logic_vector (6 downto 0);
	signal comp: std_logic;
	signal fm_out:std_logic;
	signal cw_freq: std_logic_vector (31 downto 0);


begin
	I_enkoder: entity enkoder port map (
	btn_up => btn_up, btn_right => btn_right, btn_left => btn_left, btn_down => btn_down, btn_center => btn_center, code => code
	);

	I_tonegen: entity tonegen port map (
	clk_25m => clk_25m, code => code, volume => sw(1 downto 0), tone_out => tone_out
	);

	II_tonegen: entity tonegen port map (
	clk_25m => clk_25m, volume => sw(1 downto 0), tone_out => tone_out1, code => mux2
	);

	fmgen: entity fmgen port map (
	clk_25m=>clk_25m, pwm_in =>tone_out1, fm_out => fm_out, cw_freq => std_logic_vector (to_unsigned(106400000, 32))
	);

	comp <= '1' when code = "0000000" else '0';

	with sw (3 downto 2) select
	mux1 <= "0000011" when "00",
	"0000100" when "01",
	"0000101" when "10",
	"0000111" when "11";

	s<= code + mux1;

	with comp select
	mux2 <= code when '1',
	s when '0';

	j2(5) <= fm_out;
	j2(4) <= fm_out;
	j2(3) <= fm_out;
	j2(2) <= fm_out;

	led <= '0' & code;

	p_ring <= tone_out1;
	p_tip(3) <= tone_out;
	p_tip(2) <= tone_out;
	p_tip(1) <= tone_out;
	p_tip(0) <= tone_out;
end;
