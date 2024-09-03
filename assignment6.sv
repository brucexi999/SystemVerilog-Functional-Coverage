/*
Create a stimulus for 100 % coverage of signal eout (output of the Priority Encoder) for 
all the possible combinations of the pin (Input to the Priority Encoder). Prefer Wildcard bins. Share your tb code.
*/

module p_enc (
  input [4:0] pin, ////datain
  output reg [1:0] eout  ///encoded value
);

always_comb
  begin
    casez(pin)
      4'b0001: eout = 00;
      4'b001?: eout = 01;
      4'b01??: eout = 10;
      4'b1???: eout = 11;
      default: eout = 00;
    endcase
  end

endmodule

module tb;
    logic [4:0] pin;
    logic [1:0] eout;

    p_enc DUT(.*);

    covergroup CG;
        option.per_instance = 1;
        coverpoint eout {
            wildcard bins b1 = {2'b0?};
            wildcard bins b2 = {2'b1?};
        }
    endgroup

    CG cg = new();

    initial begin
        for (int i=0; i<20; i++) begin
            pin = $urandom();
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