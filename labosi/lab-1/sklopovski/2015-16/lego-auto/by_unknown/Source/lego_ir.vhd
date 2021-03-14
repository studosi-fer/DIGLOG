library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity lego_ir is
    generic (
	C_clk_freq: integer := 25000000
    );
    port (
	clk: in std_logic;
	ch: in std_logic_vector(1 downto 0);
	pwm_a, pwm_b: in std_logic_vector(3 downto 0);
	ir: out std_logic
    );
end lego_ir;


architecture arch of lego_ir is
    constant C_irfreq_incr: integer :=
      integer((16777216.0 * 38000.0) / Real(C_clk_freq)); -- 2^24 * Fir / Fclk

    signal nibble_1, nibble_2, nibble_3, lrc: std_logic_vector(3 downto 0);
    signal irfreq_acc_next: std_logic_vector(23 downto 0);

    signal R_irfreq_acc: std_logic_vector(23 downto 0);
    signal R_tx_word: std_logic_vector(15 downto 0);
    signal R_phase: std_logic_vector(4 downto 0);
    signal R_delay_acc, R_delay_lim: std_logic_vector(15 downto 0);

begin

    nibble_1 <= "01" & ch;
    nibble_2 <= pwm_b;
    nibble_3 <= pwm_a;
    lrc <= x"f" xor nibble_1 xor nibble_2 xor nibble_3;
    irfreq_acc_next <= R_irfreq_acc + C_irfreq_incr;

    process(clk)
    begin
    if rising_edge(clk) then
	R_irfreq_acc <= irfreq_acc_next;
	if R_irfreq_acc(23) = '0' and irfreq_acc_next(23) = '1' then
	    -- 38 kHz event
	    if R_delay_acc /= R_delay_lim then
		R_delay_acc <= R_delay_acc + 1;
	    else
		-- next phase
		R_delay_acc <= x"0000";
		if R_phase(4) = '0' then
		    -- code word
		    if R_tx_word(15) = '1' then
			R_delay_lim <= conv_std_logic_vector(26, 16);
		    else
			R_delay_lim <= conv_std_logic_vector(15, 16);
		    end if;
		else
		    if R_phase = "10001" then
			-- pause
			R_delay_lim <= conv_std_logic_vector(3800, 16);
		    else
			-- start or stop
			R_delay_lim <= conv_std_logic_vector(44, 16);
		    end if;
		end if;
		if R_phase = "10010" then
		    R_tx_word <= nibble_1 & nibble_2 & nibble_3 & lrc;
		    R_phase <= "00000";
		else
		    R_tx_word(15 downto 1) <= R_tx_word(14 downto 0);
		    R_phase <= R_phase + 1;
		end if;
	    end if;
	end if;
	if R_delay_acc <= "00101" and R_phase /= "10010" then
	    ir <= R_irfreq_acc(23);
	else
	    ir <= '0';
	end if;
    end if;
    end process;

end;
