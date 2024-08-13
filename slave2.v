//RTl code for 2nd slave


module slave2(
	input pclk,preset, //signals from the TOP
	input pwrite,penable,psel,
	input [7:0] paddr,
	input [7:0] pwdata,
	output reg pready,
	output [7:0] prdata
);

reg [7:0] mem [0:31];
reg [7:0] paddr2;

assign prdata=mem[paddr2];


always@(*) 
begin
	if(preset) 
		pready=0;
		
	else
	begin
		if(psel&&penable)
		begin
			if(pwrite)
			begin	
				pready=1;
				mem[paddr]=pwdata;
			end
			else if(!pwrite)
			begin
				pready=1;
				paddr2=paddr;
			end
		end
		
			

		if(!penable&&psel&&pwrite) 
		begin
			pready=0;
		end

		if(!penable&&psel&&!pwrite)
		begin
			pready=0;
		end

		if(penable&&!psel&&pwrite)
		begin
			pready=0;
		end

		if(penable&&!psel&&!pwrite)
		begin
			pready=0;
		end
	end
	
	
end
endmodule