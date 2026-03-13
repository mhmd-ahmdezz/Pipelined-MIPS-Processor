module InstructionMemory
#(
    parameter DATA_WIDTH = 32 ,
    parameter ADDR_WIDTH = 32
)
(       
    input  logic [ADDR_WIDTH-1:0] addr, // Address port    
    output logic [DATA_WIDTH-1:0] ReadData   
);

logic [DATA_WIDTH-1:0] instruction_mem [2*ADDR_WIDTH-1:0];

initial begin
    $readmemh("./tb/Golden_Model/instr_mem.mem",instruction_mem);
end

// Byte Addresssable Modeling using Streaming operator
assign ReadData = {>>{instruction_mem[addr +: 4]}};

endmodule