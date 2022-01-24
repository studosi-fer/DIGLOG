library ieee;
use ieee.std_logic_1164.all;

entity slova is
    port (
        btn_left, btn_right, btn_up, btn_down, btn_center: in std_logic;
		rs232_tx: out std_logic;
		clk_25m: in std_logic;
        led: out std_logic_vector(7 downto 0);
		sw: in std_logic_vector(3 downto 0)
    );
end slova;


architecture behavioral of slova is
    signal code, mux1, mux2: std_logic_vector(7 downto 0);
    signal btns: std_logic_vector(4 downto 0);
begin
	
    btns <= btn_down & btn_left & btn_center & btn_up & btn_right;
	
    with btns select
    mux1 <=
        "00000000" when "00000", -- ASCII NULL
		"00000000" when "10000", -- ASCII NULL
		"01001101" when "01000", -- ASCII M
		"01101001" when "00100", -- ASCII i
		"01101000" when "00010", -- ASCII h
		"01101111" when "00001", -- ASCII o
		"01001001" when "11000", -- ASCII I
		"01101100" when "10100", -- ASCII l
		"01100001" when "10010", -- ASCII a
		"01101011" when "10001", -- ASCII k
        "--------" when others ; -- ASCII NULL	
		
	-- ako je sw(0) jedanko '0' onda code neka bude rezultat s  brojki
	-- inace neka code bude rezultat iz slova
	with sw(0) select
	code <=
        mux1 when '0',
        mux2 when '1';

    led <= code;

    serializer: entity serial_tx port map (
		clk => clk_25m, byte_in => code, ser_out => rs232_tx
    );
	--instanciramo brojke
	inst_brojke: entity brojke port map (
		mi_up => btn_up, mi_right => btn_right, mi_left => btn_left, mi_down => btn_down, mi_center => btn_center, code => mux2
	);
	
end;
