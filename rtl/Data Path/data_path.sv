module data_path
#(
    parameter DATA_WIDTH   = 32 ,
    parameter ADDR_WIDTH   = 32 ,
    parameter OPCODE_FIELD = 6  ,
    parameter FUNCT_FIELD  = 6 
)
(
    input  logic clk, arst,
    input  logic RegWriteD, MemtoRegD, MemWriteD,
    input  logic BranchD, ALUSrcD,RegDstD,
    input  logic[2:0] ALUControlD ,
    output logic[OPCODE_FIELD-1:0] Opcode ,
    output logic[FUNCT_FIELD-1:0] Funct
);

//Internal Signals: 

//IF - Stage : Internal Signals
logic [ADDR_WIDTH-1:0] PCF, next_pcf,PCPlus4F;
logic [DATA_WIDTH-1:0] ReadDataF ;


//ID - Stage : Internal Signals
logic [DATA_WIDTH-1:0] InstrD, PCPlus4D, PCBranchD;
logic [DATA_WIDTH-1:0] RegFile_ReadData1_D,RegFile_ReadData2_D;
logic [DATA_WIDTH-1:0] mux_0_D_out,mux_1_D_out;
logic [DATA_WIDTH-1:0] RegFile_ReadData1_E,RegFile_ReadData2_E;
logic [DATA_WIDTH-1:0] SignImmD ;
logic EqualD, PCSrcD ;

//EX - Stage : Internal Signals
logic [DATA_WIDTH-1:0] SrcAE, SrcBE;
logic [4:0] RtE, RsE, RdE, WriteRegE ;
logic [DATA_WIDTH-1:0] SignImmE , PCPlus4E ;
logic [DATA_WIDTH-1:0] WriteDataE,ALUOutE;
logic RegWriteE, MemtoRegE, MemWriteE;
logic [2:0] ALUControlE ;
logic ALUSrcE, RegDstE, ZeroE ;


//MEM - Stage : Internal Signals
logic [DATA_WIDTH-1:0] ALUOutM , WriteDataM, ReadDataM;
logic RegWriteM ,MemtoRegM, MemWriteM;
logic [4:0] WriteRegM ;

//WB - Stage : Internal Signals
logic [DATA_WIDTH-1:0]ALUOutW, ReadDataW,ResultW;
logic MemtoRegW, RegWriteW ;
logic [4:0] WriteRegW ;

//Hazard Detection Unit: Internal Signals
logic FlushE,StallD,StallF ;
logic [1:0] ForwardAE, ForwardBE ;
logic [1:0] ForwardAD, ForwardBD ;


//IF - Stage : Instruction Fetch Stage
// always_ff @(posedge clk) begin
//     if(PCSrcD) begin
//         InstrD <= 'd0 ;
//         PCPlus4D <= 'd0 ;
//     end
//     else if(StallD) begin
//         InstrD <= InstrD ;
//         PCPlus4D <= PCPlus4D ;
//     end
//     else begin
//         InstrD <= ReadDataF ;
//         PCPlus4D <= PCPlus4F ;
//     end
// end
always_ff @(posedge clk, posedge arst) begin
    if(StallD) begin
        InstrD <= InstrD ;
        PCPlus4D <= PCPlus4D ;
    end
    else if(PCSrcD) begin
        InstrD <= 'd0 ;
        PCPlus4D <= 'd0 ;
    end
    else if(!arst) begin
        InstrD <= ReadDataF ;
        PCPlus4D <= PCPlus4F ;
    end
    else begin
        InstrD <= 'd0 ;
        PCPlus4D <= 'd0 ;
    end
end

// Instruction Memory
InstructionMemory #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) instr_mem(
    .addr(PCF),
    .ReadData(ReadDataF)
);

//Program Counter Register
pc_register #(.DATA_WIDTH(ADDR_WIDTH)) program_counter
(
    .clk(clk), 
    .arst(arst),
    .En(!StallF),
    .next_pc(next_pcf) ,
    .current_pc(PCF) 
);

