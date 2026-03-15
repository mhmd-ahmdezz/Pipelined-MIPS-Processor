quit -sim
vlib work
vlog -sv -f ./scripts/files.f
vsim -voptargs=+acc work.top_tb
add wave -position insertpoint  \
sim:/top_tb/DUT/DataPath/DATA_WIDTH \
sim:/top_tb/DUT/DataPath/ADDR_WIDTH \
sim:/top_tb/DUT/DataPath/OPCODE_FIELD \
sim:/top_tb/DUT/DataPath/FUNCT_FIELD \
sim:/top_tb/DUT/DataPath/clk \
sim:/top_tb/DUT/DataPath/arst \
sim:/top_tb/DUT/DataPath/RegWriteD \
sim:/top_tb/DUT/DataPath/MemtoRegD \
sim:/top_tb/DUT/DataPath/MemWriteD \
sim:/top_tb/DUT/DataPath/BranchD \
sim:/top_tb/DUT/DataPath/ALUSrcD \
sim:/top_tb/DUT/DataPath/RegDstD \
sim:/top_tb/DUT/DataPath/ALUControlD \
sim:/top_tb/DUT/DataPath/Opcode \
sim:/top_tb/DUT/DataPath/Funct \
sim:/top_tb/DUT/DataPath/PCF \
sim:/top_tb/DUT/DataPath/next_pcf \
sim:/top_tb/DUT/DataPath/ReadDataF \
sim:/top_tb/DUT/DataPath/PCPlus4F \
sim:/top_tb/DUT/DataPath/PCBranchM \
sim:/top_tb/DUT/DataPath/InstrD \
sim:/top_tb/DUT/DataPath/PCPlus4D \
sim:/top_tb/DUT/DataPath/RegFile_ReadData1_D \
sim:/top_tb/DUT/DataPath/RegFile_ReadData2_D \
sim:/top_tb/DUT/DataPath/SignImmD \
sim:/top_tb/DUT/DataPath/SrcAE \
sim:/top_tb/DUT/DataPath/SrcBE \
sim:/top_tb/DUT/DataPath/RtE \
sim:/top_tb/DUT/DataPath/RdE \
sim:/top_tb/DUT/DataPath/WriteRegE \
sim:/top_tb/DUT/DataPath/SignImmE \
sim:/top_tb/DUT/DataPath/PCPlus4E \
sim:/top_tb/DUT/DataPath/WriteDataE \
sim:/top_tb/DUT/DataPath/RegWriteE \
sim:/top_tb/DUT/DataPath/MemtoRegE \
sim:/top_tb/DUT/DataPath/MemWriteE \
sim:/top_tb/DUT/DataPath/BranchE \
sim:/top_tb/DUT/DataPath/ALUControlE \
sim:/top_tb/DUT/DataPath/ALUSrcE \
sim:/top_tb/DUT/DataPath/RegDstE \
sim:/top_tb/DUT/DataPath/ZeroE \
sim:/top_tb/DUT/DataPath/PCBranchE \
sim:/top_tb/DUT/DataPath/ALUOutE \
sim:/top_tb/DUT/DataPath/ALUOutM \
sim:/top_tb/DUT/DataPath/WriteDataM \
sim:/top_tb/DUT/DataPath/ReadDataM \
sim:/top_tb/DUT/DataPath/RegWriteM \
sim:/top_tb/DUT/DataPath/MemtoRegM \
sim:/top_tb/DUT/DataPath/MemWriteM \
sim:/top_tb/DUT/DataPath/BranchM \
sim:/top_tb/DUT/DataPath/WriteRegM \
sim:/top_tb/DUT/DataPath/ZeroM \
sim:/top_tb/DUT/DataPath/ALUOutW \
sim:/top_tb/DUT/DataPath/ReadDataW \
sim:/top_tb/DUT/DataPath/ResultW \
sim:/top_tb/DUT/DataPath/MemtoRegW \
sim:/top_tb/DUT/DataPath/RegWriteW \
sim:/top_tb/DUT/DataPath/WriteRegW \
sim:/top_tb/DUT/DataPath/PCSrcM
add wave -position insertpoint  \
sim:/top_tb/DUT/DataPath/RegFile/A1 \
sim:/top_tb/DUT/DataPath/RegFile/A2 \
sim:/top_tb/DUT/DataPath/RegFile/RD1 \
sim:/top_tb/DUT/DataPath/RegFile/RD2 \
sim:/top_tb/DUT/DataPath/RegFile/WE3 \
sim:/top_tb/DUT/DataPath/RegFile/A3 \
sim:/top_tb/DUT/DataPath/RegFile/WD3
add wave -position insertpoint  \
sim:/top_tb/DUT/DataPath/RegFile/reg_file
run -all