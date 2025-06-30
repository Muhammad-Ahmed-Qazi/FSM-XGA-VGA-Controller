# FSM-Based VGA Controller (XGA 1024×768 @ 60 Hz)

This project implements a **VGA controller for the XGA standard (1024×768 @ 60Hz)** using **Finite State Machines (FSMs)** for generating horizontal and vertical sync signals. The controller is written in **SystemVerilog** and is structured for clarity, modularity, and FPGA implementation on the **Intel DE1-SoC** board.

---

## 🧠 Overview

Unlike traditional counter-based VGA timing designs, this controller uses **Moore-style FSMs** to represent the timing states of HSYNC and VSYNC independently. It features:

- FSM-based control of sync signals
- Pixel counters separate from FSMs for modularity
- ROM-based timing parameterisation for flexibility
- Simple RGB pattern generator for display verification
- Ready-to-run simulation testbench

---

## 📁 Project Structure

```bash
vga-controller/
│
├── src/
│   ├── vga_controller.sv       # Top-level module
│   ├── fsm_hsync.sv            # Horizontal sync FSM
│   ├── fsm_vsync.sv            # Vertical sync FSM
│   ├── video_pattern.sv        # RGB pattern generator (test image)
│
├── testbench/
│   └── vga_tb.sv               # Testbench for simulation
│
├── mem/
│   ├── hsync_rom.mem           # Horizontal state end values (ROM-based)
│   ├── vsync_rom.mem           # Vertical state end values (ROM-based)
│
├── vga_tb.vcd                  # Waveform output (generated after sim)
├── README.md                   # This file
```

## 🧱 FSM Architecture

### HSYNC FSM (Horizontal)

- **States**: Visible, Front Porch, Sync Pulse, Back Porch  
- **Inputs**: `clk`, `reset`  
- **Outputs**: `pixel_x`, `hsync`, `video_on_h`, `line_done`

### VSYNC FSM (Vertical)

- **States**: Visible, Front Porch, Sync Pulse, Back Porch  
- **Inputs**: `clk`, `reset`, `line_done`  
- **Outputs**: `pixel_y`, `vsync`, `video_on_v`, `frame_done`

> The FSMs are Moore-style: outputs depend only on the current state.

---

## 🌈 RGB Pattern Generator

A simple vertical band pattern is used to visually validate sync timing:

- **Left third of screen**: Red  
- **Middle third**: Green  
- **Right third**: Blue  
- **Outside visible region**: Black  

Modify `video_pattern.sv` to experiment with other image styles or test patterns.

---

## 🧩 Extension Ideas

- Add support for other resolutions (e.g. SVGA, 720p) by modifying ROM contents  
- Replace the static pattern with **framebuffer-based video memory**  
- Display text, graphics, or animations  
- Port to other boards (e.g., Nexys A7, DE10-Lite)

---

## ⚡ FPGA Deployment

Designed with DE1-SoC FPGA timing in mind. To prepare for synthesis:

- Add a **65 MHz clock constraint**  
- Ensure proper **pin assignments** for VGA output (HSYNC, VSYNC, RGB)  
- Consider adding **reset debounce** and **PLL logic** for real-world stability

---

## 🙌 Acknowledgements

This project is part of a learning journey inspired by the book:  
**_Digital Design and Computer Architecture_** by David Harris and Sarah Harris.

Special thanks to **Sir Fahim** and the **NEDUET CIS department** for support and mentorship.

---
