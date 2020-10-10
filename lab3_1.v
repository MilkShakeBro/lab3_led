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

module lab3_1(clk, rst, en, dir, led);
  input clk;
  input rst;
  input en;
  input dir;
  output [15:0] led;
  reg [15:0] out;
  reg [15:0] next_led;
  reg [15:0] x;
  wire [24:0] clk_div_25;

  // initialize
  clock_divider_25 new (.clk(clk),.clk_div_25( clk_div_25));

  // sequential circuit : DFF
  always @(posedge clk_div_25) begin
    if (rst == 1'b1) begin
      out = 16'b1000_0000_0000_0000;
    end else begin
      out = next_led;
    end
  end

  // combinational circuit
  always @* begin
    if (en == 1'b1) begin
      next_led = x;
    end else begin
      next_led = out;
    end
  end

  always @* begin
    if (dir == 1) begin
      if (out[15] == 1'b1) begin
        x = 16'b0000_0000_0000_0001;
      end else begin
        x = x << 1;
      end
    end else begin
      if (out[0] == 1'b1) begin
        x = 16'b1000_0000_0000_0000;
      end else begin
        x = x >> 1;
      end
    end
  end
  assign led = out;
endmodule
// hi
