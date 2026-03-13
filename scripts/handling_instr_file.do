set OUT_DIR  "./tb/Golden_Model"

puts "Handling Instruction File to be Byte-Addressable..."

set fp [open $OUT_DIR/instr_mem.mem r]
set fw [open $OUT_DIR/instr_bytes.mem w]
while { [gets $fp line] >= 0 } {
    set i 0
    while {$i < 8} {
        set temp_str_0 [string reverse $line]
        set temp_str_1 [string range $temp_str_0 $i [ expr {$i + 1} ] ]
        puts $fw [string reverse $temp_str_1]
        set i [ expr {$i + 2}]
    }
}
close $fp
close $fw