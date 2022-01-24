#-- Lattice Semiconductor Corporation Ltd.
#-- Synplify OEM project file

#device options
set_option -technology LATTICE-XP2
set_option -part LFXP2_5E
set_option -package TN144C
set_option -speed_grade -5

#compilation/mapping options
set_option -symbolic_fsm_compiler true
set_option -resource_sharing true

#use verilog 2001 standard option
set_option -vlog_std v2001

#map options
set_option -frequency 200
set_option -fanout_limit 100
set_option -auto_constrain_io true
set_option -disable_io_insertion false
set_option -retiming false; set_option -pipe false
set_option -force_gsr false
set_option -compiler_compatible true
set_option -dup false

set_option -default_enum_encoding default

#simulation options


#timing analysis options
set_option -num_critical_paths 3
set_option -num_startend_points 0

#automatic place and route (vendor) options
set_option -write_apr_constraint 0

#synplifyPro options
set_option -fixgatedclocks 3
set_option -fixgeneratedclocks 3
set_option -update_models_cp 0
set_option -resolve_multiple_driver 1

#-- add_file options
add_file -vhdl {C:/lscc/diamond/2.0/cae_library/synthesis/vhdl/xp2.vhd}
add_file -vhdl -lib "work" {C:/Users/dr.Chernobyl/Desktop/lab5/lab5/source/afsk_modem.vhd}
add_file -vhdl -lib "work" {C:/Users/dr.Chernobyl/Desktop/lab5/lab5/source/demodulator.vhd}
add_file -vhdl -lib "work" {C:/Users/dr.Chernobyl/Desktop/lab5/modulator.vhd}


#-- set result format/file last
project -result_file {C:/Users/dr.Chernobyl/Desktop/lab5/lab5/lab5_lab5.edi}

#-- error message log file
project -log_file {lab5_lab5.srf}

#-- set any command lines input by customer


#-- run Synplify with 'arrange HDL file'
project -run hdl_info_gen -fileorder
project -run
