#include <stdlib.h>
#include <iostream>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vprogram_counter.h"
#include "Vprogram_counter__Dpi.h"

int main(int argc, char **argv) {
    Verilated::commandArgs(argc, argv);
    Vprogram_counter* top = new Vprogram_counter;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    top->trace(tfp, 99);
    tfp->open("program_counter.vcd");

    top->clk = 0;
    top->rst = 1;
    top->eval();
    top->rst = 0;
    top->eval();

    for (int i = 0; i < 10; i++) {
        top->clk = 0;
        top->eval();
        tfp->dump(i * 10);
        top->clk = 1;
        top->eval();
        tfp->dump(i * 10 + 5);
    }

    tfp->close();
    delete top;
    exit(0);
}