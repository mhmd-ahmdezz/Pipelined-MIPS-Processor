module hazard_detection_unit
#(
    parameter DATA_WIDTH = 32 ,
    parameter ADDR_WIDTH = 32 
)
(
    input  logic [4:0] rsE, rtE, // rsE, rtE, Source Register in Ex - stage, rdM: Destination Register in Mem-Stage
    input  logic [4:0] rsD, rtD,    // rsD, rtD, Source Register in ID - stage, rtE : Destination Register in EX-Stage
    input  logic RegWriteE, RegWriteM, RegWriteW, 
    input  logic MemtoRegE, MemtoRegM, BranchD,  
    input  logic [4:0]WriteRegM, WriteRegE, WriteRegW,
    output logic [1:0] ForwardAE, ForwardBE, // RAW and Lw data dependences forwarding
    output logic ForwardAD, ForwardBD, // Control Hazards
    output logic FlushE,StallD, StallF // FlushE Synchronous Reset/Clear for ID/EX pipeline register
);

//Internal Signals:
logic branchstall_R_type,branchstall_lw,branchstall,lwstall ;
//Forwarding from Mem - Stage has a priority over WB stage

// Forwarding : 

// if Source Register (Rs) equals to Destination Register (Mem or WB stage)
// and the current instruction requires writing to register file
always_comb begin
    if((rsE != 0) && (rsE == WriteRegM) && (RegWriteM)) 
        ForwardAE = 2'b10 ; // Forward from Mem to Ex
    else if((rsE != 0) && (rsE == WriteRegW) && (RegWriteW))
        ForwardAE = 2'b01 ; // Forward from WB to Ex
    else 
        ForwardAE = 2'b00 ;
end

// if Source Register (Rt) equals to Destination Register (Mem or WB stage)
// and the current instruction requires writing to register file
always_comb begin
    if((rtE != 0) && (rtE == WriteRegM) && (RegWriteM)) 
        ForwardBE = 2'b10 ; // Forward from Mem to Ex
    else if((rtE != 0) && (rtE == WriteRegW) && (RegWriteW))
        ForwardBE = 2'b01 ; // Forward from WB to Ex
    else 
        ForwardBE = 2'b00 ;
end

// Load Word Data dependences (Solving Data Hazards with stalls)
assign lwstall = ((rsD == rtE) || (rtD == rtE)) && MemtoRegE ;

//Branch Hazards
// Stalling

// Branch Stalling due to R - Type Instruction  : 
assign branchstall_R_type = RegWriteE && ((WriteRegE == rsD) || (WriteRegE == rtD)) ;
// Branch Stalling due to load word Instruction : 
assign branchstall_lw     = MemtoRegM && ((WriteRegM == rsD) || (WriteRegM == rtD)) ;

assign branchstall = (BranchD && branchstall_R_type) || (BranchD && branchstall_lw) ;
assign StallD = branchstall || lwstall ;
assign StallF = branchstall || lwstall ;
assign FlushE = branchstall || lwstall ;

//Forwarding
assign ForwardAD = (rsD != 0) && (rsD == WriteRegM) && RegWriteM ;
assign ForwardBD = (rtD != 0) && (rtD == WriteRegM) && RegWriteM ;

endmodule