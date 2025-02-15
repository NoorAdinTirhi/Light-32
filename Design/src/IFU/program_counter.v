module pc_reg(
        //clock and reset
        input wire clk,
        input wire reset,
        
        //next address selection
        input wire [31:0] reg_val,

        //current address
        output wire [31:0] pc
        );

    reg [31:0] pc_mem;

    assign pc = pc_mem;


    always @(posedge clk) begin
        if (reset) begin
            pc_mem <= 0;
        end else begin
            pc_mem <= reg_val;
        end
    end

endmodule


module program_counter(
        //clock and reset
        input wire clk,
        input wire reset,

        input wire [1:0] select,

        //current address
        input wire [31:0] branch_addr,
        input wire [31:0] jump_addr,

        //next address
        output wire [31:0] next_inst_addr
    );

    //take the value from the register
    wire [31:0] pc;
    wire [31:0] next_addr;

    //for now we only have three potential next addresses
    wire [31:0] potential_next_addr[3:0];
    
    //mux
    assign potential_next_addr[0] = pc + 4;
    assign potential_next_addr[1] = branch_addr;
    assign potential_next_addr[2] = jump_addr;
    assign next_inst_addr = potential_next_addr[select];
    

    pc_reg pc_reg_inst(
        .clk(clk),
        .reset(reset),
        .reg_val(next_addr),
        .pc(pc)
        );
endmodule