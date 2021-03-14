library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;


entity afsk_demodulator is
port (
    clk: in std_logic;
    audio_in: in std_logic;
    bias_out: out std_logic_vector(3 downto 0);
    serial_out: out std_logic
);
end afsk_demodulator;

architecture x of afsk_demodulator is
    signal R_audio_in, R_hyster, R_hyster_prev: std_logic;
    signal R_hyster_cnt, R_cycle_div: std_logic_vector(11 downto 0);
    signal R_zero_cross_sr: std_logic_vector(31 downto 0);
    signal R_zero_cross_cnt: std_logic_vector(5 downto 0);

begin

    process(clk)
    begin
	if rising_edge(clk) then
	    R_audio_in <= audio_in;
	    if R_audio_in = '0' and R_hyster_cnt /= x"000" then
		R_hyster_cnt <= R_hyster_cnt - 1;
	    end if;
	    if R_audio_in = '1' and R_hyster_cnt /= x"1ff" then
		R_hyster_cnt <= R_hyster_cnt + 1;
	    end if;
	    if R_hyster_cnt = x"000" then
		R_hyster <= '0';
	    end if;
	    if R_hyster_cnt = x"1ff" then
		R_hyster <= '1';
	    end if;
	    if R_cycle_div /= 0 then
		R_cycle_div <= R_cycle_div - 1;
		if R_zero_cross_sr(0) = '0' and
		  R_hyster /= R_hyster_prev then
		    R_zero_cross_cnt <= R_zero_cross_cnt + 1;
		    R_zero_cross_sr(0) <= '1';
		    R_hyster_prev <= R_hyster;
		end if;
	    else
		R_cycle_div <= x"248"; -- XXX empirijski odredjen prag
		if R_zero_cross_sr(31) = '1' then
		    R_zero_cross_cnt <= R_zero_cross_cnt - 1;
		end if;
		R_zero_cross_sr <= R_zero_cross_sr(30 downto 0) & '0';
		if R_zero_cross_cnt > x"02" then
		    serial_out <= '0';
		else
		    serial_out <= '1';
		end if;
	    end if;
	end if;
    end process;

    bias_out <= x"7";

end;
