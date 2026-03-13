`timescale 1ns/1ps
module top_tb;
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
    repeat(3) @(negedge clk) arst = 1'b0 ;
    repeat(100) @(negedge clk);
    #2 $stop;
end
endmodule