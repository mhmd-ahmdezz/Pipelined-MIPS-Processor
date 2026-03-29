module control_unit
#(
    parameter OPCODE_FIELD = 6 ,
    parameter FUNCT_FIELD = 6 
)
(
    input  logic [OPCODE_FIELD-1:0] Opcode , // Opcode Field
    input  logic [FUNCT_FIELD-1:0] Funct , // Function field
    output logic RegWriteD, MemtoRegD, MemWriteD, 
    output logic [2:0] ALUControlD,
    output logic BranchD, ALUSrcD,RegDstD,
    output logic JumpD, JalD, JrD, BeqOrBneD
);

//Internal Signals
logic [1:0] ALUOp;

//Main Decoder
main_decoder Main_Decoder(
    .Opcode(Opcode),
    .Funct(Funct),
    .BranchD(BranchD),
    .MemtoRegD(MemtoRegD),
    .ALUSrcD(ALUSrcD),
    .RegDstD(RegDstD),
    .RegWriteD(RegWriteD),
    .MemWriteD(MemWriteD),
    .ALUOp(ALUOp),
    .JumpD(JumpD),
    .JalD(JalD),
    .JrD(JrD),
    .BeqOrBneD(BeqOrBneD)
);

//ALU Decoder
alu_decoder ALU_Decoder(
    .Funct(Funct),
    .ALUOp(ALUOp),
    .ALUControlD(ALUControlD)
); 

endmodule