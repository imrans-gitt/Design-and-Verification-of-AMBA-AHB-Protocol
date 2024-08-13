`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"

class environment;
  
  transaction tr;
  virtual APB_if vif;
  generator gen;
  driver drv;
  mailbox gen2drv;
  
  function new( virtual APB_if vif );
    
    this.vif=vif;
    
  endfunction
  
  function void build();
    
    gen2drv=new();
    gen=new(gen2drv);
    drv=new(vif,gen2drv);
  endfunction
  
  
  task rst();
    vif.preset<=0;
    #10 vif.preset<=1;
    #10 vif.preset<=0;
  endtask
  
  //main task that runs all sub tasks paralelly
  
  task start();
    
    fork
      gen.create();
      drv.drive();
    join
    
  endtask
endclass

      
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
  