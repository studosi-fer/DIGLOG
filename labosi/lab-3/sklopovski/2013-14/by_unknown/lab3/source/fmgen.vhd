--
-- 25.0 -> 250.0 MHz PLL configuration
--

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

-- synopsys translate_off
library xp2;
use xp2.components.all;
-- synopsys translate_on

entity pll_250m is
    port (
        CLK: in std_logic; 
        CLKOP: out std_logic; 
        LOCK: out std_logic);
 attribute dont_touch : boolean;
 attribute dont_touch of pll_250m : entity is true;
end pll_250m;

architecture Structure of pll_250m is

    -- internal signal declarations
    signal CLKOP_t: std_logic;
    signal scuba_vlo: std_logic;

    -- local component declarations
    component VLO
        port (Z: out std_logic);
    end component;
    component EPLLD1
    -- synopsys translate_off
        generic (CLKOK_BYPASS : in String; CLKOS_BYPASS : in String; 
                CLKOP_BYPASS : in String; DUTY : in Integer; 
                PHASEADJ : in String; PHASE_CNTL : in String; 
                CLKOK_DIV : in Integer; CLKFB_DIV : in Integer; 
                CLKOP_DIV : in Integer; CLKI_DIV : in Integer);
    -- synopsys translate_on
        port (CLKI: in std_logic; CLKFB: in std_logic; RST: in std_logic; 
            RSTK: in std_logic; DPAMODE: in std_logic; DRPAI3: in std_logic; 
            DRPAI2: in std_logic; DRPAI1: in std_logic; DRPAI0: in std_logic; 
            DFPAI3: in std_logic; DFPAI2: in std_logic; DFPAI1: in std_logic; 
            DFPAI0: in std_logic; PWD: in std_logic; CLKOP: out std_logic; 
            CLKOS: out std_logic; CLKOK: out std_logic; LOCK: out std_logic; 
            CLKINTFB: out std_logic);
    end component;
    attribute CLKOK_BYPASS : string; 
    attribute CLKOS_BYPASS : string; 
    attribute FREQUENCY_PIN_CLKOP : string; 
    attribute CLKOP_BYPASS : string; 
    attribute PHASE_CNTL : string; 
    attribute DUTY : string; 
    attribute PHASEADJ : string; 
    attribute FREQUENCY_PIN_CLKI : string; 
    attribute FREQUENCY_PIN_CLKOK : string; 
    attribute CLKOK_DIV : string; 
    attribute CLKOP_DIV : string; 
    attribute CLKFB_DIV : string; 
    attribute CLKI_DIV : string; 
    attribute FIN : string; 
    attribute CLKOK_BYPASS of PLLInst_0 : label is "DISABLED";
    attribute CLKOS_BYPASS of PLLInst_0 : label is "DISABLED";
    attribute FREQUENCY_PIN_CLKOP of PLLInst_0 : label is "250.000000";
    attribute CLKOP_BYPASS of PLLInst_0 : label is "DISABLED";
    attribute PHASE_CNTL of PLLInst_0 : label is "STATIC";
    attribute DUTY of PLLInst_0 : label is "8";
    attribute PHASEADJ of PLLInst_0 : label is "0.0";
    attribute FREQUENCY_PIN_CLKI of PLLInst_0 : label is "25.000000";
    attribute FREQUENCY_PIN_CLKOK of PLLInst_0 : label is "50.000000";
    attribute CLKOK_DIV of PLLInst_0 : label is "2";
    attribute CLKOP_DIV of PLLInst_0 : label is "2";
    attribute CLKFB_DIV of PLLInst_0 : label is "10";
    attribute CLKI_DIV of PLLInst_0 : label is "1";
    attribute FIN of PLLInst_0 : label is "25.000000";
    attribute syn_keep : boolean;
    attribute syn_noprune : boolean;
    attribute syn_noprune of Structure : architecture is true;

