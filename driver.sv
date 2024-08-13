
`include "transaction.sv"

class driver;
  
  virtual APB_if vif;
  mailbox gen2drv;
  transaction tr;
  
  function new( virtual APB_if vif , mailbox gen2drv);
    this.gen2drv=gen2drv;
    this.vif=vif;
  endfunction
  
  task drive();
    
    forever
      begin
        gen2drv.get(tr);
        //transaction packet to signals
        vif.read_write<=tr.read_write;
        vif.apb_write_paddr<=tr.apb_write_paddr;
        vif.apb_write_data<=tr.apb_write_data;
        vif.apb_read_paddr<=tr.apb_read_paddr;
        vif.transfer<=1;
	#5
	tr.apb_read_data_out<=vif.apb_read_data_out;
        
        $display("data_read=%0b", tr.apb_read_data_out);
        
      end
  endtask
endclass

    
        
        
        
    