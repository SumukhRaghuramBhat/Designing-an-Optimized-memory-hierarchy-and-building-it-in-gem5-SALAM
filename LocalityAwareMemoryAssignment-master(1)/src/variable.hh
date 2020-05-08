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

#ifndef __VARIABLE_HH__
#define __VARIABLE_HH__

#include <sstream>
#include "dependency.hh"

class Variable {
  private:
    std::vector<std::string> bbList;
    std::vector<int> bbSegLen;
    std::vector<int> bbSegPtr;
    std::vector<int> segStride;
    std::vector<std::string> segStrideStr;
    std::vector<std::string> instruction;
    std::string varType;
    std::string varName;
    std::vector<dep_vector *> deps;
    dep_vector * indvars;
    bool predictable;
    int totalAccesses;
    int stride;
    std::string strideStr;
  protected:
    bool chkPredictable(Dependency * dep, dep_vector * ldet, int headerPtr,
                        std::vector<std::string> * globals,
                        std::ifstream * file);
    bool isStructType() { return varType.find("struct")!=std::string::npos; }
    void evalSegStride(int segNum);
  public:
    Variable(std::string line, std::string basic_block, dep_vector * indv);
    bool isPredictable() { return predictable; }
    std::string getName() { return varName; }
    void updVar(std::string line, std::string basic_block, size_t varend);
    void findNESTEDIndvars(Dependency * dep, int headerPtr, std::ifstream * file);
    void updPredictable(int headerPtr, std::vector<std::string> * globals,
                        std::ifstream * file);
    void evalStride();
    dep_vector * getLastDepVec() { return deps.at(deps.size()-1); }
    friend std::ostream& operator<<(std::ostream& os, const Variable& var);
};

#endif //__VARIABLE_HH__