begin
    -- component instantiation statements
    scuba_vlo_inst: VLO
        port map (Z=>scuba_vlo);

    PLLInst_0: EPLLD1
        -- synopsys translate_off
        generic map (CLKOK_BYPASS=> "DISABLED", CLKOS_BYPASS=> "DISABLED", 
        CLKOP_BYPASS=> "DISABLED", PHASE_CNTL=> "STATIC", DUTY=>  8, 
        PHASEADJ=> "0.0", CLKOK_DIV=>  2, CLKOP_DIV=>  2, CLKFB_DIV=>  10, 
        CLKI_DIV=>  1)
        -- synopsys translate_on
        port map (CLKI=>CLK, CLKFB=>CLKOP_t, RST=>scuba_vlo, 
            RSTK=>scuba_vlo, DPAMODE=>scuba_vlo, DRPAI3=>scuba_vlo, 
            DRPAI2=>scuba_vlo, DRPAI1=>scuba_vlo, DRPAI0=>scuba_vlo, 
            DFPAI3=>scuba_vlo, DFPAI2=>scuba_vlo, DFPAI1=>scuba_vlo, 
            DFPAI0=>scuba_vlo, PWD=>scuba_vlo, CLKOP=>CLKOP_t, 
            CLKOS=>open, CLKOK=>open, LOCK=>LOCK, CLKINTFB=>open);

    CLKOP <= CLKOP_t;
end Structure;

-- synopsys translate_off
library xp2;
configuration Structure_CON of pll_250m is
    for Structure
        for all:VLO use entity xp2.VLO(V); end for;
        for all:EPLLD1 use entity xp2.EPLLD1(V); end for;
    end for;
end Structure_CON;

-- synopsys translate_on


library IEEE;
use IEEE.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity fmgen is
generic (
	C_fm_acclen: integer := 28;
	C_fdds: real := 250000000.0
);
port (
	clk_25m: in std_logic;
	cw_freq: in std_logic_vector(31 downto 0);
	pwm_in: in std_logic;
	fm_out: out std_logic
);
end fmgen;

architecture x of fmgen is
	signal fm_acc, fm_inc: std_logic_vector((C_fm_acclen - 1) downto 0);
	signal clk_250m: std_logic;

	signal R_pcm, R_pcm_avg: std_logic_vector(15 downto 0);
	signal R_cnt: integer;
	signal R_pwm_in: std_logic;
	signal R_dds_mul_x1, R_dds_mul_x2: std_logic_vector(31 downto 0);
	constant C_dds_mul_y: std_logic_vector(31 downto 0) :=
	    std_logic_vector(conv_signed(integer(2.0**30 / C_fdds * 2.0**28), 32));
	signal R_dds_mul_res: std_logic_vector(63 downto 0);

begin

    --
    -- Instanciraj PLL blok
    --
    I_PLL_250m: entity pll_250m
    port map (
	clk => clk_25m, clkop => clk_250m
    );

    --
    -- PWM -> PCM
    --
    process(clk_25m)
    variable delta: std_logic_vector(15 downto 0);
    variable R_clk_div: std_logic_vector(3 downto 0);
    begin
        delta := x"ffff" - R_pcm;

        if rising_edge(clk_25m) then
            if pwm_in = '1' then
                R_pcm <= R_pcm + (x"00" & delta(15 downto 8));
            else
                R_pcm <= R_pcm - (x"00" & R_pcm(15 downto 8));
            end if;

	    R_clk_div := R_clk_div + 1;
	    if R_clk_div = x"0" then
		if R_pcm > R_pcm_avg then
		    R_pcm_avg <= R_pcm_avg + 1;
		elsif R_pcm < R_pcm_avg then
		    R_pcm_avg <= R_pcm_avg - 1;
		end if;
	    end if;
        end if;
    end process;

    --
    -- Izracun trenutne frekvencije signala nosioca (frekvencijska modulacija)
    --
    process (clk_25m)
    begin
	if (rising_edge(clk_25m)) then
	    R_dds_mul_x1 <= cw_freq + (R_pcm & "0") - (R_pcm_avg & "0");
	end if;
    end process;
	
    --
    -- Generiranje signala nosioca
    --
    process (clk_250m)
    begin
	if (rising_edge(clk_250m)) then
	    -- Cross clock domains
    	    R_dds_mul_x2 <= R_dds_mul_x1;
	    R_dds_mul_res <= R_dds_mul_x2 * C_dds_mul_y;
	    fm_inc <= R_dds_mul_res(57 downto (58 - C_fm_acclen));
	    fm_acc <= fm_acc + fm_inc;
	end if;
    end process;

    fm_out <= fm_acc((C_fm_acclen - 1));
end;


