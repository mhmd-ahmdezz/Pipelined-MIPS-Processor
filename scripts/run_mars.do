# MARS Automation Script

# -------- Paths --------
set MARS_JAR "F:/Electronics/Computer Organization/Mars4_5.jar"
set ASM_FILE "./software/Testing_Jump_Instruction_code.asm"
set OUT_DIR  "./tb/Golden_Model"

puts "Running MARS..."

# -------- Instruction Memory --------
puts "Generating instruction memory File..."
exec java -jar $MARS_JAR nc mc CompactTextAtZero a $ASM_FILE dump .text HexText $OUT_DIR/instr_mem.mem

# -------- Register File (raw) --------
puts "Generating Register File ..."
set REGISTERS {}
for {set i 0} {$i < 32} {incr i} {
    lappend REGISTERS $i
}

#Capture the raw file into a variable 
set raw_output [exec java -jar $MARS_JAR nc hex {*}$REGISTERS $ASM_FILE]

#Open the output file for writing
set fh [open $OUT_DIR/reg_file.mem w]

foreach line [split $raw_output "\n"] {
    if {[regexp {0x([0-9a-fA-F]{8})} $line -> hex_value]} {
        puts $fh $hex_value
    }
}
close $fh 
puts "Stripping Complete. Clean hex Values saved to $OUT_DIR"

# -------- Data Memory --------
puts "Generating Data memory File..."
exec java -jar $MARS_JAR nc mc CompactDataAtZero $ASM_FILE dump .data HexText $OUT_DIR/data_mem.mem