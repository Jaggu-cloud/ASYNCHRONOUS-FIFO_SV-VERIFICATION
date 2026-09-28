class environment;

  agent        agt;
  scoreboard   sb;
  mailbox      m2sb, cov;
  coverage     c;
  virtual intf vif;

  function new(virtual intf vif);
    this.vif  = vif;
    this.m2sb = new();
    cov       = new();
    c         = new(cov);
    agt       = new(m2sb, vif, cov);
    sb        = new(m2sb);
  endfunction

  task run();
    fork
      agt.run();
      sb.run();
      c.run();
    join_none
  endtask

endclass
