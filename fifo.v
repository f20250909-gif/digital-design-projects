`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.10.2026 20:57:43
// Design Name: 
// Module Name: fifo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH      = 16
)(
    input clk,
    input rst,
    input write_en,
    input read_en,
    input [DATA_WIDTH-1:0] data_in,
    output reg  [DATA_WIDTH-1:0] data_out,
    output full,
    output empty
);

    // Calculate pointer width(no of bits req. to specify the memory address based on DEPTH
    localparam ADDR_WIDTH = $clog2(DEPTH);

    // Memory array
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];

    // Read and Write Pointers (extra bit used for full/empty detection)
    reg [ADDR_WIDTH:0] w_ptr;
    reg [ADDR_WIDTH:0] r_ptr;

    // Full and Empty status flags
    assign empty = (w_ptr == r_ptr);
    assign full  = (w_ptr[ADDR_WIDTH-1:0] == r_ptr[ADDR_WIDTH-1:0]) && 
                   (w_ptr[ADDR_WIDTH] != r_ptr[ADDR_WIDTH]);

    // Write Operation
    always @(posedge clk) begin
        if (rst) begin
            w_ptr <= 0;
        end else if (write_en && !full) begin
            mem[w_ptr[ADDR_WIDTH-1:0]] <= data_in;
            w_ptr <= w_ptr + 1'b1;
        end
    end

    // Read Operation
    always @(posedge clk) begin
        if (rst) begin
            r_ptr    <= 0;
            data_out <= 0;
        end else if (read_en && !empty) begin
            data_out <= mem[r_ptr[ADDR_WIDTH-1:0]];
            r_ptr    <= r_ptr + 1'b1;
        end
    end

endmodule