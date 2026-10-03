`timescale 1ns / 1ps
module FSM_1101_tb;
  reg clk = 0, rst = 1, in = 0;
  wire out;
  reg [3:0] hist = 0;       // the last 4 bits sent
  reg expected = 0;         // what out should be
  integer errors = 0;

  FSM_1101 uut (.clk(clk), .rst(rst), .in(in), .out(out));

  always #5 clk = ~clk;

  // Reference model: same timing as the design (registered output)
  always @(posedge clk)
    if (rst) begin
      hist <= 0;  expected <= 0;
    end else begin
      hist     <= {hist[2:0], in};
      expected <= ({hist[2:0], in} == 4'b1101);
    end

  // Checker: look at the output on the falling edge, when everything is stable
  always @(negedge clk)
    if (!rst && out !== expected) begin
      errors = errors + 1;
      $display("FAIL at %0t: out=%b expected=%b", $time, out, expected);
    end

  initial begin
    repeat (2) @(negedge clk);
    rst = 0;
    repeat (1000) begin
      @(negedge clk);
      in = $random;         // random bit
    end
    @(negedge clk); #1;
    if (errors == 0) $display("PASS: 1000 random bits checked");
    else             $display("FAIL: %0d mismatches", errors);
    $finish;
  end
endmodule