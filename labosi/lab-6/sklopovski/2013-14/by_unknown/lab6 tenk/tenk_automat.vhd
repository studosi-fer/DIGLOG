library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

ENTITY tenk_automat IS
    port(
        clk, start, stop: in std_logic;
        brzina: out std_logic_vector(1 downto 0);
        motor, strojnica: out std_logic;
        top_lijevo, top_desno, top_visina, top_zvuk: out std_logic;
        naprijed, natrag, lijevo, desno: out std_logic;
        stanje: out std_logic_vector(6 downto 0)
    );
END tenk_automat;

ARCHITECTURE arch OF tenk_automat IS 
    -- ROM pregledna tablica s programom navodjenja
    type tenk_rom_type is array(0 to 127) of std_logic_vector(15 downto 0);
    constant tenk_rom: tenk_rom_type := (
        --     15 -- kreni ispocetka
        -- 14..12 -- broj ciklusa cekanja u istom stanju
        -- 11..8  -- brzina_hi, brzina_lo, motor, strojnica
        --  7..4  -- naprijed, natrag, lijevo, desno
        --  3..0  -- top_lijevo, top_desno, top_visina, top_zvuk
        x"0000", -- s0: cekaj impuls na ulazu start
        x"4200", -- s1: ukljuci motor, cekaj pet ciklusa
        x"7000", -- s2: pricekaj jos sedam ciklusa u mjestu
        x"1080", -- s3: kreni naprijed najmanjom brzinom (00) dva ciklusa
        x"1480", -- s4: nastavi naprijed vecom brzinom (01) dva ciklusa
        x"7002", -- s5: zaustavi se i cekaj osam ciklusa, mijenjaj elevaciju topa
        x"8200", -- s6: gasi motor, vrati se na stanje s0
        others => x"8000" -- vrati se na stanje s0
    );
    
    -- konstante
    constant C_stanje_0: std_logic_vector(6 downto 0) := "0000000";

    -- signali i registri
    signal R_stanje: std_logic_vector(6 downto 0) := C_stanje_0;
    signal R_cekanje: std_logic_vector(2 downto 0) := "000";
    signal rom_out: std_logic_vector(15 downto 0);
    signal ciklusi_cekanja: std_logic_vector(2 downto 0);
    signal kreni_ispocetka: std_logic;
    
BEGIN
    rom_out <= tenk_rom(conv_integer(R_stanje));

    kreni_ispocetka <= rom_out(15);
    ciklusi_cekanja <= rom_out(14 downto 12);
    brzina <= rom_out(11 downto 10);
    motor <= rom_out(9);
    strojnica <= rom_out(8);
    naprijed <= rom_out(7);
    natrag <= rom_out(6);
    lijevo <= rom_out(5);
    desno <= rom_out(4);
    top_lijevo <= rom_out(3);
    top_desno <= rom_out(2);
    top_visina <= rom_out(1);
    top_zvuk <= rom_out(0);

    process(clk)
    begin
        if rising_edge(clk) then
            if stop = '1' or (R_stanje = C_stanje_0 and start /= '1') then
                -- reset vanjskim signalom
                R_stanje <= C_stanje_0;
                R_cekanje <= "000";
            elsif R_cekanje = ciklusi_cekanja then
                -- prelazak na novo stanje
                if kreni_ispocetka = '1' then
                    R_stanje <= C_stanje_0;
                else
                    R_stanje <= R_stanje + 1;
                    R_cekanje <= "000";
                end if;
            else
                -- cekamo u istom stanju
                R_cekanje <= R_cekanje + 1;
            end if;
        end if;
    end process;
    
    stanje <= R_stanje;
END arch;
