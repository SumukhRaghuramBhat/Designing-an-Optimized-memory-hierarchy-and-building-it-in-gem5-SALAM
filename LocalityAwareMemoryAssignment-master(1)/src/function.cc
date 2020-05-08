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

#include "function.hh"

using namespace std;

Function::Function(string line, vector<string> *fileGlobals, int pos) {
    //Find the function name
    size_t nameptr = line.find("@") + 1;
    size_t nameendptr = line.find("(", nameptr);
    funcName = line.substr(nameptr, nameendptr-nameptr);
    //Find the function params
    size_t paramsptr = nameendptr + 1;
    size_t paramsendptr = line.rfind(")");
    params = line.substr(paramsptr, paramsendptr-paramsptr);
    //Parse the global var names from params
    size_t ptr = 0;
    for (int i=0; i<fileGlobals->size(); i++) {
        globals.push_back(fileGlobals->at(i));
    }
    if (params.length()>0) {
        while (ptr < params.rfind("%")) {
            ptr = params.find("%", ptr) + 1;
            if (params.substr(ptr, 6).compare("struct") != 0) {
                size_t endptr = params.find_first_of(",)", ptr);
                globals.push_back(params.substr(ptr, endptr-ptr));
            }
        }
    }
    bbList.push_back("%0");
    headerPtr = pos;
}

void
Function::findInductionVars(ifstream * file) {
    string line;
    while(getline(*file, line)) {
        if (line.find("}") == 0) {
            break;
        } else if (line.find(" phi ") != string::npos) {
            string candidate = line.substr(2,line.find(" = ")-2);
            dep_vector * deps = dependencies::getPhiDeps(line);
            if (deps->size()==2) {
                int tmpPtr = file->tellg();
                bool inductionFound = false;
                while(getline(*file, line) && line.find("}") != 0) {
                    size_t tmp = line.find(deps->at(0)->getName());
                    if (tmp < 4 && tmp != string::npos) {
                        size_t addop = line.find("add");
                        if ((addop != string::npos)) {
                            dep_vector * inner_deps = 
                                dependencies::getDeps(line.substr(addop));
//                            if(inner_deps->size()==2 &&
//                               inner_deps->at(0)->getName().compare(candidate)==0 &&
//                               (inner_deps->at(1)->getName().compare("1")==0 || 
//                               inner_deps->at(1)->getName().compare("-1")==0)) {
                            if (inner_deps->size()==2 && 
                                inner_deps->at(0)->getName().compare(candidate)==0) {
                                if (abs(atoi(inner_deps->at(1)->getName().c_str())) < 8) {
                                    //found an induction variable
                                    indvars.push_back(new Dependency(candidate));
                                    indvars.back()->setType(INDUCTION);
                                    inductionFound=true;
                                }
                            }
                        }
                    break;
                    }
                }
                if (!inductionFound) {
                    file->seekg(tmpPtr, file->beg);
                    while(getline(*file, line) && line.find("}") != 0) {
                        size_t tmp = line.find(deps->at(1)->getName());
                        if (tmp < 4 && tmp != string::npos) {
                            size_t addop = line.find("add");
                            if ((addop != string::npos)) {
                                dep_vector * inner_deps = 
                                    dependencies::getDeps(line.substr(addop));
//                                if(inner_deps->size()==2 &&
//                                   inner_deps->at(0)->getName().compare(candidate)==0 &&
//                                   (inner_deps->at(1)->getName().compare("1")==0 || 
//                                   inner_deps->at(1)->getName().compare("-1")==0)) {
                                if (inner_deps->size()==2 && 
                                inner_deps->at(0)->getName().compare(candidate)==0) {
                                    if (abs(atoi(inner_deps->at(0)->getName().c_str())) < 8) {
                                        //found an induction variable
                                        indvars.push_back(new Dependency(candidate));
                                        indvars.back()->setType(INDUCTION);
                                    }
                                }
                            }
                        break;
                        }
                    }
                }
                file->seekg(tmpPtr, file->beg);
            }
        }
    }
}

int
Function::findVar(string nm) {
    for (int i=0; i<vars.size(); i++) {
        if(vars[i]->getName().compare(nm)==0) {
            return i;
        }
    }
    return -1;
}

bool
Function::isGlobalVar(string var) {
    for (int i=0; i<globals.size(); i++) {
        if (globals[i].compare(var) == 0)
            return true;
    }
    return false;
}

void
Function::updVarList(string line, ifstream * file) {
    size_t varptr = line.find("*");
    varptr = line.find("@", varptr);
    if (varptr == string::npos)
        varptr = line.find("%", line.find("*"));
    varptr++;
    size_t varendptr = line.find(",", varptr);
    string varname = line.substr(varptr, varendptr-varptr);
    int varidx = findVar(varname);
    if (varidx < 0) {
        vars.push_back(new Variable(line, bbList.back(), &indvars));
        varidx = vars.size()-1;
    } else {
        vars[varidx]->updVar(line, bbList.back(), varendptr);
    }
    vars.at(varidx)->updPredictable(headerPtr, &globals, file);
}

void
Function::addBasicBlock(string line) {
    size_t bbptr;
    size_t bbendptr;
    if (line.find("<label>") != string::npos) {
        bbptr = 10;
        bbendptr = line.find(" ", bbptr);
    } else {
        bbptr = 0;
        bbendptr = line.find(": ");
    }
    bbList.push_back("%"+line.substr(bbptr, bbendptr-bbptr));
}

void
Function::calcVarStrides() {
    for (int i=0; i<vars.size(); i++) {
        vars.at(i)->evalStride();
    }
}

std::ostream& operator<<(std::ostream& os, const Function& func) {
    os << "Function: " << func.funcName << "\nParams:\n" << func.params << "\n\n";
    for (int i=0; i<func.vars.size(); i++) {
        os << *(func.vars[i]);
    }

    os << "\n\n";

    return os;
}
