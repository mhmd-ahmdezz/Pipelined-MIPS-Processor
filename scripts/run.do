quit -sim
vlib work
vlog -sv -f ./scripts/files.f
vsim -voptargs=+acc work.top_tb
add wave -position insertpoint  \
sim:/tb/DUT/DataPath/instr_mem \
sim:/tb/DUT/DataPath/data_mem \
sim:/tb/DUT/DataPath/RegFile \
sim:/tb/clk
run -all