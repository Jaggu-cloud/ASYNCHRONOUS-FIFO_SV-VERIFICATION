class generator;

  packet  pkt;
  mailbox mbx;

  function new(mailbox mbx);
    this.mbx = mbx;
  endfunction

  task run();
    repeat (30) begin
      pkt = new;
      pkt.randomize();
      mbx.put(pkt);
      // pkt.display("GEN");
    end
  endtask

endclass
