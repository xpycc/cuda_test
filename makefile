all: test

fail: fail.cu
	nvcc -o fail fail.cu

test: test.o
	g++ -L/usr/local/cuda/lib64 -lcudart $^ -o $@

test.o: test.cu
	nvcc -c $^

clean:
	rm *.o test fail -f
