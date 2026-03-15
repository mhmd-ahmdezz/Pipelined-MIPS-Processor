module top
#(
    parameter DATA_WIDTH   = 32 ,
    parameter ADDR_WIDTH   = 32 ,
    parameter OPCODE_FIELD = 6 ,
    parameter FUNCT_FIELD  = 6 
)
(
    input logic clk , arst // Clock signal and Asynchronous Active-high reset
);

//Internal Signals
logic [OPCODE_FIELD-1:0] Opcode ;
logic [FUNCT_FIELD-1:0] Funct ;

logic RegWriteD, MemtoRegD,MemWriteD;
logic BranchD, ALUSrcD, RegDstD;
logic [2:0]ALUControlD;

//Control Unit
control_unit #(.OPCODE_FIELD(OPCODE_FIELD),.FUNCT_FIELD(FUNCT_FIELD)) ControlUnit
(
    .Opcode(Opcode) , 
    .Funct(Funct) , 
    .RegWriteD(RegWriteD),
    .MemtoRegD(MemtoRegD),
    .MemWriteD(MemWriteD), 
    .BranchD(BranchD),
    .ALUControlD(ALUControlD),
    .ALUSrcD(ALUSrcD),
    .RegDstD(RegDstD) 
);
//Data Path
data_path #(
    .DATA_WIDTH(DATA_WIDTH)    ,
    .ADDR_WIDTH(ADDR_WIDTH)    ,
    .OPCODE_FIELD(OPCODE_FIELD)  ,
    .FUNCT_FIELD(FUNCT_FIELD)  
) DataPath
(
    .clk(clk),
    .arst(arst),
    .RegWriteD(RegWriteD),
    .MemtoRegD(MemtoRegD),
    .MemWriteD(MemWriteD),
    .BranchD(BranchD),
    .ALUControlD(ALUControlD),
    .ALUSrcD(ALUSrcD),
    .RegDstD(RegDstD),
    .Opcode(Opcode) ,
    .Funct(Funct)
);

endmodule