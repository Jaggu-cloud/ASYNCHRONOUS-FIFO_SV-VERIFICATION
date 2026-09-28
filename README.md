# Asynchronous FIFO Design and Verification using SystemVerilog

## 1. Project Overview

This project focuses on the design and functional verification of an Asynchronous FIFO using SystemVerilog.

An Asynchronous FIFO is a First-In First-Out memory that uses independent write and read clocks. It is commonly used for data transfer between two modules operating in different clock domains.

## 2. Design Specifications

- FIFO Type: Asynchronous FIFO
- Data Width: 4 bits
- FIFO Depth: 16
- Write Clock: Independent
- Read Clock: Independent
- Design Language: Verilog
- Verification Language: SystemVerilog

## 3. Verification Environment

A class-based SystemVerilog testbench is developed with the following components:

- Packet: Stores transaction information.
- Generator: Generates randomized transactions.
- Driver: Drives transactions to the DUT.
- Monitor: Monitors FIFO input and output signals.
- Agent: Integrates the generator, driver, and monitor.
- Scoreboard: Compares expected and actual data.
- Coverage Class: Collects functional coverage using covergroups and coverpoints.
- Environment: Instantiates and connects the verification components.
- Testbench: Instantiates the DUT and provides clock and reset signals.

## 4. Functional Coverage

Functional coverage is implemented using a separate SystemVerilog class.

- Covergroups and coverpoints for FIFO operations.
- Coverage of read and write transactions.
- Coverage of full and empty conditions.
- Coverage sampling during simulation.
- Coverage analysis to identify untested scenarios.

## 5. Verification Scenarios

1. FIFO reset operation
2. Write operation
3. Read operation
4. Simultaneous read and write
5. FIFO full condition
6. FIFO empty condition
7. Randomized read and write transactions
8. Data integrity checking using the scoreboard

## 6. Tools Used

- SystemVerilog
- QuestaSim
- EDA Playground (if used)

## 7. Simulation Results

The scoreboard checks the data read from the FIFO against the expected data. Functional coverage is collected during simulation to measure the tested scenarios.

Add your actual simulation output, waveform screenshot, and coverage percentage here.

## 8. Author

Jagadesh Chowdary
