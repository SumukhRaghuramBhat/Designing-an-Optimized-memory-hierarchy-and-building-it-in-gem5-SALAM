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

#include "dependency.hh"

using namespace std;

bool
dependencies::inIndvars(string name, dep_vector * indvars) {
    for (int i=0; i<indvars->size(); i++) {
        if (name.compare(indvars->at(i)->getName())==0)
            return true;
    }
    return false;
}

dep_vector *
dependencies::getDeps(string line) {
    size_t ptr = 0;
    size_t endptr = 0;
    dep_vector * dvec = new dep_vector();
    string nm;
    while (endptr < (line.size()-1)) {
        endptr = line.find(",", ptr);
        if (endptr > ptr) {
            ptr = line.rfind(" ", endptr)+1;
            if (line[ptr]=='!') break;
        } else {
            ptr = line.rfind(" ")+1;
            endptr = line.size()-1;
            if (line[ptr]=='!') break;
        }
        nm = line.substr(ptr, endptr-ptr);
        dvec->push_back(new Dependency(nm));
        if (nm.find("indvars") == 1) {
            dvec->back()->setType(INDUCTION);
        } else if (nm.find("%") != 0) {
            dvec->back()->setType(CONSTANT);
        } else {
            dvec->back()->setType(REGISTER);
        }
        ptr = endptr+1;
    }

    return dvec;
}

dep_vector *
dependencies::getDeps(string line, dep_vector * indvars) {
    size_t ptr = 0;
    size_t endptr = 0;
    dep_vector * dvec = new dep_vector();
    string nm;
    while (endptr < (line.size()-1)) {
        endptr = line.find(",", ptr);
        if (endptr > ptr) {
            ptr = line.rfind(" ", endptr)+1;
            if (line[ptr]=='!') break;
        } else {
            ptr = line.rfind(" ")+1;
            endptr = line.size()-1;
            if (line[ptr]=='!') break;
        }
        nm = line.substr(ptr, endptr-ptr);
        dvec->push_back(new Dependency(nm));
        if (inIndvars(nm, indvars)) {
            dvec->back()->setType(INDUCTION);
        } else if (nm.find("%") != 0) {
            dvec->back()->setType(CONSTANT);
        } else {
            dvec->back()->setType(REGISTER);
        }
        ptr = endptr+1;
    }

    return dvec;
}

dep_vector *
dependencies::getLoadDeps(std::string line) {
    size_t ptr = line.find("* ")+2;
    size_t endptr;
    if (line.find(",", ptr) != string::npos) {
        endptr = line.find(",", ptr);
    } else {
        endptr = line.size()-1;
    }
    dep_vector * dvec = new dep_vector();
    string nm;
    nm = line.substr(ptr, endptr-ptr);
    dvec->push_back(new Dependency(nm));
    if (nm.find("indvars") == 1) {
        dvec->back()->setType(INDUCTION);
    } else if (nm.find("%") != 0) {
        dvec->back()->setType(CONSTANT);
    } else {
        dvec->back()->setType(REGISTER);
    }
    ptr = endptr+1;

    return dvec;
}
dep_vector *
dependencies::getLoadDeps(std::string line, dep_vector * indvars) {
    size_t ptr = line.find("* ")+2;
    size_t endptr;
    if (line.find(",", ptr) != string::npos) {
        endptr = line.find(",", ptr);
    } else {
        endptr = line.size()-1;
    }
    dep_vector * dvec = new dep_vector();
    string nm;
    nm = line.substr(ptr, endptr-ptr);
    dvec->push_back(new Dependency(nm));
    if (inIndvars(nm, indvars)) {
        dvec->back()->setType(INDUCTION);
    } else if (nm.find("%") != 0) {
        dvec->back()->setType(CONSTANT);
    } else {
        dvec->back()->setType(REGISTER);
    }
    ptr = endptr+1;

    return dvec;
}

