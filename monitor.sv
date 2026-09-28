class monitor;

  mailbox      mbx;
  packet       pkt;
  virtual intf vif;
  mailbox      cov;

  function new(mailbox mbx, virtual intf vif, mailbox cov);
    this.mbx = mbx;
    this.cov = cov;
    this.vif = vif;
  endfunction

  task run();
    forever begin
      @(posedge vif.wr_clk or posedge vif.rd_clk);

      pkt          = new;
      pkt.wr_en    = vif.wr_en;
      pkt.rd_en    = vif.rd_en;
      pkt.data_in  = vif.data_in;
      pkt.data_out = vif.data_out;
      pkt.full     = vif.full;
      pkt.empty    = vif.empty;

      mbx.put(pkt);
      cov.put(pkt);
      // pkt.display("MON");
    end
  endtask

endclass
