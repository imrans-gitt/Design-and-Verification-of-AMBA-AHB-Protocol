
`include "transaction.sv"

class generator;
  
  transaction tr;
  mailbox gen2drv;
  
  function new(mailbox gen2drv);
    this.gen2drv=gen2drv;
  endfunction
  
	
  task create();
    
    //tr=new();
    
    repeat(500) 
      begin
         tr=new();
        tr.randomize();
        $display( " read_write=%b apb_write_paddr=%b apb_write_data=%b apb_read_addr=%b",tr.read_write,tr.apb_write_paddr,tr.apb_write_data,tr.apb_read_paddr);
        gen2drv.put(tr);

      end
    
        
  endtask
endclass

    
      
      
  