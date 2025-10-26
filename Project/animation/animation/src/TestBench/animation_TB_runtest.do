SetActiveLib -work
comp -include "$dsn\src\main.vhd" 
comp -include "$dsn\src\bitSlice.vhd" 
comp -include "$dsn\src\TestBench\animation_TB.vhd" 
asim +access +r TESTBENCH_FOR_animation 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg play
wave -noreg data_in
wave -noreg data_out
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\animation_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_animation 
