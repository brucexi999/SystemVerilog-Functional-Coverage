/*
Generate stimulus to get 100% coverage for the following Scenarios. 
Cover all the possible combinations of a,b and c. Cover cross of a( 00, 01 ) with all the values of b, 
cross of b(11) with all the possible values of c, Cover cross of a (10), b(10), and c(10).
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
            bins bin1 = binsof(a) intersect {[0:1]};
        }

        cross b, c {
            bins bin2 = binsof(b) intersect {3};
        }

        cross a, b, c {
            bins bin3 = binsof(a) intersect {2} && binsof(b) intersect {2} && binsof(c) intersect {2};
        }

    endgroup

    CG cg = new();

    initial begin
        for (int i=0; i<500; i++) begin
            a = $urandom();
            b = $urandom();
            c = $urandom();
            #1;
            cg.sample();
        end
    end

endmodule