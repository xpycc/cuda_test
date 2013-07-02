all: test

test: test.o
	nvcc --link $^ -o $@

test.o: test.cu
	nvcc -c $^

clean:
	rm *.o test -f
