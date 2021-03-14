library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;


entity afsk_modem is
port (
    clk_25m: in std_logic;
    rs232_rx: in std_logic;
    rs232_tx: out std_logic;
    p_ring: in std_logic;
    p_tip: out std_logic_vector(3 downto 0);
    led: out std_logic_vector(7 downto 0);
    sw: in std_logic_vector(3 downto 0)
);
end afsk_modem;

architecture s of afsk_modem is
    signal modulator_out, demodulator_bias: std_logic_vector(3 downto 0);
    signal modulator_in, demodulator_out, tx_active: std_logic;

begin
    modulator: entity work.afsk_modulator
    port map (
	clk => clk_25m,
	serial_in => modulator_in,
	test_mode => sw(3),
	audio_dac_out => modulator_out,
	tx_active => tx_active
    );

    demodulator: entity work.afsk_demodulator
    port map (
	clk => clk_25m,
	audio_in => p_ring,
	bias_out => demodulator_bias,
	serial_out => demodulator_out
    );

    modulator_in <= rs232_rx when sw(3) = '0' else sw(0);
    p_tip <= modulator_out when tx_active = '1' else demodulator_bias;
    rs232_tx <= rs232_rx when tx_active = '1' else demodulator_out;

    led(0) <= demodulator_out;
    led(1) <= rs232_rx;
    led(2) <= tx_active;
    led(3) <= p_ring;
end;
