This project implements a Full-Duplex SPI (Serial Peripheral Interface) communication system in Verilog. It consists of a master and a slave module connected through four standard SPI lines — MOSI, MISO, SCLK, and CS. The master initiates the communication by asserting the chip select (CS) low and generating the serial clock (SCLK).

During each clock pulse, the master transmits one bit of data to the slave through MOSI, while simultaneously receiving one bit from the slave through MISO. This enables parallel send and receive operations within a single clock cycle, achieving true full-duplex communication. Both devices use 8-bit shift registers to serialize and deserialize data during the transmission.

When all 8 bits have been exchanged, the master deactivates the chip select (CS high), signaling the end of the transaction. At this point, both the master and slave hold the data received from each other in their output registers. This design accurately models the working of real-world SPI systems, where synchronized data transfer between devices happens with precise timing and mutual coordination.

<img width="880" height="370" alt="Screenshot 2025-09-14 160607" src="https://github.com/user-attachments/assets/c9a2590e-5684-473b-94b1-6586ec7f7b67" />

<p align="center">
  <h2><b>SPI DUPLEX</b></h2>
<img width="1548" height="676" alt="Screenshot 2025-10-11 131929" src="https://github.com/user-attachments/assets/a6dd0e2d-39bd-4e2d-a045-67f4cd144e2e" />
  
<p align="center">
  <h2><b>SPI MASTER</b></h2>
<img width="1572" height="707" alt="Screenshot 2025-10-11 131409" src="https://github.com/user-attachments/assets/2406e21b-90d3-4709-93d0-bec69b51907d" />
  
<p align="center">
  <h2><b>SPI SLAVE</b></h2>
<img width="1427" height="727" alt="Screenshot 2025-10-11 131617" src="https://github.com/user-attachments/assets/e9c2b877-2560-47ef-bdb9-a7dcb64e322c" />


