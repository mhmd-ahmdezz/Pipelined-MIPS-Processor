module mux_2x1
#(parameter DATA_WIDTH = 32)
(   
    input logic [DATA_WIDTH-1:0] x0 , x1 ,
    input logic sel ,
    output logic [DATA_WIDTH-1:0] f 
);

always_comb begin
    f = (sel) ? x1 : x0 ;
end

endmodule