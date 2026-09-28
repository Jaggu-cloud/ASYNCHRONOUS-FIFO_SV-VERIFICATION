class packet;

  rand bit       wr_en;
  rand bit       rd_en;
  rand bit [3:0] data_in;
       bit [3:0] data_out;
       bit       full;
       bit       empty;

  function void display(string name);
    $display("[%s] wr_en=%0d rd_en=%0d data_in=%0d data_out=%0d full=%0d empty=%0d",
             name, wr_en, rd_en, data_in, data_out, full, empty);
  endfunction

endclass
