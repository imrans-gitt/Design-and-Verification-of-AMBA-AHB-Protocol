`include "Test.sv"
`include  "APB_if.sv"
`include "Top.v"

module testbench;
  
  bit pclk;
  initial begin
    pclk=1'b0;
  end
  
  always #5 pclk=~pclk;
  
  APB_if pif(pclk);
  Test tb(pif);
  Top dut (.pclk(pclk),.preset(pif.preset),.transfer(pif.transfer),.read_write(pif.read_write),.apb_write_paddr(pif.apb_write_paddr),.apb_write_data(pif.apb_write_data),.apb_read_paddr(pif.apb_read_paddr),.apb_read_data_out(pif.apb_read_data_out));
  
initial 
  begin
	$dumpfile("testbench.vcd");
	$dumpvars;
  end
endmodule