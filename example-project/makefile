# This makefile is inspired from: https://stackoverflow.com/questions/7004702/how-can-i-create-a-makefile-for-c-projects-with-src-obj-and-bin-subdirectories

# project name (generate executable with this name)
TARGET   = example

# change these to proper directories where each file should be
SRCDIR   = src
BINDIR   = bin

DOCKER_COMMAND = docker run -it --rm -v `pwd`:/external --privileged -v /dev/bus/usb:/dev/bus/usb lattice-sdk

PCF_FILE = $(SRCDIR)/example.pcf
BLIF_FILE = $(BINDIR)/$(TARGET).blif
TXT_FILE = $(BINDIR)/$(TARGET).blif

SOURCES  := $(wildcard $(SRCDIR)/*.v)
rm       = rm -f

$(BINDIR)/$(TARGET).bin: $(SOURCES)
	@ mkdir -p bin
	@ echo "Compiling..."
	@ $(DOCKER_COMMAND) yosys -q -p "synth_ice40 -blif $(BLIF_FILE)" $(SOURCES)
	@ $(DOCKER_COMMAND) arachne-pnr -p $(PCF_FILE) $(BLIF_FILE) -o $(TXT_FILE)
	@ $(DOCKER_COMMAND) icepack $(TXT_FILE) $(BINDIR)/$(TARGET).bin
	@ echo "Compilation complete!"

flash: $(BINDIR)/$(TARGET).bin
	@ $(DOCKER_COMMAND) iceprog $(BINDIR)/$(TARGET).bin