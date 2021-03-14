
#Begin clock constraint
define_clock -name {pogodi_bistabil|btn_center} {p:pogodi_bistabil|btn_center} -period 10000000.000 -clockgroup Autoconstr_clkgroup_0 -rise 0.000 -fall 5000000.000 -route 0.000 
#End clock constraint

#Begin clock constraint
define_clock -name {pogodi_bistabil|clk_25m} {p:pogodi_bistabil|clk_25m} -period 5.437 -clockgroup Autoconstr_clkgroup_1 -rise 0.000 -fall 2.718 -route 0.000 
#End clock constraint
