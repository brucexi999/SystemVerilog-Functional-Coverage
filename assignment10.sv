/*
Generate stimulus to get 100% coverage for the following Scenarios : Cover all the possible combinations of a,b,c, 
Cover cross between a and even values of b, Cover cross between a and odd values of c, 
Cover cross between even values of b and odd values of c.
*/

module top(
  input [1:0] a,b,c,
  output reg [3:0] y
);
 /*
 User Logic here
 Do not add anything
 ...................
 ..................
 ..................
 ...............
 */
endmodule

module tb;
    logic [1:0] a, b, c;
    logic [3:0] y;

    top DUT (.*);

    covergroup CG;
        option.per_instance = 1;
        coverpoint a;
        coverpoint b;
        coverpoint c;

        cross a, b {
            bins bin1 = binsof(b) intersect {0, 2};
        }

        cross a, c {
            bins bin2 = binsof(c) intersect {1, 3};
        }

        cross b, c {
            bins bin3 = binsof(b) intersect {0, 2} && binsof(c) intersect {1, 3};
        }

    endgroup

    CG cg = new();

    initial begin
        for (int i=0; i <1000; i++) begin
            a = $urandom();
            b = $urandom();
            c = $urandom();
            #1;
            cg.sample();
        end
    end

endmodule