CXXFLAGS := -O3 
INCFLAGS := -I../../src/include -I/usr/local/include -L/usr/local/lib 

#CXXFLAGS := -O3 -g -std=c++11 -ffast-math -framework Accelerate
#CXXFLAGS := -O3 -g -DNDEBUG -std=c++11

UNAME := $(shell uname)
ifeq ($(UNAME), Linux)
	MEX_EXT := mexa64
	CXX     := g++
endif
ifeq ($(UNAME), Darwin)
	MEX_EXT := mexmaci64
	CXX     := clang++
endif

all: example QPBO_double_mex.$(MEX_EXT) QPBO_double_mex_debug.$(MEX_EXT) QPBO_single_mex.$(MEX_EXT) QPBO_single_mex_debug.$(MEX_EXT)

example: example.cpp
	$(CXX) -v -o $@ example.cpp 

QPBO_double_mex.$(MEX_EXT): QPBO_mex.cpp
	mex $(INCFLAGS) -DCOST_TYPE=double -largeArrayDims -v -O -g $? -output $@

QPBO_double_mex_debug.$(MEX_EXT): QPBO_mex.cpp
	mex $(INCFLAGS) -DCOST_TYPE=double -largeArrayDims -v -g $? -output $@

QPBO_single_mex.$(MEX_EXT): QPBO_mex.cpp
	mex $(INCFLAGS) -DCOST_TYPE=float -largeArrayDims -v -O -g $? -output $@

QPBO_single_mex_debug.$(MEX_EXT): QPBO_mex.cpp
	mex $(INCFLAGS) -DCOST_TYPE=float -largeArrayDims -v -g $? -output $@

clean:
	rm -rf example *.mexa64 *.mexmaci64 *.dSYM/ 
