# Google Benchmark for C++2a

## Build

```bash
docker build -t cubix/benchmark_cpp2a .
```

## Usage

Provide a directory with your test files (see example in `bench` dir). Then mount it to `/benchmark/bench`.

```bash
docker run --rm -it --mount type=bind,source=$(pwd)/bench,target=/benchmark/bench cubix/benchmark_cpp2a
make test  # inside the container
```

### References
- https://github.com/vincent-picaud/Blog_CMake_GoogleBenchmark