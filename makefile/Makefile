TARGET = room.exe

CC = g++
#CC = clang++

LIBS = 

CCFLAGS = -g -Wall -O0 -std=c++11
#CCFLAGS = -target x86_64-w64-mingw32 -g -Wall -O0 -std=c++11

INCLUDES = -I.

CPPSRC = $(wildcard *.cpp)
CSRC   = $(wildcard *.c)

OBJS = $(CSRC:.c=.o) $(CPPSRC:.cpp=.o)  

%.o:%.c  
	@echo $(CSRC)
	$(CC) -o $@ $(CCFLAGS) $< $(INCLUDES)  

%.o:%.cpp  
	@echo $(CPPSRC)
	$(CC) $(CCFLAGS) $(INCLUDES) -c $< -o $@	

all:$(TARGET)  

$(TARGET): $(OBJS)  
	@echo $(OBJS)
	$(CC) -o $(TARGET) $(CCFLAGS) $(OBJS) $(LIBS)

clean:  
	rm -rf $(TARGET)  
	rm -rf $(OBJS) 
