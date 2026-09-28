module async_fifo #(
  parameter w = 4,
  parameter d = 16
)(
  input                wr_clk, rd_clk, rst, wr_en, rd_en,
  input      [w-1:0]   data_in,
  output reg [w-1:0]   data_out,
  output               full,
  output               empty
);

  reg  [w-1:0]         mem [d-1:0];
  reg  [$clog2(d):0]   wr_bin,   rd_bin;
  reg  [$clog2(d):0]   wr_gray,  rd_gray;
  reg  [$clog2(d):0]   wr_sync1, wr_sync2;
  reg  [$clog2(d):0]   rd_sync1, rd_sync2;
  wire [$clog2(d):0]   wr_bin_next;
  wire [$clog2(d):0]   rd_bin_next;
  wire [$clog2(d):0]   wr_gray_next;
  wire [$clog2(d):0]   rd_gray_next;

  // Binary to Gray
  function [$clog2(d):0] bin_gray;
    input [$clog2(d):0] bin;
    begin
      bin_gray = bin ^ (bin >> 1);
    end
  endfunction

  assign wr_bin_next  = wr_bin + (wr_en & ~full);
  assign rd_bin_next  = rd_bin + (rd_en & ~empty);
  assign wr_gray_next = bin_gray(wr_bin_next);
  assign rd_gray_next = bin_gray(rd_bin_next);
  assign full         = (wr_gray_next == {~rd_sync2[$clog2(d):$clog2(d)-1],
                                           rd_sync2[$clog2(d)-2:0]});
  assign empty        = (rd_gray == wr_sync2);

  // Write operation (active-high reset)
  always @(posedge wr_clk or posedge rst) begin
    if (rst) begin
      wr_bin  <= 0;
      wr_gray <= 0;
    end
    else begin
      if (wr_en && ~full) begin
        mem[wr_bin[$clog2(d)-1:0]] <= data_in;
        wr_bin  <= wr_bin_next;
        wr_gray <= wr_gray_next;
      end
    end
  end

  // Read operation
  always @(posedge rd_clk or posedge rst) begin
    if (rst) begin
      rd_bin  <= 0;
      rd_gray <= 0;
    end
    else begin
      if (rd_en && ~empty) begin
        data_out <= mem[rd_bin[$clog2(d)-1:0]];
        rd_bin   <= rd_bin_next;
        rd_gray  <= rd_gray_next;
      end
    end
  end

  // 2-FF synchronizer: read pointer into write clock domain
  always @(posedge wr_clk or posedge rst) begin
    if (rst) begin
      rd_sync1 <= 0;
      rd_sync2 <= 0;
    end
    else begin
      rd_sync1 <= rd_gray;
      rd_sync2 <= rd_sync1;
    end
  end

  // 2-FF synchronizer: write pointer into read clock domain
  always @(posedge rd_clk or posedge rst) begin
    if (rst) begin
      wr_sync1 <= 0;
      wr_sync2 <= 0;
    end
    else begin
      wr_sync1 <= wr_gray;
      wr_sync2 <= wr_sync1;
    end
  end

endmodule
