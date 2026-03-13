module sign_extender
#(parameter DATA_WIDTH = 32)
(
    input  logic [15:0] in ,
    output logic [DATA_WIDTH-1:0] out
);

assign out = {{16{in[15]}},in} ;

endmodule