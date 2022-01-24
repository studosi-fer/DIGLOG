library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity afsk_modulator is
	port 
	(
		serial_in, test_mode: in std_logic;
		clk: in std_logic;
		tx_active: out std_logic;
		audio_dac_out: out std_logic_vector(3 downto 0)
	);
end afsk_modulator;

architecture x of afsk_modulator is
    signal muxout : std_logic_vector(31 downto 0);
	signal R_tx_acc : std_logic_vector(31 downto 0);
	constant c0: std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(377957, 32));
	constant c1: std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(206160, 32));
	type sin_rom_type is array(0 to 15) of std_logic_vector(3 downto 0);
	constant sin_map: sin_rom_type :=
	(
		x"8", x"b", x"d", x"e", x"f", x"e",x"d", x"a",
		x"7", x"4", x"2", x"1", x"0", x"1", x"2", x"5"
	);

begin
	
	muxout <= c0 when serial_in= '0' else c1;
	
    process(clk)	
		begin
			if rising_edge(clk) then
				R_tx_acc <= R_tx_acc + muxout;
			end if;
	end process;

    process(clk, test_mode, serial_in)
		variable cnt : integer := 0;
		begin
			if rising_edge(clk) then
				if test_mode = '1' then
					tx_active <= '1';
					cnt := 0;
				elsif serial_in = '0' then --logical 1
					cnt := 0;
				elsif serial_in = '1' then --logical 0
					if cnt >= 50000000 then
						tx_active <= '0';
					end if;
					cnt := cnt + 1;
				end if;
			end if;
	end process;
	
	audio_dac_out <= sin_map(conv_integer(R_tx_acc(31 downto 28)));
end;