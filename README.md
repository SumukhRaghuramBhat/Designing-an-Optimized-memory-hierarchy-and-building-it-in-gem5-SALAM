# Designing-an-Optimized-memory-hierarchy-and-building-it-in-gem5-SALAM
A set of applications are initially chosen and their memory access is examined at LLVM abstraction using the Locality Aware Memory Assignment and Tiling (LAMAT). It is an open source tool for automated application-specific on-chip memory assignment and tiling which uses the gem5-Aladdin tool for performance &amp; power evaluation. But instead of using gem5-Aladdin, this project would build it on gem5-SALAM. Using LAMAT with gem5-SALAM optimizes the memory hierarchy by automatically combining the benefits of cache and scratchpad at variable level granularity per individual application.

# Implementation methodology: 
Running the open source tool – LAMAT, which initially had Pointer Identification, Pointer Behavioral Analysis and Stride Measurement Stages.
The output obtained from the LAMAT is The Memory Access Pattern file ( .amap ) which groups pointer information at the function level and displays information for every global variable captured within that function.
Configuring and building the 3.8.1 version of LLVM and having algorithm specific modifications in the accelerator source of gem5-SALAM
Building this on the gem5-SALAM by making necessary changes in the configuration files (in Python) - validate_acc.py, top function, the respective changes for the pio.
Use of Machsuite benchmarks for the results.
Analyzing the performance of the LAMAT tool built in gem5-SALAM.

# Simulation Setup: 
Running the LAMAT tool - for automated application-specific on-chip memory assignment and tiling to obtain the .amap file.
Algorithm specific modifications in the accelerator source of gem5-SALAM.
The simulation framework offers a general-purpose communication interface that allows a scalable and flexible connection into the gem5 ecosystem. 
Modifying the configuration scripts of .py -enabling modifications to the system hierarchy without the need to rebuild the underlying simulator.

# Targeted Platforms: Machsuite benchmarks:
(BFS, GEMM, GEMM unrolled, FFT, Needwun, 3D Stencil, SPMV, MD-KNN, MD-Grid)

## Dependencies

**LLVM/CLANG** - Tested on versions 3.5 and 3.8

## Getting Started

To run the tool run 'llvm\_parser <LLVM\_FILE>'

This will export a '.amap' file in the same directory as the original file. The amap file
contains a breakdown of all variable index calculations for each function. Variable accesses
are also broken down according to the basic block in which they are accessed. 

### Non-numeric Stride Descriptors

* **RUNTIME DEPENDENT STRIDE** - This variable has an index based on a variable passed into the function
    at runtime.
* **VECTOR WIDTH** - Occurs when a multidimensional array is accessed with a uniform constant as its last
    index. This stride will depend on the element width of the array.
* **VARIABLE: MULTIPLE CONTROLLING INDVARS** - Multiple induction variables are used to access the variable
    in the same basic block. Stride will vary depending on how these indvars increment with respect to each
    other.
* **VARIABLE: IRREGULAR CONSTANTS** - Variable is accessed at statically defined points, but there is no uniform
    stride between these. The average distance is given, but this variable may not progress in a uniform direction.
    
# gem5-SALAM #

SALAM (System Architecture for LLVM-based Accelerator Modeling) integrated custom accelerator modeling into gem5 via a runtime LLVM interpreter.

## Requirements ##
- LLVM-3.8
- Frontend LLVM compiler for preferred development language (eg. clang for C)
- gem5 dependencies

## Usage ##
Define the computation model of you accelerator in you language of choice, and compile to LLVM IR. Control and dataflow graph optimization (eg. loop unrolling) should be handeled by the compiler. Construct accelerators by associating their LLVM IR with an LLVMInterface and connecting it to the desired CommInterface in the gem5 memory map.

Examples for system-level configuration can be found in configs/common/HWAcc.py.
Accelerator benchmarks and examples can be found in benchmarks. benchmarks/dmatest and benchmarks/streamdmatest contain examples for configuring and using central and streaming DMA devices.
The benchmarks/common folder contains basic drivers and syscalls for baremetal simulation.

Baremetal examples can be running using:
> baremetalarm.sh [benchmark] 
Similarly use systemValidation.sh

# Results and Analysis: 
Analyzing three of the MachSuite benchmarks: MD-KNN, BFS and  SPMV

