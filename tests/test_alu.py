import cocotb
from cocotb.triggers import Timer

@cocotb.test()
async def test_add(dut):
    """Test ALU"""
    dut.a.value = 10
    dut.b.value = 20
    dut.alu_control.value = 0b000  # ADD
    await Timer(1, units="ns")
    assert dut.result.value == 30, f"ADD failed: got {dut.result.value}, expected 30"

@cocotb.test()
async def test_sub(dut):
    """Test SUB"""
    dut.a.value = 20
    dut.b.value = 5
    dut.alu_control.value = 0b001  # SUB
    await Timer(1, units="ns")
    assert dut.result.value == 15, f"SUB failed: got {dut.result.value}, expected 15"

@cocotb.test()
async def test_and(dut):
    """Test AND"""
    dut.a.value = 0b1100
    dut.b.value = 0b1010
    dut.alu_control.value = 0b010  # AND
    await Timer(1, units="ns")
    assert dut.result.value == 0b1000, f"AND failed: got {bin(dut.result.value.integer)}, expected 0b1000"

@cocotb.test()
async def test_or(dut):
    """Test OR"""
    dut.a.value = 0b1100
    dut.b.value = 0b1010
    dut.alu_control.value = 0b011  # OR
    await Timer(1, units="ns")
    assert dut.result.value == 0b1110, f"OR failed: got {bin(dut.result.value.integer)}, expected 0b1110"
