TARGET = add_unittest
OBJS = add_unittest.o add.o
LINKER = nvcc --link
NVCC = nvcc
RM = rm -f
LIBFLAGS = -lgtest -lgtest_main -lpthread

all: $(TARGET)

$(TARGET): $(OBJS)
	$(LINKER) $^ -o $@ $(LIBFLAGS)

add.o: ../add.cu ../add.h
	$(NVCC) -c $<

# applies implicit rules here
add_unittest.o: add_unittest.cc ../add.h

clean:
	$(RM) $(TARGET) $(OBJS)
