
class transaction;
  
  bit reset;
  bit transfer;
  rand bit read_write; //add constraints
  randc bit [7:0] apb_write_paddr; //add constraints
  rand bit [7:0] apb_write_data;
  randc bit [7:0] apb_read_paddr; //add constraints
  bit [7:0] apb_read_data_out;
  
  //add the constraints
  
  constraint c1{
    read_write dist{ 1'b0:=15,1'b1:=5 }; //should write more times and read less times
    apb_write_paddr inside { [0:31],[224:255] };//testing only for 64 addresses (so that both sel0 and sel1 are activated)
    
    apb_read_paddr inside { [0:31],[224:255] }; //(data should be read from a valid address where data is written)     
    apb_write_data inside { [0:127] };// limiting data range to 128 only .
    };
  
  
endclass

  
  