`timescale 1ns / 1ps
`include "spi_master.v"
`include "spi_slave.v"

module spi_full_duplex_top (
    input        clk,       // System clock
    input        reset,     // Reset
    input        start,     // Start transfer (master)
    input  [7:0] master_data_in, // Data to send from master to slave
    input  [7:0] slave_data_in,  // Data to preload into slave for response

    output [7:0] master_data_out, // Data received by master from slave
    output [7:0] slave_data_out,  // Data received by slave from master
    output       done,            // Master done flag
    output       busy             // Master busy flag
);

    // Internal SPI signals (wires)
    wire CS;    
    wire SCLK;
    wire MOSI; 
    wire MISO;

    // Instantiate Master
    spi_master #(
        .CLK_FREQ(50_000_000),   // 50 MHz system clock
        .SPI_FREQ(1_000_000)     // 1 MHz SPI clock
    ) u_master (
        .clk(clk),
        .reset(reset),
        .data_in(master_data_in),
        .start(start),
        .CS(CS),
        .SCLK(SCLK),
        .MOSI(MOSI),
        .MISO(MISO),
        .data_out(master_data_out),
        .busy(busy),
        .done(done)
    );

    // Instantiate Slave
    spi_slave u_slave (
        .clk(clk),
        .reset(reset),
        .CS(CS),
        .SCLK(SCLK),
        .MOSI(MOSI),
        .MISO(MISO),
        .data_out(slave_data_out),
        .data_in(slave_data_in)
    );

endmodule
