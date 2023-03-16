class environment;
 
 generator gen;
 driver drv;
 monitor mon;
 scoreboard sco; 
  
    
  
 event nextgd; ///gen -> drv
  
 event nextgs;  /// gen -> sco
  
 //mailbox #(transaction) mbxgd; ///gen - drv
  
 //mailbox #(bit [11:0]) mbxds; /// drv - mon
    
     
 //mailbox #(bit [11:0]) mbxms;  /// mon - sco
  
 //virtual spi_if vif;
 
  
 function new();
  //mbxgd = new();
  //mbxms = new();
  //mbxds = new();
  gen = new();
  drv = new();
  mon = new();
  sco = new();
    
  //this.vif = vif;
  //drv.vif = this.vif;
 // mon.vif = this.vif;
    
  gen.sconext = nextgs;
  sco.sconext = nextgs;
    
  gen.drvnext = nextgd;
  drv.drvnext = nextgd; 
 endfunction
  
 task pre_test();
  drv.reset();
 endtask
  
 task test();
  fork
   gen.run();
   drv.run();
   mon.run();
   sco.run();
  join_any
 endtask
  
 task post_test();
  wait(gen.done.triggered);  
  $stop();
 endtask
  
 task run();
  pre_test();
  test();
  post_test();
 endtask
  
endclass
