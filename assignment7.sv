/*
Create a stimulus for 2:1 mux to cover following behavior of design. Cover all the possible values of sel line, a,b and y. Prefer Sample method. Share your tb code.
*/
module mux (
  input a,b,
  input sel,
  output y
);

  assign y = (sel == 1'b1) ? b : a ;

endmodule

module tb;

    logic a, b, sel, y;

    mux DUT (.*);

    covergroup CG with function sample(input logic a, input logic b, input logic sel, input logic y);
        option.per_instance = 1;
        coverpoint a;
        coverpoint b;
        coverpoint sel;
        coverpoint y;
    endgroup

    CG cg = new();

    initial begin
        for (int i=0; i<20; i++) begin
            a = $urandom();
            b = $urandom();
            sel = $urandom();
            #1;
            cg.sample(a, b, sel, y);
        end
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
        #1000;
        $stop();
    end

endmodule