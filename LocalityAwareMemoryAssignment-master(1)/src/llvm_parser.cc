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

#include "llvm_parser.hh"

using namespace std;

int main(int argc, char* argv[]) {
    string inputFileName;
    string filename;
    ifstream in_file;
    ofstream out_file;

    if (argc == 2) {
        inputFileName = argv[1];
    } else {
        cout << "No input file specified\n";
        return -1;
    }
    if (inputFileName.find(".ll") < 1) {
        cout << "No input file specified\n";
        return -1;
    } else {
        size_t filepathEndPtr = inputFileName.find_last_of("/")+1;
        size_t filenameEndPtr = inputFileName.find_last_of(".");
        string filepath = inputFileName.substr(0, filepathEndPtr);
        filename = inputFileName.substr(filepathEndPtr, filenameEndPtr-filepathEndPtr);
        string outputFileName = filepath + filename + ".amap";
        in_file.open(inputFileName.c_str());
        out_file.open(outputFileName.c_str());
    }

    LLVMParser parser(&in_file, &out_file);

    parser.parseFile();
    parser.outputToFile(filename);

    if (in_file.is_open())
        in_file.close();
    out_file.close();
}

void
LLVMParser::parseFile() {
    string line;
    if (in_file->is_open()) {
        while (getline(*in_file, line)) {
            if (!inFunction && !isFunctionHeader(line)) {
                if (line.find("@")==0) {
                    //Found file global
                    fileGlobals.push_back(line.substr(1, line.find(" =")-1));
                } else if (line.find("struct")==1) {
                    //Struct description found
                    structs.push_back(line);
                }
            } else if (!inFunction) {
                //Found a new function header
                currFxn = new Function(line, &fileGlobals, in_file->tellg());
                functions.push_back(currFxn);
                int tmpPtr = in_file->tellg();
                currFxn->findInductionVars(in_file);
                in_file->seekg(tmpPtr, in_file->beg);
                inFunction = true;
            } else if (isGEP(line)){
                int tmpPtr = in_file->tellg();
                currFxn->updVarList(line, in_file);
                in_file->seekg(tmpPtr, in_file->beg);
            } else if (line.find("}") == 0) {;
                currFxn->calcVarStrides();
                inFunction = false;
            } else if (line.find("; preds = ") != string::npos) {
                currFxn->addBasicBlock(line);
            }
        }
    }
}

void
LLVMParser::outputToFile(string filename) {
    if (out_file->is_open()) {
        *out_file << filename << ".amap\n";

        if (structs.size()>0) {
        *out_file << "\nStruct types:\n";
            for (int i=0; i<structs.size(); i++) {
                *out_file << structs.at(i) << "\n";
            }
        }
        if (fileGlobals.size()>0) {
            *out_file << "\nGlobal vars:\n";
            for (int i=0; i<fileGlobals.size(); i++) {
                *out_file << fileGlobals.at(i) << "\n";
            }
        }
        *out_file << "\n";
        for (int i=0; i<functions.size(); i++) {
            *out_file << *(functions[i]);
        }
    }
}
