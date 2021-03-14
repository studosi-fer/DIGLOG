--
-- Copyright (c) 2013 - 2015 Marko Zec, University of Zagreb
-- All rights reserved.
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions
-- are met:
-- 1. Redistributions of source code must retain the above copyright
--    notice, this list of conditions and the following disclaimer.
-- 2. Redistributions in binary form must reproduce the above copyright
--    notice, this list of conditions and the following disclaimer in the
--    documentation and/or other materials provided with the distribution.
--
-- THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
-- ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-- IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-- ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
-- FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
-- DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
-- OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
-- HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
-- LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
-- OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
-- SUCH DAMAGE.
--
-- $Id$
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity serial_tx is
    generic (
	C_clk_freq: integer := 25;	-- clock frequency, in MHz
	C_baudrate: integer := 115200;	-- in bits per second
	C_debounce_dly: integer := 50	-- in ms
    );
    port (
	clk: in std_logic;
	byte_in: in std_logic_vector(7 downto 0);
	ser_out: out std_logic
    );
end serial_tx;

architecture Behavioral of serial_tx is
    constant C_baud_init: std_logic_vector(15 downto 0) :=
      std_logic_vector(to_unsigned(
	C_baudrate * 2**10 / 1000 * 2**10 / C_clk_freq / 1000, 16));
    constant C_debounce_max: integer := C_clk_freq * 1000 * C_debounce_dly;

    -- baud * 16 impulse generator
    signal R_baudrate: std_logic_vector(15 downto 0) := C_baud_init;
    signal R_baudgen: std_logic_vector(16 downto 0);

    -- transmit logic
    signal R_debounce_cnt: integer;
    signal R_byte_old: std_logic_vector(7 downto 0);
    signal R_tx_tickcnt: std_logic_vector(3 downto 0);
    signal R_tx_phase: std_logic_vector(3 downto 0);
    signal R_tx_ser: std_logic_vector(8 downto 0) := (others => '1');

begin

    --
    -- tx phases:
    --	"0000" idle
    --	"0001" start bit
    --	"0010".."1001" data bits
    --	"1010" stop bit
    --

    ser_out <= R_tx_ser(0);

    process(clk)
    begin
	if rising_edge(clk) then
	    -- input debouncer
	    R_byte_old <= byte_in;
	    if byte_in /= R_byte_old then
		R_debounce_cnt <= C_debounce_max;
	    elsif R_debounce_cnt /= 0 then
		R_debounce_cnt <= R_debounce_cnt - 1;
	    end if;

	    -- initiate tx
	    if R_debounce_cnt = 1 and R_byte_old /= x"00" then
		R_tx_phase <= x"1";
		R_tx_ser <= R_byte_old & '0';
	    end if;

	    -- baud generator
	    R_baudgen <= ('0' & R_baudgen(15 downto 0)) + ('0' & R_baudrate);

	    -- tx logic
	    if R_tx_phase /= x"0" and R_baudgen(16) = '1' then
		R_tx_tickcnt <= R_tx_tickcnt + 1;
		if R_tx_tickcnt = x"f" then
		    R_tx_ser <= '1' & R_tx_ser(8 downto 1);
		    R_tx_phase <= R_tx_phase + 1;
		    if R_tx_phase = x"a" then
			R_tx_phase <= x"0";
		    end if;
		end if;
	    end if;
	end if;
    end process;
end Behavioral;
