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

#include "variable.hh"
#include <cmath>

using namespace std;

Variable::Variable(string line, string basic_block, dep_vector * indv) {
    instruction.push_back(line);
    bbList.push_back(basic_block);
    bbSegLen.push_back(1);
    bbSegPtr.push_back(0);
    segStride.push_back(0);
    segStrideStr.push_back("N/A");
    //Find the type
    size_t typeendptr = line.find("*");
    size_t gepptr = line.rfind("getelementptr", typeendptr);
    size_t inboundsptr = line.rfind("inbounds", typeendptr);
    size_t commaptr = line.rfind(",", typeendptr);
//    size_t typeptr = (gepptr > inboundsptr) ? (gepptr+14) : (inboundsptr+9);
//    typeptr = (typeptr > commaptr) ? typeptr : (commaptr+2);
//    varType = line.substr(typeptr, typeendptr-typeptr);
    size_t typeptr;
    if (commaptr == string::npos) {
        if (inboundsptr == string::npos) {
            typeptr = gepptr+14;
        } else {
            typeptr = inboundsptr+9;
        }
    } else {
        typeptr = commaptr+2;
    }
    varType = line.substr(typeptr, typeendptr-typeptr);
    //Find the variable name
    size_t varptr = line.find("@", typeendptr);
    if (varptr == string::npos)
        varptr = line.find("%", line.find("*"));
    varptr++;
    size_t varendptr = line.find(",", varptr);
    varName = line.substr(varptr, varendptr-varptr);
    indvars = indv;
    deps.push_back(dependencies::getDeps(line.substr(varendptr+2), indvars));
    predictable = true;
    stride = 0;
    totalAccesses = 1;
}

void
Variable::updVar(std::string line, string basic_block, size_t varend) {
    instruction.push_back(line);
    bbList.push_back(basic_block);
    if (bbList.back().compare(bbList.at(bbList.size()-2)) != 0) {
        bbSegPtr.push_back(bbList.size()-1);
        bbSegLen.push_back(1);
        segStride.push_back(0);
        segStrideStr.push_back("N/A");
    } else {
        bbSegLen.back()++;
    }
    deps.push_back(dependencies::getDeps(line.substr(varend+2), indvars));
    totalAccesses++;
}

void
Variable::findNESTEDIndvars(Dependency * dep, int headerPtr, ifstream * file) {
    int filePtr = file->tellg();

    file->seekg(headerPtr, file->beg);
    string line;
    while(getline(*file, line) && line.find("}") != 0) {
        size_t depPtr = line.find(dep->getName());
        if (depPtr < 5 && depPtr != string::npos) {
            break;
        }
    }
    size_t addPtr = line.find(" add ");
    if (addPtr != string::npos) {
        dep_vector * tmp = dependencies::getDeps(line.substr(addPtr+5), indvars);
        for (int i=0; i<tmp->size(); i++) {
            if (tmp->at(i)->getType()==INDUCTION ||
                tmp->at(i)->getType()==NESTED_INDUCTION) {
                dep->setType(NESTED_INDUCTION);
            }
        }
        delete tmp;
    }
    file->seekg(filePtr, file->beg);
}

void
Variable::updPredictable(int headerPtr, vector<std::string> * globals,
                         ifstream * file) {
    int i;
    int max = deps.back()->size();
    for (i=0; i<max; i++) {
        if (deps.back()->at(i)->getType()==REGISTER) {
            findNESTEDIndvars(deps.back()->at(i), headerPtr, file);
        }
    }
    i = 0;
    while(predictable && i < max) {
        dep_vector *loop_detect = new dep_vector();
        predictable &= chkPredictable(deps.back()->at(i),
            loop_detect, headerPtr, globals, file);
        i++;
    }
}



bool
Variable::chkPredictable(Dependency * dep, dep_vector* ldet, int headerPtr, vector<std::string> * globals,
                         ifstream * file) {
    if (!ldet->empty()) {
        for (int i=0; i<ldet->size(); i++) {
            if (dep->getName() == ldet->at(i)->getName()) {
                return true;
            }
        }
    }
    ldet->push_back(dep);
    bool cond = true;
    bool fulleval = false;
    if (dep->getType()==INDUCTION || dep->getType()==CONSTANT  ||
        dep->getType()==NESTED_INDUCTION) {
        cond &= true;
        fulleval = true;
    }
    if (!fulleval) {
        for (int i=0; i<globals->size(); i++) {
            if (dep->getName().substr(1).compare(globals->at(i))==0) {
                cond &= false;
                fulleval = true;
            }
        }
    }
    if (!fulleval) {
        file->seekg(headerPtr, file->beg);
        string line;
        while(getline(*file, line) && line.find("}")!=0) {
            size_t ptr = line.find(dep->getName());
            if (ptr < 5 && ptr != string::npos) {
                dep_vector * tmp;
                if (line.find(" phi ") != string::npos) {
                    tmp = dependencies::getPhiDeps(line.substr(ptr+1), indvars);
                } else if (line.find(" load ") != string::npos) {
                    tmp = dependencies::getLoadDeps(line.substr(ptr+1), indvars);
                } else if (line.find(" getelementptr ") != string::npos) {
                    tmp = dependencies::getGEPDeps(line.substr(ptr+1), indvars);
                } else {
                    tmp = dependencies::getDeps(line.substr(ptr+1), indvars);
                }
                if (tmp->size() == 0) {
                    cond &= true;
                } else {
                    for (int i=0; i<tmp->size(); i++) {
                        cond &= chkPredictable(tmp->at(i), ldet,headerPtr, globals, file);
                        if (!cond)
                            break;
                    }
                }
                delete tmp;
                break;
            }
        }
    }
    return cond;
}

