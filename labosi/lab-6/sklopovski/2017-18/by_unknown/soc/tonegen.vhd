library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity tonegen is
generic (
    C_clk_freq: integer := 25000000
);
port (
    clk: in std_logic;
    code: in std_logic_vector(6 downto 0);
    volume: in std_logic_vector(1 downto 0);
    tone_out: out std_logic
);
end tonegen;

architecture x of tonegen is
    constant C_midi_127_freq: integer := 12544;
    constant C_midi_117_freq: integer := 7040;

    signal R_code: std_logic_vector(6 downto 0);
    signal R_tone_incr: std_logic_vector(31 downto 0);
    signal R_tone_incr_new: std_logic_vector(31 downto 0);
    signal R_tone_acc: std_logic_vector(31 downto 0);
    signal R_vol_acc: std_logic_vector(3 downto 0);
    signal R_out: std_logic;

    signal mul64: std_logic_vector(63 downto 0);

begin
    mul64 <= R_tone_incr_new * x"f1a1bf28"; -- 2^(32 - 1/12)

    process(clk)
    begin
    if rising_edge(clk) then
	if R_code = "1111111" then
	    if code = "0000000" then
		R_tone_incr <= (others => '0');
	    else
		R_code <= code;
		R_tone_incr_new <= x"00080000";
--		R_tone_incr_new <= std_logic_vector(to_unsigned((2 ** 31) /
--		  C_clk_freq * C_midi_127_freq * 2, 32));
		R_tone_incr <= R_tone_incr_new;
	    end if;
	elsif R_code <= "1110011" then
	    R_code <= R_code + 12;
	    R_tone_incr_new <= '0' & R_tone_incr_new(31 downto 1);
	else
	    R_code <= R_code + 1;
	    R_tone_incr_new <= mul64(63 downto 32);
	end if;

	R_tone_acc <= R_tone_acc + R_tone_incr;
	R_vol_acc <= R_vol_acc + 1;

	if volume >= R_vol_acc then
	    R_out <= R_tone_acc(R_tone_acc'high);
	else
	    R_out <= '0';
	end if;
    end if;
    end process;

    tone_out <= R_out and clk;
end;
