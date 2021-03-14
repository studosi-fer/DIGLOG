--
-- Copyright (c) 2012 University of Zagreb.
--
-- Permission is hereby granted, free of charge, to any person obtaining a
-- copy of this software and associated documentation files (the "Software"),
-- to deal in the Software without restriction, including without limitation
-- the rights to use, copy, modify, merge, publish, distribute, sublicense,
-- and/or sell copies of the Software, and to permit persons to whom the
-- Software is furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included
-- in all copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
-- OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
-- THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
-- FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-- DEALINGS IN THE SOFTWARE.
--

-- $Id: rf_modulator.vhd 962 2012-03-09 18:02:55Z marko $


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;
-- synopsys translate_off
library xp2;
use xp2.components.all;
-- synopsys translate_on


entity rf_modulator is
    generic (
	C_speed_bias: integer := 1;
	C_okret_u_mjestu: boolean := true;
	C_inercija: boolean := true
    );
    port (
	clk: in std_logic;
	kanal: in std_logic_vector(1 downto 0);
	brzina: in std_logic_vector(1 downto 0);
	naprijed, natrag, lijevo, desno: in std_logic;
	top_lijevo, top_desno, top_visina: in std_logic;
	top_zvuk, top_granata: in std_logic;
	strojnica, motor: in std_logic;
	rf: out std_logic
    );
end rf_modulator;

