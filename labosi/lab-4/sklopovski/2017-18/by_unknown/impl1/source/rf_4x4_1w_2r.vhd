library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity reg_file is
    generic (
	C_data_width: integer := 4
    );
    port (
	AddrA, AddrB, AddrW: in std_logic_vector(1 downto 0);
	WE: in std_logic;
	Clk: in std_logic;
	W: in std_logic_vector((C_data_width - 1) downto 0);
	A, B: out std_logic_vector((C_data_width - 1) downto 0)
    );
end reg_file;

architecture x of reg_file is
    signal R0, R1, R2, R3: std_logic_vector((C_data_width - 1) downto 0);
    signal WE_demuxed: std_logic_vector(3 downto 0);

begin

    --
    -- Registri
    --
    R0 <= W when rising_edge(Clk) and WE_demuxed(0) = '1';
    R1 <= W when rising_edge(Clk) and WE_demuxed(1) = '1';
    R2 <= W when rising_edge(Clk) and WE_demuxed(2) = '1';
    R3 <= W when rising_edge(Clk) and WE_demuxed(3) = '1';

    --
    -- Demux za WE signale
    --
    with AddrW select
    WE_demuxed <=
	"000" & WE      when "00",
	"00" & WE & '0' when "01",
	'0' & WE & "00" when "10",
	WE & "000"      when "11";

    --
    -- Mux za izlazni port "A"
    --
    with AddrA select
    A <=
	R0 when "00",
	R1 when "01",
	R2 when "10",
	R3 when "11";

    --
    -- Mux za izlazni port "B"
    --
    with AddrB select
    B <=
	R0 when "00",
	R1 when "01",
	R2 when "10",
	R3 when "11";

end;
