`include "async_fifo_sv.sv"
`include "interface.sv"
`include "packet.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "coverage.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "environmnent.sv"
`include "program.sv"

module tb;

  logic wr_clk;
  logic rd_clk;

  intf vif (wr_clk, rd_clk);

  async_fifo #(
    .w(4),
    .d(16)
  ) dut (
    .wr_clk   (wr_clk),
    .rd_clk   (rd_clk),
    .rst      (vif.rst),
    .wr_en    (vif.wr_en),
    .rd_en    (vif.rd_en),
    .data_in  (vif.data_in),
    .data_out (vif.data_out),
    .full     (vif.full),
    .empty    (vif.empty)
  );

  test t1 (vif);

  // Write clock
  always #5 wr_clk = ~wr_clk;

  // Read clock
  always #7 rd_clk = ~rd_clk;

  initial begin
    wr_clk = 0;
    rd_clk = 0;

    // Reset
    vif.rst     = 1;
    vif.wr_en   = 0;
    vif.rd_en   = 0;
    vif.data_in = 0;

    #20;
    vif.rst = 0;

    // #500;
    // $finish;
  end

endmodule
