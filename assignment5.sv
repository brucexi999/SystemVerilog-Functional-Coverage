/*
Create a stimulus for 100 % coverage of signal y. Create two explicit bins, 
one working with all the possible values of a (00,01,10,11) when sel is high and the other working with all the possible values of b when sel is low. 
Do not Use Cross Coverage, Prefer Wildcard bins. Share your tb code.
*/

/* run.do
vsim +access+r;
run -all;
acdb save;
acdb report -db  fcover.acdb -txt -o cov.txt -verbose  
exec cat cov.txt;
exit
*/

module mux_2 (
  input [1:0] a,b,
  input sel,
  output reg [1:0] y 
);

always_comb
  begin
    if(sel) 
      y = a;
    else
      y = b;
  end
endmodule

module tb;
    logic [1:0] a, b, y;
    logic sel;
    mux_2 DUT(.*);

    covergroup CG;
        option.per_instance = 1
        coverpoint {sel, y} {
            wildcard bins bin1 = {3'b1??};
            wildcard bins bin2 = {3'b0??};
        }
    endgroup

    CG cg = new();

    initial begin
        for (int i=0; i<20; i++) begin
            a = $urandom();
            b = $urandom();
            sel = $urandom();
            #1;
            cg.sample();
        end
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars();
        #1000;
        $stop();
    end
endmodule

