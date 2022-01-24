[ActiveSupport MAP]
Device = LFXP2-5E;
Package = TQFP144;
Performance = 5;
LUTS_avail = 4752;
LUTS_used = 481;
FF_avail = 3664;
FF_used = 324;
INPUT_LVCMOS33 = 10;
OUTPUT_LVCMOS33 = 17;
IO_avail = 100;
IO_used = 27;
PLL_avail = 2;
PLL_used = 1;
EBR_avail = 9;
EBR_used = 3;
;
; start of DSP statistics
MULT36X36B = 1;
MULT18X18B = 2;
MULT18X18MACB = 0;
MULT18X18ADDSUBB = 0;
MULT18X18ADDSUBSUMB = 0;
MULT9X9B = 0;
MULT9X9ADDSUBB = 0;
MULT9X9ADDSUBSUMB = 0;
DSP_avail = 24;
DSP_used = 12;
; end of DSP statistics
;
; Begin EBR Section
Instance_Name = II_tonegen/un2_r_freq_0_0;
Type = PDPW16KB;
Width = 22;
Depth_R = 64;
REGMODE = NOREG;
RESETMODE = SYNC;
GSR = DISABLED;
Instance_Name = II_tonegen/R_sin_1_0_0;
Type = SP16KB;
Width = 16;
Depth = 256;
REGMODE = NOREG;
RESETMODE = SYNC;
WRITEMODE = NORMAL;
GSR = DISABLED;
Instance_Name = I_tonegen/R_sin_1_0_0;
Type = SP16KB;
Width = 16;
Depth = 256;
REGMODE = NOREG;
RESETMODE = SYNC;
WRITEMODE = NORMAL;
GSR = DISABLED;
; End EBR Section
; Begin PLL Section
Instance_Name = fmgen/I_PLL_250m/PLLInst_0;
Type = EPLLD;
Output_Clock(P)_Actual_Frequency = 250.0000;
CLKOP_BYPASS = DISABLED;
CLKOS_BYPASS = DISABLED;
CLKOK_BYPASS = DISABLED;
CLKI_Divider = 1;
CLKFB_Divider = 10;
CLKOP_Divider = 2;
CLKOK_Divider = 2;
CLKOS_Phase_Shift_(degree) = 0.0;
CLKOS_Duty_Cycle_(*1/16) = 8;
Phase_Duty_Control = STATIC;
; End PLL Section
