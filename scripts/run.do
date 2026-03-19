set MARS_JAR "F:/Electronics/Computer Organization/Mars4_5.jar"
set ASM_FILE "./software/complex_control_hazard_code.asm"
set number_of_cycles_executed [exec java -jar $MARS_JAR mc CompactDataAtZero nc ic $ASM_FILE]
set number_of_cycles_required [expr 5+($number_of_cycles_executed-1)]

quit -sim
vlib work
vlog -sv -f ./scripts/files.f
vsim -voptargs=+acc work.top_tb +MAX_CYCLES=$number_of_cycles_required
add wave -position insertpoint \
sim:/top_tb/DUT/DataPath/clk \
sim:/top_tb/DUT/DataPath/arst \
sim:/top_tb/DUT/DataPath/ReadDataF \
sim:/top_tb/DUT/DataPath/PCPlus4F \
sim:/top_tb/DUT/DataPath/InstrD \
sim:/top_tb/DUT/DataPath/PCSrcD \
sim:/top_tb/DUT/DataPath/EqualD \
sim:/top_tb/DUT/DataPath/PCPlus4D \
sim:/top_tb/DUT/DataPath/PCBranchD \
sim:/top_tb/DUT/DataPath/RegFile_ReadData1_D \
sim:/top_tb/DUT/DataPath/RegFile_ReadData2_D \
sim:/top_tb/DUT/DataPath/SignImmD \
sim:/top_tb/DUT/DataPath/RegFile_ReadData1_E \
sim:/top_tb/DUT/DataPath/RegFile_ReadData2_E \
sim:/top_tb/DUT/DataPath/RsE \
sim:/top_tb/DUT/DataPath/RtE \
sim:/top_tb/DUT/DataPath/RdE \
sim:/top_tb/DUT/DataPath/SignImmE \
sim:/top_tb/DUT/DataPath/ALUOutE \
sim:/top_tb/DUT/DataPath/WriteDataE \
sim:/top_tb/DUT/DataPath/WriteRegE \
sim:/top_tb/DUT/DataPath/ALUOutM \
sim:/top_tb/DUT/DataPath/WriteDataM \
sim:/top_tb/DUT/DataPath/WriteRegM \
sim:/top_tb/DUT/DataPath/ReadDataM \
sim:/top_tb/DUT/DataPath/ReadDataW \
sim:/top_tb/DUT/DataPath/ALUOutW \
sim:/top_tb/DUT/DataPath/ResultW \
sim:/top_tb/DUT/DataPath/RegFile/reg_file \
sim:/top_tb/DUT/DataPath/data_mem/data_mem
add wave -position insertpoint sim:/top_tb/DUT/ControlUnit/*
add wave -position insertpoint sim:/top_tb/DUT/DataPath/HDU/*
run -all