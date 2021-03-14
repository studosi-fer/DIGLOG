library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity datapath is
    generic (
	C_data_width: integer := 4
    );
    port (
	btn_left, btn_right, btn_center, btn_up, btn_down: in std_logic;
	sw: in std_logic_vector(3 downto 0);
	clk_25m: in std_logic;
	led: out std_logic_vector(7 downto 0)
    );
end datapath;

architecture x of datapath is
    signal AddrA, AddrB, AddrW: std_logic_vector(1 downto 0);
    signal ALUOp: std_logic_vector(2 downto 0);
    signal Clk: std_logic;
    signal A, B, Z, W, Bmux: std_logic_vector((C_data_width - 1) downto 0);

begin

    I_regfile: entity reg_file
    generic map (
	C_data_width => C_data_width
    )
    port map (
	AddrA => AddrA, AddrB => AddrB, AddrW => AddrW,
	WE => '1', Clk => Clk,
	A => A, B => B, W => W
    );

    I_upravljac: entity upravljac
    port map (
	Clk_key => btn_up,
	AddrA_key => btn_left,
	AddrB_key => btn_center,
	ALUOp_key => btn_right,
	clk_25m => clk_25m,
	AddrA => AddrA,
	AddrB => AddrB,
	ALUOp => ALUOp,
	Clk => Clk
    );
    
    led(7 downto 4) <= AddrA & AddrB when btn_down = '0' else A;
    led(3 downto 0) <= Clk & ALUOp when btn_down = '0' else B;
end;
