CC :=clang++

SRCDIR := src
BINDIR := bin
TARGET := bin/dht
INCDIR := include

SRCEXT := cpp
SOURCES := $(shell find $(SRCDIR) -type f -name *.$(SRCEXT))
OBJECTS := $(patsubst $(SRCDIR)/%, $(BINDIR)/%, $(SOURCES:.$(SRCEXT)=.o))
FLAGS := -std=c++11 -Wall -g
INC := -I $(INCDIR)

.PHONY: debug clean all

all: $(TARGET)

debug:
	@echo $(CC)
	@echo $(FLAGS)
	@echo $(INC)
	@echo $(SOURCES)
	@echo $(OBJECTS)

clean:
	@echo "Cleaning binaries..."
	@rm -rf $(BINDIR)
	@echo "...done"

# $^ all dependencies
$(TARGET): $(OBJECTS)
	@echo "Linking object files..."
	@echo "$(CC) $^ -o $(TARGET)"
	$(CC) $^ -o $(TARGET)
	@echo "...done"

# $@ target
# $< first dependency
$(BINDIR)/%.o: $(SRCDIR)/%.$(SRCEXT)
	@echo "Compiling $@..."
	@echo "$(CC) $(FLAGS) $(INC) -c -o $@ $<"
	@mkdir -p $(BINDIR)
	$(CC) $(FLAGS) $(INC) -c -o $@ $<
	@echo "...done"
