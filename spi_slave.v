`timescale 1ns / 1ps

module spi_slave (
    input        clk,       
    input        reset,      
    input        CS,        
    input        SCLK,       // SPI Clock (from Master)
    input        MOSI,       // Master Out Slave In
    output reg   MISO,       // Master In Slave Out
    output reg [7:0] data_out, // Data received from Master
    input  [7:0] data_in     // Data to send back to Master
);

    reg [7:0] shift_in;      // Shift register for MOSI
    reg [7:0] shift_out;     // Shift register for MISO
    reg [2:0] bit_cnt;       // 3 Bit counter (0–7)

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            shift_in  <= 0;
            shift_out <= 0;
            data_out  <= 0;
            bit_cnt   <= 0;
            MISO      <= 0;
        end else if (CS) begin
            // When CS is high, reset
            shift_out <= data_in; 
            bit_cnt   <= 0;
        end
    end

    always @(posedge SCLK) begin
        if (!CS) begin
            shift_in <= {shift_in[6:0], MOSI};
            bit_cnt  <= bit_cnt + 1;
            if (bit_cnt == 3'd7) begin
                data_out <= {shift_in[6:0], MOSI}; // complete byte
                bit_cnt  <= 0;
            end
        end
    end
    // Drive outgoing bit on falling edge of SCLK when CS is low
    always @(negedge SCLK) begin
        if (!CS) begin
            MISO      <= shift_out[7];
            shift_out <= {shift_out[6:0], 1'b0};
        end
    end

endmodule
