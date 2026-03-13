module alu_decoder
#(
    parameter FUNCT_FIELD = 6 
)
(
    input  logic [1:0] ALUOp ,
    input  logic [FUNCT_FIELD-1:0] Funct ,
    output logic [2:0] ALUControlD 
);

always_comb begin
    case(ALUOp)
        2'b00 : ALUControlD = 3'b010 ; // Add
        2'b01 : ALUControlD = 3'b110 ; // Subtract
        2'b10 : begin
            case(Funct)
                6'b100000 : ALUControlD = 3'b010 ; //Add
                6'b100010 : ALUControlD = 3'b110 ; //Subtract
                6'b100100 : ALUControlD = 3'b000 ; // AND
                6'b100101 : ALUControlD = 3'b001 ; // OR
                6'b101010 : ALUControlD = 3'b111 ; // SLT
                default : ALUControlD = 3'b011 ; // Do Nothing
            endcase
        end
        2'b11 : ALUControlD = 3'b011 ; //Do Nothing
        default : ALUControlD = 3'b011 ; // Do Nothing
    endcase
end
endmodule