module clock_divider_25 (clk, clk_div_25);
  parameter n = 25;
  input clk;
  output clk_div_25;

  reg [n-1:0] num;
  wire [n-1:0] next_num;

  always @(posedge clk) begin
    num = next_num;
  end

  assign next_num = num + 1;
  assign clk_div_25 = num[n-1];

endmodule
