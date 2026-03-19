`timescale 1ns/1ps
module top_tb;
int max_cycles, cycle_count ;
//Declare the logic, localparam, and identifiers
parameter DATA_WIDTH = 32 ;
parameter ADDR_WIDTH = 32 ;
parameter OPCODE_FIELD = 6 ;
parameter FUNCT_FIELD = 6 ;
logic clk = 1'b0 ;
logic arst ;
//Instantiate the module under test
top DUT(.*);
//Generate the clock
localparam T = 10 ;
always #(T/2) clk = ~ clk ;
//Create the stimulus using initial block
initial begin
    arst = 1'b0 ;
    #2 arst = 1'b1 ;
    repeat(3) @(negedge clk) ;
    arst = 1'b0 ;
    if($value$plusargs("MAX_CYCLES=%d",max_cycles)) begin
        $display("[TB INFO] Simulation will run for %0d cycles based on MARS Input.",max_cycles);
    end
    else begin
        max_cycles = 500 ;
        $display("[TB Warning] MAX_CYCLES not found. Defaulting to %0d.",max_cycles);
    end
    repeat(max_cycles+5) begin
        @(posedge clk);
        cycle_count = cycle_count + 1;
    end
    $display("[TB INFO] Reached %0d cycles. Initiating Register Dump...",cycle_count);
    #2 $stop;
end
endmodule