void
Variable::evalSegStride(int segNum) {
    bool regIndex = false;
    int avgStride;
    if (bbSegLen.at(segNum) == 1) {
        dep_vector * tmp = deps.at(bbSegPtr.at(segNum));
        if (tmp->back()->getType() == CONSTANT) {
            if (tmp->size()==1) {
                segStride.at(segNum) = 0;
            } else {
                segStride.at(segNum) = -2;
            }
        } else {
            for (int i=0; i<tmp->size(); i++) {
                if (tmp->at(i)->getType()==REGISTER)
                    regIndex = true;
            }
            if (regIndex) {
                segStride.at(segNum) = -1;
            } else {
                segStride.at(segNum) = 1;
            }
        }
    } else {
        bool lastConstant = true;

        for (int idx=0; idx<bbSegLen.at(segNum); idx++) {
            int segidx = bbSegPtr.at(segNum)+idx;
            if (deps.at(segidx)->back()->getType() != CONSTANT) {
                lastConstant = false;
            }
            for (int depidx=0; depidx<deps.at(segidx)->size(); depidx++) {
                if (deps.at(segidx)->at(depidx)->getType() == REGISTER) {
                    regIndex = true;
                }
            }
        }

        if (regIndex) {
            segStride.at(segNum) = -1;
        } else if (!lastConstant) {
            segStride.at(segNum) = -3;
        } else {
            bool uniformIndices = true;
            bool uniformStride = true;
            int idxStride[bbSegLen.at(segNum)];

            for (int idx=1; idx<bbSegLen.at(segNum); idx++) {
                int segidx = bbSegPtr.at(segNum)+idx;
                for (int depidx=0; depidx<deps.at(segidx)->size()-1; depidx++) {
                    if (deps.at(segidx)->at(depidx)->getName().compare(
                        deps.at(segidx-1)->at(depidx)->getName()) != 0) {
                        uniformIndices = false;
                    }
                }
                stringstream stringint1;
                stringstream stringint2;
                int int1;
                int int2;

                stringint1 << deps.at(segidx)->back()->getName();
                stringint1 >> int1;
                stringint2 << deps.at(segidx-1)->back()->getName();
                stringint2 >> int2;
                idxStride[idx] = int1 - int2;
            }
            avgStride = idxStride[1];
            for (int i=2; i<bbSegLen.at(segNum); i++) {
                if (idxStride[i] != idxStride[1])
                    uniformStride = false;
                avgStride+=abs(idxStride[i]);
            }
            avgStride /= (bbSegLen.at(segNum)-1);

            if (!uniformStride) {
                if (deps.at(bbSegPtr.at(segNum))->size() == 1) {
                    segStride.at(segNum) = -4;
                } else {
                    segStride.at(segNum) = -1;
                }
            } else if (!uniformIndices) {
                segStride.at(segNum) = -1;
            } else {
                segStride.at(segNum) = avgStride;
            }
        }
    }

    //Set string for stride type
    stringstream ss;
    if (segStride.at(segNum)==-1) {
        ss << "VARIABLE: OPERATION DEPENDENCY";
    } else if (segStride.at(segNum)==-2) {
        ss << "VECTOR WIDTH";
    } else if (segStride.at(segNum)==-3) {
        ss << "VARIABLE: MULTIPLE CONTROLLING INDVARS";
    } else if (segStride.at(segNum)==-4) {
        ss << "VARIABLE: IRREGULAR CONSTANTS: AVERAGE: " << avgStride;
        segStride.at(segNum) = avgStride;
    } else {
        ss << segStride.at(segNum);
    }
    segStrideStr.at(segNum) = ss.str();
}

void
Variable::evalStride() {
    if (!predictable) {
        stride = -5;
        strideStr = "RUNTIME DEPENDENT STRIDE";
    } else {
        bool variableStride = false;
        for (int i=0; i<segStride.size(); i++) {
            evalSegStride(i);
            if (segStride.at(i) < 0) {
                stride = -1;
                strideStr = "VARIABLE";
                variableStride = true;
            } else {
                stride += segStride.at(i)*bbSegLen.at(i);
            }
        }
        if (!variableStride) {
            stride /= totalAccesses;
            stringstream ss;
            ss << stride;
            strideStr = ss.str();
        }
    }
}

std::ostream& operator<<(std::ostream& os, const Variable& var) {
    os << "\tVariable: " << var.varName << "\tType: " << var.varType << "\tStride: "
       << var.strideStr << "\n" << "\tAccesses:\n";
    int segNum = 0;
    for (int i=0; i<var.instruction.size(); i++) {
        if (i==var.bbSegPtr.at(segNum)) {
            os << "\tBasic Block: " << var.bbList.at(i);
            os << "\tNumber of accesses: " << var.bbSegLen.at(segNum);
            os << "\tSegment stride: " << var.segStrideStr.at(segNum) << "\n";
            if ((segNum+1) < var.bbSegPtr.size())
                segNum++;
        }
        os << "\t" << var.instruction[i] << "\n";
        for (int j=0; j<var.deps[i]->size(); j++) {
            os << "\t\t" << *(var.deps[i]->at(j)) << "\n";
        }
        os << "\n";
    }
    os << "\n";

    return os;
}
