module mux_4x1
#(parameter DATA_WIDTH = 32)
(   
    input  logic [DATA_WIDTH-1:0] x0, x1, x2, x3, 
    input  logic [1:0]sel,
    output logic [DATA_WIDTH-1:0] f 
);

always_comb begin
    case(sel)
        2'd0 : f = x0 ;
        2'd1 : f = x1 ;
        2'd2 : f = x2 ;
        2'd3 : f = x3 ;
    endcase
end

endmodule