module main_decoder
#(
    parameter OPCODE_FIELD = 6 ,
    parameter FUNCT_FIELD = 6 ,
    //Opcodes : 
    parameter [OPCODE_FIELD-1:0] R_TYPE = 6'b000000 ,
    parameter [OPCODE_FIELD-1:0] LW     = 6'b100011 ,
    parameter [OPCODE_FIELD-1:0] SW     = 6'b101011 ,
    parameter [OPCODE_FIELD-1:0] ADDI   = 6'b001000 ,
    parameter [OPCODE_FIELD-1:0] BEQ    = 6'b000100 ,
    parameter [OPCODE_FIELD-1:0] J      = 6'b000010 ,
    parameter [OPCODE_FIELD-1:0] JAL    = 6'b000011 ,
    parameter [FUNCT_FIELD-1:0]  JR     = 6'b001000 
)
(
    input  logic[OPCODE_FIELD-1:0] Opcode ,
    input  logic[FUNCT_FIELD-1:0] Funct ,
    output logic BranchD , MemtoRegD, ALUSrcD,
    output logic RegDstD , RegWriteD, MemWriteD,
    output logic JumpD , JalD, JrD,
    output logic [1:0] ALUOp
);

always_comb begin
    case(Opcode)
        R_TYPE : begin
            RegWriteD = (Funct != JR)  ;
            RegDstD   = 1'b1  ;
            ALUSrcD   = 1'b0  ;
            BranchD   = 1'b0  ;
            MemWriteD = 1'b0  ;
            MemtoRegD = 1'b0  ;
            ALUOp     = 2'b10 ;
            JalD     = 1'b0   ;
            JumpD     = (Funct == JR)  ; 
            JrD      = (Funct == JR) ;
        end
        LW    : begin
            RegWriteD = 1'b1  ;
            RegDstD   = 1'b0  ;
            ALUSrcD   = 1'b1  ;
            BranchD   = 1'b0  ;
            MemWriteD = 1'b0  ;
            MemtoRegD = 1'b1  ;
            ALUOp     = 2'b00 ;
            JumpD     = 1'b0  ;
            JalD     = 1'b0   ;
            JrD      = 1'b0 ;
        end
        SW    : begin
            RegWriteD = 1'b0  ;
            RegDstD   = 1'b0  ;
            ALUSrcD   = 1'b1  ;
            BranchD   = 1'b0  ;
            MemWriteD = 1'b1  ;
            MemtoRegD = 1'b0  ;
            ALUOp     = 2'b00 ;
            JumpD     = 1'b0  ;
            JalD     = 1'b0   ;
            JrD      = 1'b0 ;
        end
        BEQ    : begin
            RegWriteD = 1'b0  ;
            RegDstD   = 1'b0  ;
            ALUSrcD   = 1'b0  ;
            BranchD   = 1'b1  ;
            MemWriteD = 1'b0  ;
            MemtoRegD = 1'b0  ;
            ALUOp     = 2'b01 ;
            JumpD     = 1'b0  ;
            JalD     = 1'b0   ;
            JrD      = 1'b0 ;
            
        end
        ADDI    : begin
            RegWriteD = 1'b1  ;
            RegDstD   = 1'b0  ;
            ALUSrcD   = 1'b1  ;
            BranchD   = 1'b0  ;
            MemWriteD = 1'b0  ;
            MemtoRegD = 1'b0  ;
            ALUOp     = 2'b00 ;
            JumpD     = 1'b0  ;
            JalD     = 1'b0   ;
            JrD      = 1'b0 ;
        end
        J       : begin 
            RegWriteD = 1'b0  ;
            RegDstD   = 1'b0  ;
            ALUSrcD   = 1'b0  ;
            BranchD   = 1'b0  ;
            MemWriteD = 1'b0  ;
            MemtoRegD = 1'b0  ;
            ALUOp    = 2'b00  ;
            JumpD    = 1'b1   ;
            JalD     = 1'b0   ;
            JrD      = 1'b0 ;
        end
        JAL      : begin 
            RegWriteD = 1'b0  ;
            RegDstD   = 1'b0  ;
            ALUSrcD   = 1'b0  ;
            BranchD   = 1'b0  ;
            MemWriteD = 1'b0  ;
            MemtoRegD = 1'b0  ;
            ALUOp    = 2'b00  ;
            JumpD    = 1'b1   ;
            JalD     = 1'b1   ;
            JrD      = 1'b0 ;
        end
        default : begin
            RegWriteD = 1'b0  ;
            RegDstD   = 1'b0  ;
            ALUSrcD   = 1'b0  ;
            BranchD   = 1'b0  ;
            MemWriteD = 1'b0  ;
            MemtoRegD = 1'b0  ;
            ALUOp     = 2'b00 ;
            JumpD     = 1'b0  ;
            JalD     = 1'b0   ;
            JrD      = 1'b0 ;
        end
    endcase
end

endmodule