FROM gcc:9.1

RUN apt update
RUN apt install -y cmake

WORKDIR /benchmark
COPY CMakeLists.txt .
COPY cmake cmake
COPY compile.sh .
RUN chmod +x compile.sh

WORKDIR /benchmark/build
RUN ../compile.sh

CMD ["bash", "--init-file", "/benchmark/compile.sh"]