architecture Structure of rf_modulator is
    -- local component declarations
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
    attribute CLKOK_DIV : string; 
    attribute CLKOP_DIV : string; 
    attribute CLKFB_DIV : string; 
    attribute CLKI_DIV : string; 
    attribute FIN : string; 
    attribute CLKOK_BYPASS of PLLInst_0 : label is "DISABLED";
    attribute CLKOS_BYPASS of PLLInst_0 : label is "DISABLED";
    attribute FREQUENCY_PIN_CLKOP of PLLInst_0 : label is "200.000000";
    attribute CLKOP_BYPASS of PLLInst_0 : label is "DISABLED";
    attribute PHASE_CNTL of PLLInst_0 : label is "STATIC";
    attribute DUTY of PLLInst_0 : label is "8";
    attribute PHASEADJ of PLLInst_0 : label is "0.0";
    attribute FREQUENCY_PIN_CLKI of PLLInst_0 : label is "25.000000";
    attribute CLKOK_DIV of PLLInst_0 : label is "2";
    attribute CLKOP_DIV of PLLInst_0 : label is "4";
    attribute CLKFB_DIV of PLLInst_0 : label is "8";
    attribute CLKI_DIV of PLLInst_0 : label is "1";
    attribute FIN of PLLInst_0 : label is "25.000000";
    attribute syn_keep : boolean;
    attribute syn_noprune : boolean;
    attribute syn_noprune of Structure : architecture is true;

    constant C_fm_acclen: integer := 28; -- uvjetuje preciznost DDS-a
    constant C_clk_freq: integer := 200000000;
    constant C_clk_freq_real: real := 200000000.0;
    constant C_fm_dev: real := 1500.0; -- FM devijacija, Hz
    constant C_baud_2: std_logic_vector(15 downto 0) := std_logic_vector(conv_signed(integer(C_clk_freq_real / 3200.0), 16));

    constant C_ch1_freq: real := 27145000.0; -- MHz
    constant C_ch2_freq: real := 27195000.0; -- MHz
    constant C_ch3_freq: real := 27095000.0; -- MHz
    constant C_ch4_freq: real := 27550000.0; -- MHz

    constant C_ch1_low: std_logic_vector((C_fm_acclen - 1) downto 0) := std_logic_vector(conv_signed(integer((C_ch1_freq - C_fm_dev) / C_clk_freq_real * (2.0 ** C_fm_acclen)), C_fm_acclen));
    constant C_ch1_high: std_logic_vector((C_fm_acclen - 1) downto 0) := std_logic_vector(conv_signed(integer((C_ch1_freq + C_fm_dev) / C_clk_freq_real * (2.0 ** C_fm_acclen)), C_fm_acclen));
    constant C_ch2_low: std_logic_vector((C_fm_acclen - 1) downto 0) := std_logic_vector(conv_signed(integer((C_ch2_freq - C_fm_dev) / C_clk_freq_real * (2.0 ** C_fm_acclen)), C_fm_acclen));
    constant C_ch2_high: std_logic_vector((C_fm_acclen - 1) downto 0) := std_logic_vector(conv_signed(integer((C_ch2_freq + C_fm_dev) / C_clk_freq_real * (2.0 ** C_fm_acclen)), C_fm_acclen));
    constant C_ch3_low: std_logic_vector((C_fm_acclen - 1) downto 0) := std_logic_vector(conv_signed(integer((C_ch3_freq - C_fm_dev) / C_clk_freq_real * (2.0 ** C_fm_acclen)), C_fm_acclen));
    constant C_ch3_high: std_logic_vector((C_fm_acclen - 1) downto 0) := std_logic_vector(conv_signed(integer((C_ch3_freq + C_fm_dev) / C_clk_freq_real * (2.0 ** C_fm_acclen)), C_fm_acclen));
    constant C_ch4_low: std_logic_vector((C_fm_acclen - 1) downto 0) := std_logic_vector(conv_signed(integer((C_ch4_freq - C_fm_dev) / C_clk_freq_real * (2.0 ** C_fm_acclen)), C_fm_acclen));
    constant C_ch4_high: std_logic_vector((C_fm_acclen - 1) downto 0) := std_logic_vector(conv_signed(integer((C_ch4_freq + C_fm_dev) / C_clk_freq_real * (2.0 ** C_fm_acclen)), C_fm_acclen));

    signal R_fm_acc, R_fm_inc: std_logic_vector((C_fm_acclen - 1) downto 0);
    signal R_low_high: std_logic;
    signal R_clk_acc: std_logic_vector(15 downto 0);
    signal R_speed_acc: std_logic_vector(4 downto 0);
    signal R_phase_acc: std_logic_vector(7 downto 0);
    signal R_outw: std_logic_vector(31 downto 0);
    signal R_brzina: std_logic_vector(3 downto 0);
    signal R_skretanje: std_logic;
    signal R_naprijed, R_natrag, R_lijevo, R_desno: std_logic;

    signal clk_pll, fm: std_logic;
    signal left_right, fwd_rev: std_logic_vector(4 downto 0);

    signal channel: std_logic_vector(1 downto 0);
    signal drive_fwd_rev: std_logic_vector(4 downto 0);
    signal drive_left_right: std_logic_vector(4 downto 0);
    signal gun_left: std_logic;
    signal gun_right: std_logic;
    signal gun_elev: std_logic;
    signal gun_sound: std_logic;
    signal gun_fire_bb: std_logic;
    signal machinegun_sound: std_logic;
    signal ignition_key: std_logic;

