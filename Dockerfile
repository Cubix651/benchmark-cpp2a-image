FROM gcc:9.1

RUN apt update
RUN apt install -y cmake

WORKDIR /benchmark
COPY . .
WORKDIR /benchmark/build
RUN cmake -DCMAKE_BUILD_TYPE=Release /benchmark
RUN make 
