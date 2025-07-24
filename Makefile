export PYTHONPATH := $(PWD)/tests:$(PYTHONPATH)

TOPLEVEL_LANG = verilog
VERILOG_SOURCES = $(PWD)/src/alu.sv
TOPLEVEL = alu
MODULE = test_alu

include $(shell cocotb-config --makefiles)/Makefile.sim
