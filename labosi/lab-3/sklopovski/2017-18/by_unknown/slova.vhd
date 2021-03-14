library ieee;
use ieee.std_logic_1164.all;

entity slova is
    port (
        btn_left, btn_right, btn_up, btn_down, btn_center: in std_logic;
	rs232_tx: out std_logic;
	clk_25m: in std_logic;
        led: out std_logic_vector(7 downto 0)
    );
end slova;


architecture behavioral of slova is
    signal code: std_logic_vector(7 downto 0);
    signal btns: std_logic_vector(4 downto 0);

begin

    btns <= btn_down & btn_left & btn_center & btn_up & btn_right;

    with btns select
    code <=
        "00000000" when "00000", -- ASCII NULL
        "01000001" when others ; -- ASCII A

    led <= code;

    serializer: entity serial_tx port map (
	clk => clk_25m, byte_in => code, ser_out => rs232_tx
    );
end;
