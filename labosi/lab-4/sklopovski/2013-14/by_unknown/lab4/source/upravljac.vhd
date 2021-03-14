library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;


entity upravljac is
    port (
	Clk_key, AddrA_key, AddrB_key, ALUOp_key: in std_logic;
	clk_25m: in std_logic;
	AddrA, AddrB: out std_logic_vector(1 downto 0);
	ALUOp: out std_logic_vector(2 downto 0);
	Clk: out std_logic
    );
end upravljac;

architecture x of upravljac is
    signal R_AddrA, R_AddrB: std_logic_vector(1 downto 0);
    signal R_ALUOp: std_logic_vector(2 downto 0);
    signal R_debounce_cnt: integer;
    signal R_keys_last: std_logic_vector(3 downto 0);
    signal keys_in: std_logic_vector(3 downto 0);

begin
    keys_in <= Clk_key & AddrA_key & AddrB_key & ALUOp_key;

    process(clk_25m)
    begin
	if rising_edge(clk_25m) then
	    if R_keys_last /= keys_in then
		R_debounce_cnt <= R_debounce_cnt - 1;
		if R_debounce_cnt < 0 then
		    if keys_in(2) = '1' and R_keys_last(2) = '0' then
			R_AddrA <= R_AddrA + 1;
		    end if;
		    if keys_in(1) = '1' and R_keys_last(1) = '0' then
			R_AddrB <= R_AddrB + 1;
		    end if;
		    if keys_in(0) = '1' and R_keys_last(0) = '0' then
			R_ALUOp <= R_ALUOp + 1;
		    end if;
		    R_keys_last <= keys_in;
		end if;
	    else
		R_debounce_cnt <= 500000; -- 20 ms @ 25 MHz clk_25m
	    end if;
	end if;
    end process;

    Clk <= R_keys_last(3);
    AddrA <= R_AddrA;
    AddrB <= R_AddrB;
    ALUOp <= R_ALUOp;
end;
