module PROM(
    input wire clk,
    input wire reset,

    input wire [31:0] addr,
    output wire [31:0] data
    );

    reg [WORD_SIZE:0] mem [0:2**WORD_SIZE-1];

    always @(posedge clk ) begin
        data <= mem[addr];
    end

endmodule