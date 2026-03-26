set MARS_JAR "F:/Electronics/Computer Organization/Mars4_5.jar"
set ASM_FILE "./software/Testing_RAW_Hazard_code.asm"
set number_of_cycles_executed [exec java -jar $MARS_JAR mc CompactDataAtZero nc ic $ASM_FILE]
set number_of_cycles_required [expr 5+($number_of_cycles_executed-1)]

quit -sim
vlib work
vlog -sv -f ./scripts/files.f
vsim -voptargs=+acc work.top_tb +MAX_CYCLES=$number_of_cycles_required
add wave -position insertpoint sim:/top_tb/DUT/DataPath/*
add wave -position insertpoint \
sim:/top_tb/DUT/DataPath/RegFile/reg_file \
sim:/top_tb/DUT/DataPath/data_mem/data_mem \
sim:/top_tb/DUT/DataPath/instr_mem/instruction_mem 
add wave -position insertpoint sim:/top_tb/DUT/ControlUnit/*
add wave -position insertpoint sim:/top_tb/DUT/DataPath/HDU/*
add wave -position insertpoint sim:/top_tb/DUT/DataPath/RegFile/*
add wave -position insertpoint  \
sim:/top_tb/DUT/DataPath/RegFile/reg_file
run -all