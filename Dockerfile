FROM gcc:9.1

RUN apt update
RUN apt install -y cmake

WORKDIR /benchmark
COPY CMakeLists.txt .
COPY cmake cmake
WORKDIR /benchmark/build
RUN cmake -DCMAKE_BUILD_TYPE=Release /benchmark
RUN make 

COPY bench ../bench
RUN cmake -DCMAKE_BUILD_TYPE=Release /benchmark
RUN make
