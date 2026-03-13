module main_decoder
#(
    parameter OPCODE_FIELD = 6 ,
    parameter FUNCT_FIELD = 6 ,
    //Opcodes : 
    parameter [OPCODE_FIELD-1:0] R_TYPE = 6'b000000 ,
    parameter [OPCODE_FIELD-1:0] LW     = 6'b100011 ,
    parameter [OPCODE_FIELD-1:0] SW     = 6'b101011 ,
    parameter [OPCODE_FIELD-1:0] BEQ    = 6'b000100 
)
(
    input  logic[OPCODE_FIELD-1:0] Opcode ,
    output logic BranchD , MemtoRegD,ALUSrcD,
    output logic RegDstD , RegWriteD,MemWriteD,
    output logic [1:0] ALUOp
);

always_comb begin
    case(Opcode)
        R_TYPE : begin
            RegWriteD = 1'b1  ;
            RegDstD   = 1'b1  ;
            ALUSrcD   = 1'b0  ;
            BranchD   = 1'b0  ;
            MemWriteD = 1'b0  ;
            MemtoRegD = 1'b0  ;
            ALUOp     = 2'b10 ; 
        end
        LW    : begin
            RegWriteD = 1'b1  ;
            RegDstD   = 1'b0  ;
            ALUSrcD   = 1'b1  ;
            BranchD   = 1'b0  ;
            MemWriteD = 1'b0  ;
            MemtoRegD = 1'b1  ;
            ALUOp     = 2'b00 ;
        end
        SW    : begin
            RegWriteD = 1'b0  ;
            RegDstD   = 1'b0  ;
            ALUSrcD   = 1'b1  ;
            BranchD   = 1'b0  ;
            MemWriteD = 1'b1  ;
            MemtoRegD = 1'b0  ;
            ALUOp     = 2'b00 ;
        end
        BEQ    : begin
            RegWriteD = 1'b0  ;
            RegDstD   = 1'b0  ;
            ALUSrcD   = 1'b0  ;
            BranchD   = 1'b1  ;
            MemWriteD = 1'b0  ;
            MemtoRegD = 1'b0  ;
            ALUOp     = 2'b01 ;
        end
        default : begin
            RegWriteD = 1'b0  ;
            RegDstD   = 1'b0  ;
            ALUSrcD   = 1'b0  ;
            BranchD   = 1'b0  ;
            MemWriteD = 1'b0  ;
            MemtoRegD = 1'b0  ;
            ALUOp     = 2'b00 ;
        end
    endcase
end

endmodule