library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity sem is
    port(
	led: out std_logic_vector(7 downto 0);
	btn_down: in std_logic; -- vanjski reset signal
	sw: in std_logic_vector(3 downto 0);
	clk_25m: in std_logic
    );
end sem;

architecture struct of sem is
    signal R_clk_div: std_logic_vector(23 downto 0);
    signal clk: std_logic;
begin

    -- Generator takta cca. 1.5 Hz (25 MHz / 2^24)
    R_clk_div <= R_clk_div + 1 when rising_edge(clk_25m);
    clk <= R_clk_div(23);

    -- Automat za upravljanje semaforom
    I_automat: entity work.sem_automat
    port map (
	clk => clk, vanjski_reset => btn_down,
	aR => led(7),
	aY => led(6),
	aG => led(5),
	pR => led(3),
	pG => led(2)
    );

    led(4) <= '0';
    led(1) <= '0';
    led(0) <= clk and sw(0);
end struct;
