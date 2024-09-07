/*
Create a stimulus for D-Flipflop to cover following behavior of design. Cover all the possible values of rst, din and dout. 
Prefer Posedge of Clock as event. Share your tb code.
*/
module dff (
    input clk,rst,din,
    output reg dout  
);
  always_ff@(posedge clk)
    begin
      if(rst)
        dout <= 0;
      else
        dout <= din; 
    end

endmodule

module tb;
    logic clk, rst, din, dout;

    dff DUT (.*);

    initial begin
        clk <= 0;
    end

    always #5 clk <= ~clk;

    covergroup CG @(posedge clk);
        option.per_instance = 1;
        coverpoint rst;
        coverpoint din;
        coverpoint dout;
    endgroup

    CG cg = new();

    initial begin
        for (int i=0; i<20; i++) begin
            @ (posedge clk);
            rst <= $urandom();
            din <= $urandom();
        end
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
        #1000;
        $stop();
    end

endmodule