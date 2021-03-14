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
    signal code: std_logic_vector(7 downto 0);
    signal mux1: std_logic_vector(7 downto 0);
    signal mux2: std_logic_vector(7 downto 0);
    signal btns: std_logic_vector(4 downto 0);
    

begin
     
    btns <= btn_down & btn_left & btn_center & btn_up & btn_right;
    
    with btns select
    mux1 <=
        "00000000" when "00000", -- ASCII NULL
        "00000000" when "10000", -- ASCII NULL
	"01001001" when "01000", -- ASCII I
	"01110110" when "00100", -- ASCII v
	"01100001" when "00010", -- ASCII a
	"01101110" when "00001", -- ASCII n
	"01010110" when "11000", -- ASCII V
	"01110101" when "10100", -- ASCII u
	"01100111" when "10010", -- ASCII g
	"01100101" when "10001", -- ASCII e
	"--------" when others;
	
	with sw(0) select
	code <=
		mux1 when '0',
		mux2 when '1';
	
  
    led <= code;

    serializer: entity serial_tx port map (
	clk => clk_25m, byte_in => code, ser_out => rs232_tx
    );
    
    m1: entity brojke port map(
    iv_left => btn_left,
    iv_right => btn_right, 
    iv_center => btn_center, 
    iv_up => btn_up,
    iv_down => btn_down,
    iv_code => mux2
    );
end;