//Mux - 0 : to choose between PCBranch or PC+4
mux_2x1 #(.DATA_WIDTH(ADDR_WIDTH)) mux_0_F
(   
    .x0(PCPlus4F),
    .x1(PCBranchD) ,
    .sel(PCSrcD) ,
    .f(next_pcf) 
);

assign PCPlus4F = PCF + 'd4 ; //Advance the program counter 


//ID - Stage : Instruction Decode Stage
always_ff @(posedge clk , posedge arst) begin
    if(FlushE) begin
        RsE <= 'd0 ;
        RtE <= 'd0 ;
        RdE <= 'd0 ;
        RegWriteE <= 1'b0 ;
        MemWriteE <= 1'b0 ;
    end
    else if(!arst) begin
        RegFile_ReadData1_E <= RegFile_ReadData1_D ;
        RegFile_ReadData2_E <= RegFile_ReadData2_D ;
        RsE <= InstrD[25:21] ;
        RtE <= InstrD[20:16] ;
        RdE <= InstrD[15:11] ;
        SignImmE <= SignImmD ;
        PCPlus4E <= PCPlus4D ;
        // Control Signals 
        RegWriteE <= RegWriteD ;
        MemtoRegE <= MemtoRegD ;
        MemWriteE <= MemWriteD ;
        ALUControlE <= ALUControlD ;
        ALUSrcE <= ALUSrcD ;
        RegDstE <= RegDstD ;
    end
    // else if(FlushE) begin
    //     RsE <= 'd0 ;
    //     RtE <= 'd0 ;
    //     RdE <= 'd0 ;
    //     RegWriteE <= 1'b0 ;
    //     MemWriteE <= 1'b0 ;
    // end
    else begin
        SignImmE  <= 'd0 ;
        PCPlus4E  <= 'd0 ;
        RegWriteE <= 'd0 ;
        MemtoRegE <= 'd0 ;
        ALUControlE <= 'd0 ;
        ALUSrcE <= 'd0 ;
        RegDstE <= 'd0 ;
    end
end

// BTA = SignImm * 4 + (PC + 4) , Branch Target Address : PCrelative Addressing Mode
assign PCBranchD = (SignImmD<<2) + (PCPlus4D) ;
assign EqualD = (mux_0_D_out == mux_1_D_out) ;
assign PCSrcD = BranchD & EqualD ;


assign Opcode = InstrD[31:26] ;
assign Funct  = InstrD[5:0]   ;

//Register File
register_file RegFile(
    .clk(clk),
    .arst(arst) , 
    .A1(InstrD[25:21]),
    .A2(InstrD[20:16]),
    .RD1(RegFile_ReadData1_D),
    .RD2(RegFile_ReadData2_D),
    .WE3(RegWriteW) ,  
    .A3(WriteRegW[4:0])  ,
    .WD3(ResultW) 
);

mux_4x1 #(.DATA_WIDTH(DATA_WIDTH)) mux_0_D
(   
    .x0(RegFile_ReadData1_D),
    .x1(ResultW) ,
    .x2(ALUOutM),
    .x3('d0),
    .sel(ForwardAD) ,
    .f(mux_0_D_out) 
);

mux_4x1 #(.DATA_WIDTH(DATA_WIDTH)) mux_1_D
(   
    .x0(RegFile_ReadData2_D),
    .x1(ResultW),
    .x2(ALUOutM),
    .x3('d0),
    .sel(ForwardBD) ,
    .f(mux_1_D_out) 
);
// Sign Extension
sign_extender #(.DATA_WIDTH(DATA_WIDTH)) sign_extend_D(
    .in(InstrD[15:0]),
    .out(SignImmD)
);

// EX - Stage : Execution Stage
always_ff @(posedge clk , posedge arst) begin
    if(!arst) begin
        ALUOutM <= ALUOutE ;
        WriteDataM <= WriteDataE ;
        WriteRegM <= WriteRegE ;
        //Control Signals
        RegWriteM <= RegWriteE ;
        MemtoRegM <= MemtoRegE ;
        MemWriteM <= MemWriteE ;
    end
    else begin
        RegWriteM <= 'd0 ;
        MemtoRegM <= 'd0 ;
        MemWriteM <= 'd0 ;
    end
end

// ALU
alu #(.DATA_WIDTH(DATA_WIDTH)) alu(
    .A(SrcAE),
    .B(SrcBE),
    .op(ALUControlE),
    .result(ALUOutE),
    .zero(ZeroE)
);

