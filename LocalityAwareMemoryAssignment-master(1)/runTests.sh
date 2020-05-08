#!/bin/bash

./src/llvm_parser test/aes.ll
./src/llvm_parser test/bfs.ll
./src/llvm_parser test/gemm.ll
./src/llvm_parser test/gemm-unrolled.ll
./src/llvm_parser test/md.ll
./src/llvm_parser test/md-grid.ll
./src/llvm_parser test/nw.ll
./src/llvm_parser test/spmv.ll
./src/llvm_parser test/stencil2d.ll
./src/llvm_parser test/stencil3d.ll