dep_vector *
dependencies::getGEPDeps(string line) {
    size_t ptr = 0;
    size_t endptr = 0;
    dep_vector * dvec = new dep_vector();
    string nm;
    while (endptr < (line.size()-1)) {
        endptr = line.find(",", ptr);
        if (endptr > ptr) {
            ptr = line.rfind(" ", endptr)+1;
            if (line[ptr]=='!') break;
        } else {
            ptr = line.rfind(" ")+1;
            endptr = line.size()-1;
            if (line[ptr]=='!') break;
        }
        nm = line.substr(ptr, endptr-ptr);
        dvec->push_back(new Dependency(nm));
        if (nm.find("indvars") == 1) {
            dvec->back()->setType(INDUCTION);
        } else if (nm.find("%") != 0) {
            dvec->back()->setType(CONSTANT);
        } else {
            dvec->back()->setType(REGISTER);
        }
        ptr = endptr+1;
    }

    return dvec;
}

dep_vector *
dependencies::getGEPDeps(string line, dep_vector * indvars) {
    size_t ptr = line.find("* ")+2;
    size_t endptr = 0;
    dep_vector * dvec = new dep_vector();
    string nm;
    while (endptr < (line.size()-1)) {
        endptr = line.find(",", ptr);
        if (endptr > ptr) {
            ptr = line.rfind(" ", endptr)+1;
            if (line[ptr]=='!') break;
        } else {
            ptr = line.rfind(" ")+1;
            endptr = line.size()-1;
            if (line[ptr]=='!') break;
        }
        nm = line.substr(ptr, endptr-ptr);
        dvec->push_back(new Dependency(nm));
        if (inIndvars(nm, indvars)) {
            dvec->back()->setType(INDUCTION);
        } else if (nm.find("%") != 0) {
            dvec->back()->setType(CONSTANT);
        } else {
            dvec->back()->setType(REGISTER);
        }
        ptr = endptr+1;
    }

    return dvec;
}

dep_vector *
dependencies::getPhiDeps(string line) {
    size_t ptr = line.find("* ")+2;
    size_t endptr = 0;
    size_t lastDepPtr = line.rfind("[ ");
    dep_vector * dvec = new dep_vector();
    string nm;
    while (ptr < lastDepPtr) {
        ptr = line.find("[ ", ptr)+2;
        endptr = line.find(",", ptr);
        nm = line.substr(ptr, endptr-ptr);
        dvec->push_back(new Dependency(nm));
        if (nm.find("indvars") == 1) {
            dvec->back()->setType(INDUCTION);
        } else if (nm.find("%") != 0) {
            dvec->back()->setType(CONSTANT);
        } else {
            dvec->back()->setType(REGISTER);
        }
        ptr = endptr+1;
    }

    return dvec;
}

dep_vector *
dependencies::getPhiDeps(string line, dep_vector * indvars) {
    size_t ptr = 0;
    size_t endptr = 0;
    size_t lastDepPtr = line.rfind("[ ");
    dep_vector * dvec = new dep_vector();
    string nm;
    while (ptr < lastDepPtr) {
        ptr = line.find("[ ", ptr)+2;
        endptr = line.find(",", ptr);
        nm = line.substr(ptr, endptr-ptr);
        dvec->push_back(new Dependency(nm));
        if (inIndvars(nm, indvars)) {
            dvec->back()->setType(INDUCTION);
        } else if (nm.find("%") != 0) {
            dvec->back()->setType(CONSTANT);
        } else {
            dvec->back()->setType(REGISTER);
        }
        ptr = endptr+1;
    }

    return dvec;
}

std::ostream& operator<<(std::ostream& os, const Dependency& dep) {
    os << dep.name << " (";
    switch(dep.type) {
        case INDUCTION:
            os << "INDUCTION";
            break;
        case REGISTER:
            os << "REGISTER";
            break;
        case CONSTANT:
            os << "CONSTANT";
            break;
        default:
            os << "NESTED_INDUCTION";
            break;
    }
    os << ")";

    return os;
}

