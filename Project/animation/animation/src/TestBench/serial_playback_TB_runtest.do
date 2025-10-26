SetActiveLib -work
comp -include "$dsn\src\main.vhd" 
comp -include "$dsn\src\TestBench\serial_playback_TB.vhd" 
asim +access +r TESTBENCH_FOR_serial_playback 
wave 
wave -noreg clk
wave -noreg reset
wave -noreg play
wave -noreg shift_reg
wave -noreg data_out
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# comp -include "$dsn\src\TestBench\serial_playback_TB_tim_cfg.vhd" 
# asim +access +r TIMING_FOR_serial_playback 
