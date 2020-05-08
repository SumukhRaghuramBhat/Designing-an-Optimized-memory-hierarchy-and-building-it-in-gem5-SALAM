# Locality Aware Memory Assignment and Tiling

This is an open source tool for analyzing the per-variable locality of an application
in order to reduce the scope of design space exploration in hardware accelerator design.

## Dependencies

**LLVM/CLANG** - Tested on versions 3.5 and 3.8

## Getting Started

To run the tool run 'llvm\_parser <LLVM\_FILE>'

This will export a '.amap' file in the same directory as the original file. The amap file
contains a breakdown of all variable index calculations for each function. Variable accesses
are also broken down according to the basic block in which they are accessed. Use this alongside
a CFG obtained through the opt flag '-dot-cfg' to determine if basic block segments are in distinct
parts of the program execution. Temporal locality is heavily dependent on accesses occurring in the
same or adjacent segments. Variable strides are calculated within the scope of basic block. They
are also averaged across all basic block segments (only valid if segments are in distinct parts of the
program).

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

## Authors

* **Samuel Rogers** - *sroger48@uncc.edu*

## Citing Locality Aware Memory Assignment and Tiling

Please cite Locality Aware Memory Assignment and Tiling in your publications if it helps your research work:
```
@inproceedings{lamat,
 author = {Rogers, Samuel and Tabkhi, Hamed},
 title = {Locality Aware Memory Assignment and Tiling},
 booktitle = {Proceedings of the 55th Annual Design Automation Conference},
 series = {DAC '18},
 year = {2018},
 isbn = {978-1-4503-5700-5},
 location = {San Francisco, California},
 pages = {130:1--130:6},
 articleno = {130},
 numpages = {6},
 url = {http://doi.acm.org/10.1145/3195970.3196070},
 doi = {10.1145/3195970.3196070},
 acmid = {3196070},
 publisher = {ACM},
 address = {New York, NY, USA},
}
```

## License

Copyright (c) 2018, University of North Carolina at Charlotte
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

1. Redistributions of source code must retain the above copyright notice,
   this list of conditions and the following disclaimer.
2. Redistributions in binary form must reproduce the above copyright
   notice, this list of conditions and the following disclaimer in the
   documentation and/or other materials provided with the distribution.
3. Neither the name of the copyright holder nor the names of its
   contributors may be used to endorse or promote products derived from
   this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER
OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

Authors: Samuel Rogers - Transformative Computer Systems Architecture Research (TeCSAR) at UNC Charlotte
