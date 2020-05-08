/*
 * Copyright (c) 2018, University of North Carolina at Charlotte
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are
 * met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 *    this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 *
 * 3. Neither the name of the copyright holder nor the names of its
 *    contributors may be used to endorse or promote products derived from
 *    this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
 * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
 * PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER
 * OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 * EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 * PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 * Authors: Samuel Rogers
 */

#ifndef __LLVM_PARSER_HH__
#define __LLVM_PARSER_HH__

#include "function.hh"

class LLVMParser {
  private:
    std::vector<Function *> functions;
    std::ifstream *in_file;
    std::ofstream *out_file;
    std::vector<std::string> fileGlobals;
    std::vector<std::string> structs;
    Function *currFxn;
    bool inFunction;
  protected:
    bool isGEP(std::string line) { return line.find("getelementptr") > 1 && line.find("getelementptr") < line.size(); }
    bool isFunctionHeader(std::string line) { return line.find("define")==0; }
    bool isFunctionFooter(std::string line) { return line.find("}")==0; }
  public:
    LLVMParser(std::ifstream *inFile, std::ofstream *outFile) {
      in_file = inFile;
      out_file = outFile;
      inFunction = false;
    }
    void parseFile();
    void outputToFile(std::string filename);
};

#endif //__LLVM_PARSER_HH__