begin
    -- component instantiation statements
    PLLInst_0: EPLLD1
        -- synopsys translate_off
        generic map (CLKOK_BYPASS=> "DISABLED", CLKOS_BYPASS=> "DISABLED", 
        CLKOP_BYPASS=> "DISABLED", PHASE_CNTL=> "STATIC", DUTY=>  8, 
        PHASEADJ=> "0.0", CLKOK_DIV=>  2, CLKOP_DIV=>  4, CLKFB_DIV=>  8, 
        CLKI_DIV=>  1)
        -- synopsys translate_on
        port map (CLKI => clk, CLKFB => clk_pll, RST => '0', 
            RSTK => '0', DPAMODE => '0', DRPAI3 => '0', 
            DRPAI2 => '0', DRPAI1 => '0', DRPAI0 => '0', 
            DFPAI3 => '0', DFPAI2 => '0', DFPAI1 => '0', 
            DFPAI0 => '0', PWD=> '0', CLKOP => clk_pll, 
            CLKOS => open, CLKOK => open, LOCK => open, CLKINTFB =>open);

    channel <= kanal;
    drive_fwd_rev <= fwd_rev;
    drive_left_right <= left_right;
    gun_left <= top_lijevo and not top_desno;
    gun_right <= top_desno and not top_lijevo;
    gun_elev <= top_visina and not top_zvuk;
    gun_sound <= top_zvuk and not top_visina;
    gun_fire_bb <= top_granata;
    machinegun_sound <= strojnica;
    ignition_key <= motor;
    
    process(R_brzina, R_naprijed, R_natrag, R_lijevo, R_desno)
    begin
    fwd_rev <= "10000";
    left_right <= "10000";
    if R_naprijed = '1' and R_natrag = '0' and R_lijevo = R_desno then
	fwd_rev <= "10011" + R_brzina;
    end if;
    if R_naprijed = '1' and R_natrag = '0' and
      R_lijevo = '1' and R_desno = '0' then
	fwd_rev <= "10100" + R_brzina;
	left_right <= "10011";
    end if;
    if R_naprijed = '1' and R_natrag = '0' and
      R_lijevo = '0' and R_desno = '1' then
	fwd_rev <= "10100" + R_brzina;
	left_right <= "01101";
    end if;
    if R_naprijed = '0' and R_natrag = '0' and
      R_lijevo = '1' and R_desno = '0' then
	fwd_rev <= "10100" + R_brzina;
	left_right <= "11000";
    end if;
    if R_naprijed = '0' and R_natrag = '0' and
      R_lijevo = '0' and R_desno = '1' then
	fwd_rev <= "10100" + R_brzina;
	left_right <= "01000";
    end if;
    if R_naprijed = '0' and R_natrag = '1' and
      R_lijevo = '1' and R_desno = '0' then
	if C_okret_u_mjestu then
            left_right <= "01001" - R_brzina;
	else
	    fwd_rev <= "01100" - R_brzina;
	    left_right <= "11000";
	end if;
    end if;
    if R_naprijed = '0' and R_natrag = '1' and
      R_lijevo = '0' and R_desno = '1' then
	if C_okret_u_mjestu then
            left_right <= "10111" + R_brzina;
	else
	    fwd_rev <= "01100" - R_brzina;
	    left_right <= "01000";
	end if;
    end if;
    if R_naprijed = '0' and R_natrag = '1' and R_lijevo = R_desno then
	fwd_rev <= "01101" - R_brzina;
    end if;
    end process;

    -- Generiranje modulirajuceg signala
    process(clk_pll)
    variable tx_csum: std_logic_vector(3 downto 0);
    begin
    tx_csum := "0100" xor (not gun_left & not gun_elev & (not gun_sound xor
      not ignition_key xor not gun_fire_bb) & not machinegun_sound) xor
      ("000" & not gun_right) xor (drive_fwd_rev(1 downto 0) & "00") xor
      ('0' & drive_fwd_rev(4 downto 2)) xor drive_left_right(3 downto 0) xor
      ("000" & drive_left_right(4));
    if rising_edge(clk_pll) then
	if R_clk_acc = C_baud_2 then
	    R_clk_acc <= x"0000";
	    if R_phase_acc = x"4f" then
		R_phase_acc <= x"00";
		R_outw <= "000000011" & drive_fwd_rev & not gun_sound &
		  not gun_right & not gun_left & not gun_elev &
		  not gun_fire_bb & drive_left_right & not ignition_key &
		  not machinegun_sound & tx_csum & "11";
	    else
		if R_phase_acc(0) = '1' then
		    R_outw <= R_outw(30 downto 0) & '1';
		end if;
		R_phase_acc <= R_phase_acc + 1;
	    end if;

	    if not C_inercija then
		R_brzina <= ("00" & brzina) + C_speed_bias;
		R_lijevo <= lijevo and not desno;
		R_desno <= desno and not lijevo;
		R_naprijed <= naprijed and not natrag;
		R_natrag <= natrag and not naprijed;
	    elsif ((R_lijevo or R_desno) = '1' and R_brzina /= x"0" and
	      (lijevo or desno or naprijed or natrag) = '0') or
	      motor = '1' then
		-- brzo zaustavljanje pri bilo kakvom zaokretanju
		R_speed_acc <= "00001";
		R_brzina <= x"0";
		R_naprijed <= '0';
		R_natrag <= '0';
		R_lijevo <= '0';
		R_desno <= '0';
	    elsif (R_naprijed or R_natrag or R_lijevo or R_desno) = '0' and
	      R_brzina = x"0" and
	      (lijevo or desno or naprijed or natrag) = '1' then
		-- brza reakcija na pokretanje iz mirovanja
		R_speed_acc <= "00001";
		R_brzina <=
		  std_logic_vector(conv_signed(integer(C_speed_bias), 4));
		R_naprijed <= naprijed;
		R_natrag <= natrag;
		R_lijevo <= lijevo;
		R_desno <= desno;
	    elsif R_phase_acc = x"4c" then
		-- reakcija na skretanje u voznji treba biti trenutna
		if R_skretanje = '0' then
		    R_skretanje <= lijevo or desno;
		elsif C_okret_u_mjestu and R_natrag = '0' and natrag = '1' then
		    R_natrag <= natrag;
		    R_naprijed <= naprijed;
		end if;
		if R_naprijed = '1' or R_natrag = '1' then
		    R_lijevo <= lijevo;
		    R_desno <= desno;
		end if;

		-- zaustavljanje iz skretanja mora biti trenutno
		if R_brzina /= x"0" and R_skretanje = '1' and
		  (naprijed or natrag or lijevo or desno) = '0' then
		    R_speed_acc <= "00001";
		    R_brzina <= x"0";
		    if C_okret_u_mjestu and
		      R_natrag = '0' and natrag = '1' then
			R_natrag <= natrag;
		    end if;
		end if;

		-- promjena brzine treba biti postupna
		R_speed_acc <= R_speed_acc + 1;
		if R_speed_acc = "00000" then
		    if (naprijed or natrag or lijevo or desno) = '1' then
			-- postupno ubrzavanje
			if R_brzina < ("00" & brzina) + C_speed_bias then
			    R_brzina <= R_brzina + 1;
			end if;
			R_skretanje <= R_lijevo or R_desno;
			R_naprijed <= naprijed;
			R_natrag <= natrag;
			R_lijevo <= lijevo;
			R_desno <= desno;
		    elsif R_brzina /= x"0" then
			-- postupno usporavanje
			if R_brzina >= x"2" then
			    R_brzina <= x"1";
			else
			    R_brzina <= x"0";
			end if;
		    else
			-- potpuno zaustavljanje
			R_skretanje <= R_lijevo or R_desno;
			R_naprijed <= naprijed;
			R_natrag <= natrag;
			R_lijevo <= lijevo;
			R_desno <= desno;
		    end if;
		end if;
	    end if;
	else
	    R_clk_acc <= R_clk_acc + 1;
	end if;

	if R_phase_acc(6) = '0' then
	    R_low_high <= R_outw(31) xor not R_phase_acc(0);
	else
	    if R_phase_acc(3 downto 1) = "111" then
		R_low_high <= '1';
	    else
		R_low_high <= '0';
	    end if;
	end if;
    end if;
    end process;

    -- FM DDS
    process(clk_pll)
    begin
	if (rising_edge(clk_pll)) then
	    if R_low_high = '0' then
		case channel is
		when "00" => R_fm_inc <= C_ch1_low;
		when "01" => R_fm_inc <= C_ch2_low;
		when "10" => R_fm_inc <= C_ch3_low;
		when others => R_fm_inc <= C_ch4_low;
		end case;
	    else
		case channel is
		when "00" => R_fm_inc <= C_ch1_high;
		when "01" => R_fm_inc <= C_ch2_high;
		when "10" => R_fm_inc <= C_ch3_high;
		when others => R_fm_inc <= C_ch4_high;
		end case;
	    end if;
            R_fm_acc <= R_fm_acc + R_fm_inc;
	end if;
    end process;

    rf <= R_fm_acc(C_fm_acclen - 1);
end;

-- synopsys translate_off
library xp2;
configuration Structure_CON of pll is
    for Structure
        for all:EPLLD1 use entity xp2.EPLLD1(V); end for;
    end for;
end Structure_CON;
-- synopsys translate_on

