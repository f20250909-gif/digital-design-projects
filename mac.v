`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2026 18:51:16
// Design Name: 
// Module Name: mac
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


module mac_unit #(
    parameter INPUT_WIDTH  = 8,
    parameter PROD_WIDTH = 16,      // Default: 16 bits
    parameter ACC_WIDTH  = 32                      // Default: 32 bits
)(
    input  wire clk,
    input  wire rst,
    input  wire en,
    input  wire [INPUT_WIDTH-1:0]    A,
    input  wire [INPUT_WIDTH-1:0]    B,
    output reg  [ACC_WIDTH-1:0]  acc_out,
    output reg  [PROD_WIDTH-1:0] mult_reg
);

    // Pipeline Registers
    
    reg valid_pipe;

    // Pipeline Stage 1: Multiplication
    always @(posedge clk) begin
        if (rst) begin
            mult_reg   <= 0;
            valid_pipe <= 0;
        end else if (en) begin
            mult_reg   <= A * B;
            valid_pipe <= 1'b1;
        end else begin
            valid_pipe <= 1'b0;
        end
    end

    // Pipeline Stage 2: Accumulation
    always @(posedge clk) begin
        if (rst) begin
            acc_out <= 0;
        end else if (valid_pipe) begin
            acc_out <= acc_out + mult_reg;
        end
    end

endmodule