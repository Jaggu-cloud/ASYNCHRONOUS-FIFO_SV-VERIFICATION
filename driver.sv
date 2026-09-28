class driver;

  mailbox      mbx;
  packet       pkt;
  virtual intf vif;

  function new(mailbox mbx, virtual intf vif);
    this.mbx = mbx;
    this.vif = vif;
  endfunction

  task run();
    forever begin
      mbx.get(pkt);

      @(negedge vif.wr_clk);
      vif.wr_en   <= pkt.wr_en;
      vif.data_in <= pkt.data_in;

      #1;

      @(negedge vif.rd_clk);
      vif.rd_en   <= pkt.rd_en;

      // pkt.display("DRV");
    end
  endtask

endclass
