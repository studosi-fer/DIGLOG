library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity broj is
    port (
	clk_25m: in std_logic;
	btn_down, btn_up: in std_logic;
	led: out std_logic_vector(7 downto 0)
    );
end broj;

architecture x of broj is
    signal R: std_logic_vector(7 downto 0);
    signal Clk: std_logic;

begin
	process(Clk, btn_up)
	begin
		if rising_edge(Clk) then
			R <= R + 1 ;
		end if;
		
		if btn_up = '1' then
			R <= "00000000";
		end if;
	end process;
	
    
    I_upravljac: entity upravljac
    port map (
	Clk_key => btn_down,
	Clk => Clk,
	clk_25m => clk_25m,
	AddrA_key => '0',
	AddrB_key => '0',
	ALUOp_key => '0',
	AddrA => open,
	AddrB => open,
	ALUOp => open
	);
	
	  led <= R;
    
end x;
