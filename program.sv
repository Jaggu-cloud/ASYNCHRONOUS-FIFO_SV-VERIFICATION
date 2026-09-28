program test(intf vif);
  environment ev;
  initial begin
    ev=new(vif);
    ev.run();
    #300;
    $stop;
  end
endprogram
