# Parameterized Synchronous FIFO Memory Array Buffer

## Overview
Designed and verified a parameterized **Synchronous FIFO** memory buffer in Verilog HDL using **Xilinx Vivado (XSIM)**. The design utilizes a Simple Dual-Port RAM core for simultaneous read/write operations and implements pointer-based MSB wrap-around detection for status flag generation.

## Key Features
- **Parameterization:** Configurable `DATA_WIDTH` and `DEPTH`.
- **Memory Storage:** Simple Dual-Port RAM Array with independent write/read addresses.
- **Status Flags:** MSB wrap-bit comparison to generate `full` and `empty` signals without relying on occupancy counters.
- **Verification:** Tested with a self-checking testbench in Vivado Simulator (XSIM) covering burst writes, reads, and boundary conditions.

## Repository Layout
```text
synchronous-fifo/
├── rtl/        # Design source file(fifo.v)
├── tb/         # Testbench source files (tb_fifo.v)
└── README.md   # Project documentation
