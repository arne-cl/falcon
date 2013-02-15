# To allow for parallel and incremental builds (since I'm an impatient person),
# this Makefile duplicates some of the logic of setup.py, rather then just 
# shelling out to it.  Any additions to the setup.py extension should also
# be made here!

VPATH := src/falcon
CPPFLAGS := -I./src -I/usr/include/python2.7
CFLAGS := $(CPPFLAGS) -pthread -fno-strict-aliasing -fwrapv -Wall -fno-omit-frame-pointer -fPIC  -fno-gcse -fno-crossjumping -ggdb2 -std=c++0x
CXXFLAGS := $(CFLAGS) 
INCLUDES := $(find src/falcon -name '*.h') Makefile

opt : COPT = -O3
dbg : COPT = -DFALCON_DEBUG=1 -O0

opt: src/_falcon_core.so
dbg: src/_falcon_core.so

build/%.o : %.cc $(INCLUDES) mkdirs
	$(CXX) $(COPT) $(CXXFLAGS) -c $< -o $@

build/%.o : %.cpp  $(INCLUDES) mkdirs
	$(CXX) $(COPT) $(CXXFLAGS) -c $< -o $@

src/falcon/rmodule_wrap.cpp: src/falcon/rmodule.i
	swig -python -Isrc -modern -O -c++ -w312,509 -o src/falcon/rmodule_wrap.cpp src/falcon/rmodule.i

src/_falcon_core.so: build/reval.o build/rcompile.o build/rmodule_wrap.o build/util.o build/oputil.o
	 g++ -shared -o $@ $^ -lrt

clean:
	rm -rf build/
	rm -f src/*.so

mkdirs:
	mkdir -p build/