module register_file
#(
    parameter DATA_WIDTH = 32 ,
    parameter ADDR_WIDTH = 5  ,
    parameter SP         = 29 , //Stack Pointer
    parameter GP         = 28  //Global Pointer
)
(
    input logic clk , arst ,
    //Read Port 
    input  logic [ADDR_WIDTH-1:0] A1  , A2  ,
    output logic [DATA_WIDTH-1:0] RD1 , RD2 ,
    //Write Port
    input  logic WE3 ,  
    input  logic [ADDR_WIDTH-1:0] A3  ,
    input  logic [DATA_WIDTH-1:0] WD3 
);

logic [DATA_WIDTH-1:0] reg_file [2**(ADDR_WIDTH)-1:0]  ;

always_ff @(posedge clk , posedge arst) begin
    if(arst) begin
        // Trying to reset the whole register file
        reg_file[SP] <= 'h7fffeffc ;
        reg_file[GP] <= 'h10008000 ;
        reg_file[0]  <= 'h0 ;
    end
    else if(WE3)
        reg_file[A3] <= WD3 ;
    else 
        reg_file[A3] <= reg_file[A3] ; 
end

//Read Port
always_comb begin
    if(WE3) begin
        // Internal Hazards : to handle the case if WB trying to write while ID trying to read data
        if(A1 == A2 && A1 == A3) begin // When A1 = A2 = A3 
            RD1 = WD3;
            RD2 = WD3;
        end
        else if(A1 == A3) begin
            RD1 = WD3 ;
            RD2 = reg_file[A2];
        end
        else if(A2 == A3) begin
            RD1 = reg_file[A1];
            RD2 = WD3 ;
        end
        else begin
            RD1 = reg_file[A1] ;
            RD2 = reg_file[A2] ;
        end 
    end
    else begin
        RD1 = reg_file[A1] ;
        RD2 = reg_file[A2] ;
    end
end

endmodule