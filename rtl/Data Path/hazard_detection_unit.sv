module hazard_detection_unit
#(
    parameter DATA_WIDTH = 32 ,
    parameter ADDR_WIDTH = 32 
)
(
    input  logic [4:0] rsE, rtE, rdM, rdW, // rsE, rtE, Source Register in Ex - stage, rdM: Destination Register in Mem-Stage
    input  logic RegWriteM, RegWriteW,
    output logic [1:0] ForwardAE, ForwardBE
);

//Forwarding from Mem - Stage has a priority over WB stage

// Forwarding : 

// if Source Register (Rs) equals to Destination Register (Mem or WB stage)
// and the current instruction requires writing to register file
always_comb begin
    if((rsE != 0) && (rsE == rdM) && (RegWriteM)) 
        ForwardAE = 2'b10 ; // Forward from Mem to Ex
    else if((rsE != 0) && (rsE == rdW) && (RegWriteW))
        ForwardAE = 2'b01 ; // Forward from WB to Ex
    else 
        ForwardAE = 2'b00 ;
end

// if Source Register (Rt) equals to Destination Register (Mem or WB stage)
// and the current instruction requires writing to register file
always_comb begin
    if((rtE != 0) && (rtE == rdM) && (RegWriteM)) 
        ForwardBE = 2'b10 ; // Forward from Mem to Ex
    else if((rtE != 0) && (rtE == rdW) && (RegWriteW))
        ForwardBE = 2'b01 ; // Forward from WB to Ex
    else 
        ForwardBE = 2'b00 ;
end

endmodule