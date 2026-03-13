`timescale 1ns/1ps 
module alu
#(
    parameter DATA_WIDTH = 32 ,
    // OPeration codes : 
    parameter OPCODE = 3 ,
    // Operations :
    parameter AND  =  3'b000 ,
    parameter OR   =  3'b001 ,
    parameter ADD  =  3'b010 ,
    parameter N_A  =  3'b011 ,
    parameter A_AND_B_INVERT  =  3'b100 ,
    parameter A_OR_B_INVERT  =  3'b101 ,
    parameter SUB  =  3'b110 ,
    parameter SLT  =  3'b111 
)
(
    input  logic [DATA_WIDTH-1:0] A,B ,
    input  logic [OPCODE-1:0] op ,
    output logic [DATA_WIDTH-1:0] result,
    output logic zero 
);

always_comb begin
    case(op)
        AND : result = A & B ;
        OR  : result = A | B ;
        ADD : result = A + B ;
        N_A : result = 'd0   ;
        A_AND_B_INVERT : result = A & (~B) ;
        A_OR_B_INVERT  : result = A | (~B) ;
        SUB : result = A - B ;
        SLT : result = (A<B) ? 'd1 : 'd0 ;
        default : result = 'd0 ;
    endcase
end

assign zero = (result == 'd0);

endmodule