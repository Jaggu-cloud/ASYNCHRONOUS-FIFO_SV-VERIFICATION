class agent;

  mailbox   m2d;
  generator gen;
  driver    drv;
  monitor   mon;

  function new(mailbox m2sb, virtual intf vif, mailbox cov);
    this.m2d = new();
    gen = new(m2d);
    drv = new(m2d, vif);
    mon = new(m2sb, vif, cov);
  endfunction

  task run();
    fork
      gen.run();
      drv.run();
      mon.run();
    join
  endtask

endclass
