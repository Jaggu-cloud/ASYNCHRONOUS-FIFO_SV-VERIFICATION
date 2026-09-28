class coverage;

  mailbox     cov;
  packet      pkt;

  bit         we;
  bit         re;
  bit [3:0]   data;

  covergroup cg;
    coverpoint we;
    coverpoint re;
    coverpoint data;
    cross we, re;
  endgroup

  function new(mailbox mbx);
    cov = mbx;
    cg  = new();
  endfunction

  task run;
    forever begin
      cov.get(pkt);
      we   = pkt.wr_en;
      re   = pkt.rd_en;
      data = pkt.data_in;
      cg.sample();
    end
  endtask

endclass
