
`include "master.v"
`include "slave1.v"
`include "slave2.v"


module Top (
	input pclk,preset,transfer,
	input read_write,
	input [7:0]apb_write_paddr,apb_read_paddr,
	input [7:0]apb_write_data,
	output [7:0]apb_read_data_out
);

wire penable,pwrite,pready,pready1,pready2,psel1,psel2;
wire [7:0]pwdata,prdata,prdata1,prdata2,paddr;

assign pready= paddr[7] ? pready1:pready2;
assign prdata= read_write ? (paddr[7] ? prdata1:prdata2):8'bx;



//module instantiations

master m1(.pclk(pclk),.preset(preset),.transfer(transfer),.read_write(read_write),.apb_write_paddr(apb_write_paddr),
	.apb_read_paddr(apb_read_paddr),.apb_write_data(apb_write_data),.apb_read_data_out(apb_read_data_out),.prdata(prdata),
	.penable(penable),.pready(pready),.pwrite(pwrite),.psel1(psel1),.psel2(psel2),.pwdata(pwdata),.paddr(paddr));

slave1 s1(.pclk(pclk),.preset(preset),.paddr(paddr),.psel(psel1),.prdata(prdata1),.pready(pready1),.penable(penable),.pwdata(pwdata),.pwrite(pwrite));


slave2 s2(.pclk(pclk),.preset(preset),.paddr(paddr),.psel(psel2),.prdata(prdata2),.pready(pready2),.penable(penable),.pwdata(pwdata)
,.pwrite(pwrite));


endmodule
