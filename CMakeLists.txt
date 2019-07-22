cmake_minimum_required(VERSION 3.0)
project(Benchmarking_Demo LANGUAGES CXX)

# Location of additional cmake modules
#
set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} ${PROJECT_SOURCE_DIR}/cmake)

# Guard against in-source builds and bad build-type strings
#
include(ConfigSafeGuards)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# This include is required if you want 
# to use CTest framework for you benchmarks with add_test()
#
include(CTest) 

# If you want to self-test benchmark lib too, turn me ON
#
set(BENCHMARK_ENABLE_TESTING OFF CACHE BOOL "Enable benchmark self-testing?")

# Fix dependency download
# https://github.com/google/benchmark/issues/564
#
set(BENCHMARK_DOWNLOAD_DEPENDENCIES ON CACHE BOOL "Download dependencies?")

# Setup compiler flags, c++11 is required
#
if((CMAKE_CXX_COMPILER_ID MATCHES GNU) OR (CMAKE_CXX_COMPILER_ID MATCHES Clang))
  set(CMAKE_CXX_FLAGS         "${CMAKE_CXX_FLAGS} -std=c++11")
  set(CMAKE_CXX_FLAGS_DEBUG   "-O0 -g3")
  set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG")
endif()

include(ConfigGBench)

find_package(Threads REQUIRED)

file(GLOB_RECURSE ALL_BENCH_CPP ${PROJECT_SOURCE_DIR}/bench/*.cpp)

foreach(ONE_BENCH_CPP ${ALL_BENCH_CPP})

   get_filename_component(ONE_BENCH_EXEC ${ONE_BENCH_CPP} NAME_WE)

   # Avoid name collision
   set(TARGET_NAME Bench_${ONE_BENCH_EXEC})

   add_executable(${TARGET_NAME} ${ONE_BENCH_CPP})
   target_compile_options(${TARGET_NAME} PRIVATE -std=c++2a -fconcepts)
   set_target_properties(${TARGET_NAME} PROPERTIES OUTPUT_NAME ${ONE_BENCH_EXEC})
   target_link_libraries(${TARGET_NAME}

# If required, you can add your project library here
# ...

	 benchmark
     ${CMAKE_THREAD_LIBS_INIT})

   # If you want to run benchmarks with the "make test" command, uncomment me
   add_test(${TARGET_NAME} ${ONE_BENCH_EXEC})
endforeach()
