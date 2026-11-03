//////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.10.2026 17:57:20
// Design Name: 
// Module Name: tb_fifo
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

module tb_fifo;

    // Define parameters matching the FIFO specifications
    parameter DATA_WIDTH = 8;
    parameter DEPTH      = 16;

    // Testbench signals
    reg                  clk;
    reg                  rst;
    reg                  write_en;
    reg                  read_en;
    reg [DATA_WIDTH-1:0] data_in;
    wire [DATA_WIDTH-1:0] data_out;
    wire                 full;
    wire                 empty;

    // Instantiate the Device Under Test (DUT)
    fifo #(
        .DATA_WIDTH(DATA_WIDTH),
        .DEPTH(DEPTH)
    ) dut (
        .clk(clk),
        .rst(rst),
        .write_en(write_en),
        .read_en(read_en),
        .data_in(data_in),
        .data_out(data_out),
        .full(full),
        .empty(empty)
    );

    // Clock generation: 100 MHz clock (10ns period)
    always #5 clk = ~clk;

    integer i;

    initial begin
        // Step 1: Initialize inputs and apply an active-high reset
        clk      = 0;
        rst      = 1;
        write_en = 0;
        read_en  = 0;
        data_in  = 0;

        #20;
        rst = 0; // De-assert reset to begin normal operation
       
        // Step 2: Test Full condition by continuously writing until FIFO is filled
        for (i = 0; i < DEPTH; i = i + 1) begin
            @(posedge clk);
            if (!full) begin
                write_en <= 1;
                data_in  <= $random % 256; // Inject random data
            end
        end
        @(posedge clk);
        write_en <= 0; // Stop writing once full
        

        // Step 3: Test Empty condition by continuously reading until FIFO is drained
        for (i = 0; i < DEPTH; i = i + 1) begin
            @(posedge clk);
            if (!empty) begin
                read_en <= 1;
            end
        end
        @(posedge clk);
        read_en <= 0; // Stop reading once empty
        

        // Step 4: Test simultaneous write and read behavior
        @(posedge clk);
        write_en <= 1;
        data_in  <= 8'hAA; // Write initial data starting from 8'hAA
        
        
        @(posedge clk);
        write_en <= 0;
        
        for (i = 0; i < 5; i = i + 1) begin
            @(posedge clk);
            write_en <= 1;
            read_en  <= 1;
            data_in  <= $random % 256;
        end
        
        @(posedge clk);
        write_en <= 0;
        read_en  <= 0; 
        
        $finish;
    end
    
endmodule



        

