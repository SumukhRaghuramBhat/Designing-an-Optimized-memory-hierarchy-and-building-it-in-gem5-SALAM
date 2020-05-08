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

#ifndef __DEPENDENCY_HH__
#define __DEPENDENCY_HH__

#include <iostream>
#include <fstream>
#include <vector>

enum DepType { INDUCTION, REGISTER, CONSTANT, NESTED_INDUCTION };

class Dependency {
  private:
    std::string name;
    DepType type;
  protected:

  public:
    Dependency(std::string nm) { name = nm; }
    void setType(DepType tp) { type = tp; }
    std::string getName() { return name; }
    DepType getType() { return type; }
    std::string getStringType() {
      switch(type) {
        case INDUCTION:
          return "INDUCTION";
        case REGISTER:
          return "REGISTER";
        case CONSTANT:
          return "CONSTANT";
        default:
          return "NESTED_INDUCTION";
      }
    }
    friend std::ostream& operator<<(std::ostream& os, const Dependency& dep);
};

typedef std::vector<Dependency *> dep_vector;

namespace dependencies {
  bool inIndvars(std::string name, dep_vector * indvars);
  dep_vector * getDeps(std::string line);
  dep_vector * getDeps(std::string line, dep_vector * indvars);
  dep_vector * getLoadDeps(std::string line);
  dep_vector * getLoadDeps(std::string line, dep_vector * indvars);
  dep_vector * getGEPDeps(std::string line);
  dep_vector * getGEPDeps(std::string line, dep_vector * indvars);
  dep_vector * getPhiDeps(std::string line);
  dep_vector * getPhiDeps(std::string line, dep_vector * indvars);
}


#endif //__DEPENDENCY_HH__
