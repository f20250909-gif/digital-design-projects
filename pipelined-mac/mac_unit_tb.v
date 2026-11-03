
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2026 20:40:35
// Design Name: 
// Module Name: mac_unit_tb
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

`timescale 1ns / 1ps

module tb_mac_unit;

    // Parameters matching default design specifications
    parameter PROD_WIDTH = 16;
    parameter INPUT_WIDTH   = 8;
    parameter ACC_WIDTH = 32;

    // Testbench signals
    reg clk;
    reg rst;
    reg en;
    reg  [INPUT_WIDTH-1:0]   A;
    reg  [INPUT_WIDTH-1:0]   B;
    wire [ACC_WIDTH-1:0] acc_out;
    wire [PROD_WIDTH-1:0] mult_reg;

    // Instantiate the Device Under Test (DUT)
    mac_unit #(
        .INPUT_WIDTH(INPUT_WIDTH),
        .PROD_WIDTH(PROD_WIDTH),
        .ACC_WIDTH(ACC_WIDTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .en(en),
        .A(A),
        .B(B),
        .mult_reg(mult_reg),
        .acc_out(acc_out)
    );

    // Clock generation: 100 MHz clock (10ns period)
    always #5 clk = ~clk;

   
    initial begin
        // Step 1: Initialize signals and apply synchronous reset
        clk = 0;
        rst = 1;
        en  = 0;
        A   = 0;
        B   = 0;

        #20;
        rst = 0; // De-assert reset
        // Test Case 1 : normal multiplication
        @(posedge clk);
        A <= 8'd3;
        B <= 8'd4;
        en <= 1'b1;

        @(posedge clk);
        A <= 8'd5;
        B <= 8'd2;
        en <= 1'b1;

        @(posedge clk);
        A  <= 8'd6;
        B  <= 8'd3;
        en <= 1'b1;

        // Test Case 2 : holding value
        @(posedge clk);
        A  <= 8'd10;
        B<= 8'd10;
        en <= 1'b0;

        @(posedge clk);
        A <= 8'd7;
        B <= 8'd3;
        en <= 1'b0;

        @(posedge clk);
        A <= 8'd4;
        B <= 8'd2;
        en <= 1'b1;

        // Test Case 3 : (255 * 255)
        @(posedge clk);
        A <= 8'hFF;
        B <= 8'hFF;
        en <= 1'b1;
        
        @(posedge clk);
        en <= 1'b0;
        A <= 8'd0;
        B <= 8'd0;
        
        repeat (3) @(posedge clk);
        $finish; 
    end
    initial begin
        $display("Time=%0t | rst=%b | en=%b | A=%d | B=%d | mult_reg=%d | acc_out=%d",
                 $time, rst, en, A, B, mult_reg, acc_out);
    end
    
endmodule




