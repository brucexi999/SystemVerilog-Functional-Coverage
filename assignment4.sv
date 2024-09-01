// Create implicit bins for din, rst, state variable, and dout. Generate stimulus to cover all the generated bins (100 % Coverage)
module fsm(
 input rst, din,clk,
  output reg dout
);
  parameter s0 = 0;
  parameter s1 = 1;
  parameter s2 = 2;

  reg [1:0] state = s0, next_state = s0;
  //////////////rst state decoding
  always@(posedge clk)
    begin
      if(rst) 
        state <= s0;
      else
        state <= next_state;
    end
 //////////// next state decoder and output logic decoder

  always@(state,din)
    begin
    case(state)
     s0: begin
       dout = 0;
       if(din)
         next_state = s1;
       else
         next_state = s0;
     end
     s1: begin
       dout = 0;
       if(din)
         next_state = s2;
       else
         next_state = s1;
     end
      s2: begin
        if(din) begin
         next_state = s0;
         dout = 1;
        end
       else begin
        next_state = s0;
         dout = 0;
       end
     end
 default: begin
   next_state = s0;
   dout = 0;  
 end
 endcase 
    end
endmodule

module tb;
    logic rst, din, clk, dout;

    fsm DUT (.*);

    covergroup CG;
        option.per_instance = 1;

        coverpoint rst;
        coverpoint din;
        coverpoint dout;
        coverpoint DUT.state {
            option.auto_bin_max = 3;
        }
    endgroup

    CG cg = new();

    initial begin
        clk <= 0;
        rst <= 1;
        #10;
        rst <= 0;
    end

    always #5 clk <= ~clk;

    initial begin
        for (int i=0; i<10; i++) begin
            @(posedge clk);
            din = $urandom();
            cg.sample();
        end
    end

    initial begin
        $dumpfile("dump.vcd");
        $dumpvars;
        #600;
        $stop();
    end

endmodule