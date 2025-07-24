import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, Timer

@cocotb.test()
async def test_basic_pc_increment(dut):
    """Test that the PC increments by 4 every clock cycle"""

    # 10 ns clock on dut.clk
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    # Reset my DUT
    dut.reset.value = 1
    dut.next_pc.value = 0  
    await RisingEdge(dut.clk)
    await RisingEdge(dut.clk)
    dut.reset.value = 0

    initial_pc = dut.pc.value.integer
    cocotb.log.info(f"Initial PC: {initial_pc}")

    #  5 clock cycles
    for i in range(5):
        await RisingEdge(dut.clk)
        current_pc = dut.pc.value.integer
        cocotb.log.info(f"PC at cycle {i+1}: {current_pc}")
        expected_pc = initial_pc + 4 * (i + 1)
        assert current_pc == expected_pc, f"PC expected {expected_pc} but got {current_pc}"
