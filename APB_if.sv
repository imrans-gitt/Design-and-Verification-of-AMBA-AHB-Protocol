
//interface block

interface APB_if( input bit pclk );
  
  logic preset; 
  logic transfer;
  logic read_write;
  logic [7:0] apb_write_paddr;
  logic [7:0] apb_write_data;
  logic [7:0] apb_read_paddr;
  logic [7:0] apb_read_data_out;
  
  
  //write all the assertion for functional coverage
  
  property p1;
    @(posedge pclk) (read_write) |-> ##[0:$] ($isunknown(apb_read_data_out)); 
  endproperty
  
  a1: assert property (p1) $display("p1 failed-->invalid read attempt");
    
    else $display("p1 passed-->valid read attempt");
      
      
     property p2;
       @(posedge pclk) 
    (!read_write) |-> (!(apb_write_paddr == $past(apb_write_paddr, 1) && apb_write_paddr == $past(apb_write_paddr, 5)));
endproperty
    
    a2: assert property (p2) $display("p2 passed-->no continous writing to same loction");
      else $display("p2 failed-->continous writing done to same location ");
      
                                                   
    
  
endinterface

  