//master RTL code
module master( 
	input pclk,preset,transfer,read_write, //signals coming from external world
	input [7:0] apb_write_paddr,apb_read_paddr, //signals comiing from the top module/external world
	input [7:0] apb_write_data,prdata,
	input pready, //signal coming from the slave (slave telling to the master im ready to be writen)
	output psel1,psel2,
	output reg  [7:0]paddr,
	output reg penable,
	output reg pwrite,
	output reg [7:0]pwdata, //internal signal of data from master
	output reg [7:0]apb_read_data_out //the data read from the slave to outside world/TOP
);


parameter idle=2'b00, setup=2'b01, enable=2'b10;
reg [1:0] present_state,next_state;

always@(posedge pclk) 
begin
	if(preset) 
		present_state=idle;
	else
		present_state=next_state;
end

//definig the functionality of each state

always@(*) 
begin
	if(preset)
		next_state=idle;
	else
	begin
		pwrite=~read_write;

		case(present_state)

			idle:begin
				penable=0;

				if(!transfer)
					next_state=idle;
				else
					next_state=setup;
			end

			setup:begin
				penable=0;

				if(!read_write)
				begin
					paddr=apb_write_paddr;
					pwdata=apb_write_data;
				end

				else
				begin
					paddr=apb_read_paddr;
				end

				if(!transfer)
					next_state=idle;
				else
					next_state=enable;
			end


			enable:begin
				if(psel1||psel2)
					penable=1;

				if(transfer)
				begin
					if(pready)
					begin
						if(!read_write)
							next_state=setup;
						else 
						begin
							//next_state=setup;
							apb_read_data_out=prdata;
							next_state=setup;
						end
					end

					else
					begin
						next_state=enable;
					end
				end

				if(!transfer)
				begin
					next_state=idle;
				end
			end

			default:
				next_state=idle;
		endcase
	end
end

assign {psel1,psel2}=((present_state!=idle)?(paddr[7]?{1'b1,1'b0}:{1'b0,1'b1}):2'b00);

endmodule








