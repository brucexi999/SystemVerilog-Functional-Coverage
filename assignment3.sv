// Create four explicit bins for a,b and y and implicit bins for cout. Generate stimulus to cover all the generated bins (100 % Coverage)

//Design Code:
module top(
  input [7:0] a,b,
  output [7:0] sum,
  output cout

);
assign {cout,sum} = a + b;
endmodule

module tb;
    logic [7:0] a, b, sum;
    logic cout;

    top DUT (.*);

    covergroup CG;
        option.per_instance = 1;
        coverpoint a {
            bins bin_a[4] = {[0:255]};
        }
        coverpoint b {
            bins bin_a[4] = {[0:255]};
        }
        coverpoint sum {
            bins bin_sum[4] = {[0:255]};
        }
        coverpoint cout;
    endgroup

    CG cg = new();

    initial begin
        for (i = 0; i <5000; i++) begin
            a = $urandom();
            b = $urandom();
            cg.sample();
            #1;
        end
    end

    initial begin
        $dumpfile("dump.vcd"); 
        $dumpvars;
        #50000;
        $finish();
    end

endmodule