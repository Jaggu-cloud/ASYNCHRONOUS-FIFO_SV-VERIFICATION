interface intf (
  input logic wr_clk,
  input logic rd_clk
);

  logic       rst;
  logic       wr_en;
  logic       rd_en;
  logic [3:0] data_in;
  logic [3:0] data_out;
  logic       full;
  logic       empty;

endinterface
