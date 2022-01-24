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
set_option -frequency auto
set_option -maxfan 1000
set_option -auto_constrain_io 0
set_option -disable_io_insertion false
set_option -retiming false; set_option -pipe true
set_option -force_gsr false
set_option -compiler_compatible 0
set_option -dup false

set_option -default_enum_encoding default

#simulation options


#timing analysis options



#automatic place and route (vendor) options
set_option -write_apr_constraint 1

#synplifyPro options
set_option -fix_gated_and_generated_clocks 1
set_option -update_models_cp 0
set_option -resolve_multiple_driver 0


#-- add_file options
set_option -include_path {Z:/lab2}
add_file -verilog {C:/lscc/diamond/2.2_x64/cae_library/synthesis/verilog/xp2.v}
add_file -verilog {Z:/lab2/labv2/enkoder.v}
add_file -verilog {Z:/lab2/labv2/sviraj.v}
add_file -vhdl -lib "work" {Z:/lab2/labv2/source/tonegen.vhd}

#-- top module name
set_option -top_module sviraj

#-- set result format/file last
project -result_file {Z:/lab2/labv2/labv2_labv2.edi}

#-- error message log file
project -log_file {labv2_labv2.srf}

#-- set any command lines input by customer


#-- run Synplify with 'arrange HDL file'
project -run hdl_info_gen -fileorder
project -run
