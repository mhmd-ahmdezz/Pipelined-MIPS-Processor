module data_mem
#(
    parameter DATA_WIDTH = 32 ,
    parameter ADDR_WIDTH = 32
)
(
    input  logic clk,                               
    input  logic [ADDR_WIDTH-1:0] addr, // Address port    
    output logic [DATA_WIDTH-1:0] ReadData ,
    input  logic WE , // Write Enable           
    input  logic [DATA_WIDTH-1:0] WD // Write data   
);

//Byte-Addressable Memory (DATA_WIDTH/4)
logic [(DATA_WIDTH/4)-1:0] data_mem [255:0] ;

always_ff @(posedge clk) begin
    if(WE) 
        {data_mem[addr+3],data_mem[addr+2],data_mem[addr+1],data_mem[addr]} <= WD ;
        // {>>{data_mem[addr +: 4]}} <= WD ;
    // else 
    //     data_mem[addr] <= data_mem[addr];
end

// assign ReadData = {>>{data_mem[addr +: 4]}};
assign ReadData = {data_mem[addr+3],data_mem[addr+2],data_mem[addr+1],data_mem[addr]};

endmodule