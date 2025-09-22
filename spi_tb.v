`timescale 1ns / 1ps
`include "spi_top.v"

module tb_spi_duplex;
 initial begin
    $dumpfile("spi.vcd");
    $dumpvars(0, tb_spi_duplex);
    end
    // Testbench signals
    reg        clk;
    reg        reset;
    reg        start;
    reg  [7:0] master_data_in;
    reg  [7:0] slave_data_in;

    wire [7:0] master_data_out;
    wire [7:0] slave_data_out;
    wire       done;
    wire       busy;

    // Instantiate the top module
    spi_full_duplex_top uut (
        .clk(clk),
        .reset(reset),
        .start(start),
        .master_data_in(master_data_in),
        .slave_data_in(slave_data_in),
        .master_data_out(master_data_out),
        .slave_data_out(slave_data_out),
        .done(done),
        .busy(busy)
    );

    // Clock generation (50 MHz)
    initial clk = 0;
    always #10 clk = ~clk; // 20 ns period = 50 MHz

    // Test sequence
    initial begin
        // Initialize
        reset = 1;
        start = 0;
        master_data_in = 8'h00;
        slave_data_in  = 8'h00;

        #100;  // Wait 100 ns
        reset = 0;

        // Test case 1
        master_data_in = 8'hA5;  // Master sends 0xA5
        slave_data_in  = 8'h3C;  // Slave preloads 0x3C
        start = 1;
        #20 start = 0;           // Pulse start

        wait(done);              // Wait until master signals done
        #20;

        $display("Test 1: Master sent = %h, Master received = %h, Slave received = %h",
                 master_data_in, master_data_out, slave_data_out);

        // Test case 2
        master_data_in = 8'h55;  // Master sends 0x55
        slave_data_in  = 8'hF0;  // Slave preloads 0xF0
        start = 1;
        #20 start = 0;

        wait(done);
        #20;

        $display("Test 2: Master sent = %h, Master received = %h, Slave received = %h",
                 master_data_in, master_data_out, slave_data_out);

        // End simulation
        #100;
        $finish;
    end

endmodule