// Mux 2x1 : to choose between SignImmE & ReadData from RF 
mux_2x1 #(.DATA_WIDTH(DATA_WIDTH)) mux_1_E
(   
    .x0(WriteDataE),
    .x1(SignImmE) ,
    .sel(ALUSrcE) ,
    .f(SrcBE) 
);

// Mux 2x1 : to choose between RtE & RdE 
mux_2x1 #(.DATA_WIDTH(5)) mux_2_E
(   
    .x0(RtE),
    .x1(RdE) ,
    .sel(RegDstE) ,
    .f(WriteRegE) 
);

// MEM - Stage : Memory Stage

//Data Memory
data_mem #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) data_mem
(
    .clk(clk),                               
    .addr(ALUOutM), // Address port    
    .ReadData(ReadDataM) ,
    .WE(MemWriteM) , // Write Enable           
    .WD(WriteDataM) // Write data   
);

//WB - Stage : Write Back Stage
always_ff @(posedge clk, posedge arst) begin
    if(!arst) begin
        RegWriteW <= RegWriteM ;
        MemtoRegW <= MemtoRegM ;
        ALUOutW <= ALUOutM ;
        ReadDataW <= ReadDataM ;
        WriteRegW <= WriteRegM ;
    end
    else begin
        RegWriteW <= 'd0 ;
        MemtoRegW <= 'd0 ;
    end
end

//Mux-2x1 : to Choose from ALUOutW and ReadDataW 
mux_2x1 #(.DATA_WIDTH(DATA_WIDTH)) mux_3_W
(   
    .x0(ALUOutW),
    .x1(ReadDataW) ,
    .sel(MemtoRegW) ,
    .f(ResultW) 
);

// Hazards Detection Unit (HDU):

hazard_detection_unit #(.DATA_WIDTH(DATA_WIDTH),.ADDR_WIDTH(ADDR_WIDTH)) HDU
(
    .rsE(RsE),
    .rtE(RtE),
    .rsD(InstrD[25:21]),
    .rtD(InstrD[20:16]),
    .RegWriteE(RegWriteE),
    .RegWriteM(RegWriteM),
    .RegWriteW(RegWriteW),
    .MemtoRegE(MemtoRegE),
    .MemtoRegM(MemtoRegM),
    .BranchD(BranchD),
    .WriteRegE(WriteRegE),
    .WriteRegM(WriteRegM),
    .WriteRegW(WriteRegW),
    .ForwardAE(ForwardAE),
    .ForwardBE(ForwardBE),
    .ForwardAD(ForwardAD),
    .ForwardBD(ForwardBD),
    .FlushE(FlushE),
    .StallD(StallD),
    .StallF(StallF)
);


// Forwarding Multiplexors
mux_4x1 #(.DATA_WIDTH(DATA_WIDTH)) fwd_mux_0(
    .x0(RegFile_ReadData1_E),
    .x1(ResultW),
    .x2(ALUOutM),
    .x3('d0),
    .sel(ForwardAE),
    .f(SrcAE)
);

mux_4x1 #(.DATA_WIDTH(DATA_WIDTH)) fwd_mux_1(
    .x0(RegFile_ReadData2_E),
    .x1(ResultW),
    .x2(ALUOutM),
    .x3('d0),
    .sel(ForwardBE),
    .f(WriteDataE)
);


endmodule