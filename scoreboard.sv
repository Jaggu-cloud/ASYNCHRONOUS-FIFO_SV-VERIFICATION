class scoreboard;

  mailbox   m2sb;
  packet    pkt;
  int       count;
  bit [3:0] temp[0:15];
  int       wr_ptr;
  int       rd_ptr;

  function new(mailbox m2sb);
    this.m2sb = m2sb;
  endfunction

  task run();
    forever begin
      pkt = new;
      m2sb.get(pkt);

      // Write operation
      if (pkt.wr_en && !pkt.full) begin
        temp[wr_ptr] = pkt.data_in;
        $display("[sb] Address =%0d | Data_in=%0d", wr_ptr, pkt.data_in);

        if (wr_ptr == 15)
          wr_ptr = 0;
        else
          wr_ptr = wr_ptr + 1;

        count = count + 1;
      end

      // Read operation
      if (pkt.rd_en && !pkt.empty) begin
        if (count == 0) begin
          // $display("SCOREBOARD ERROR: FIFO IS EMPTY");
          $error("SCOREBOARD ERROR: Reference FIFO is empty");
        end
        else begin
          if (pkt.data_out == temp[rd_ptr]) begin
            $display("[SB Pass] Address=%0d | extpected=%0d| Data_out=%0d ",
                     rd_ptr, temp[rd_ptr], pkt.data_out);
          end
          else begin
            $display("[SB Fail] Address=%0d | extpected=%0d| Data_out=%0d ",
                     rd_ptr, temp[rd_ptr], pkt.data_out);
          end

          if (rd_ptr == 15)
            rd_ptr = 0;
          else
            rd_ptr = rd_ptr + 1;

          count = count - 1;
        end
      end
    end
  endtask

endclass
