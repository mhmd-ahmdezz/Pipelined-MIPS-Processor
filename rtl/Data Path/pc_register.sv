module pc_register
#(parameter DATA_WIDTH = 32)
(
    input  logic clk , arst , En,
    input  logic [DATA_WIDTH-1:0] next_pc ,
    output logic [DATA_WIDTH-1:0] current_pc 
);

always_ff @(posedge clk,posedge arst) begin
    if(arst) 
        // current_pc <= 'h00400000 ;
        current_pc <= 'd0 ;
    else if(!En)
        current_pc <= current_pc  ;
    else 
        current_pc <= next_pc     ;
end

endmodule