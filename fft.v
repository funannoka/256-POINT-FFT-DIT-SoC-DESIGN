`include "twiddlefactor.v"
`include "butterfly.v"
`include "state_machines.v"
module fft(
clk,
reset,
realin,
imagin,
startin,
realout,
imagout,
startout
);

input clk;
input reset;
input [19:0] realin;//xnreal
input [19:0] imagin;//xnimag
input startin;
output [19:0] realout;//Xnreal;
output [19:0]imagout; //Xnimag
output startout;

reg [10:0] pushout;
reg pushout_;
reg[19:0]realout_reg;//Xnreal;
reg [19:0]imagout_reg; //Xnimag
wire [19:0]realoutw;//Xnreal;
wire [19:0]imagoutw; //Xnimag
reg[19:0]realpipe[0:12];//Xnreal;
reg[19:0]imagpipe [0:12]; //Xnimag
reg startout_reg;
reg clearbuf;

assign startout = startout_reg;
assign realout = realout_reg;
assign imagout = imagout_reg;

reg [19:0] realin_d;
reg [19:0] imagin_d;
reg [7:0] buffindex,buffindex_d;
//Input buffer
reg [19:0] xnbuff0real[255:0];
reg [19:0] xnbuff0imag[255:0];
reg [19:0] xnbuff1real[255:0];
reg [19:0] xnbuff1imag[255:0];

wire rd1,rd1_prev;
wire rd2,rd2_prev;
wire rd3,rd3_prev;
wire rd4,rd4_prev;
wire rd5,rd5_prev;
wire rd6,rd6_prev;
wire rd7,rd7_prev;
wire rd8,rd8_prev;
reg read_buff_en, write_buff_en;
reg wr,wr_d;
reg full,full_d,full1_d,full0_d;
reg full1,full0;
wire st_full1,st_full0;
wire buff1_full;
wire buff0_full;
assign buff1_full = full1 + st_full1;
assign buff0_full = full0 + st_full0;
wire buff_rd_full,buff_wr_full;
assign buff_rd_full = rd1?buff1_full:buff0_full;
assign buff_wr_full = wr?buff1_full:buff0_full;
reg st_fully_out_d,st_fully_out;
reg st_fullx_out_d,st_fullx_out;
reg [7:0] buffout_index;
reg rd_out;
reg en;
wire [1:0] level1_machine_state,level2_machine_state,
					level3_machine_state,level4_machine_state,
					level5_machine_state,level6_machine_state,
					level7_machine_state,level8_machine_state;
wire[7:0]outodd_index1,outodd_index2,outodd_index3,outodd_index4,
				 outodd_index5,outodd_index6,outodd_index7,outodd_index8;
localparam [1:0] state_init = 0;
localparam [1:0] state_idle = 1;
localparam [1:0] state_busy = 2;
localparam [1:0] state_send = 3;

//Input to Buffer
always @ (*) begin
	full1_d = full1; 
	full0_d = full0;
	wr_d =  wr;
	buffindex_d =  buffindex;
	realin_d = realin;
	imagin_d = imagin;
	en = 1'b0;
	if(~buff_wr_full & (startin |(buffindex != 0 )))
	begin
		//$display("startin = %d",startin);	
		buffindex_d =  buffindex +1;
		if(&buffindex)
		begin
		wr_d =  ~wr;
		if(wr)
		full1_d =  ~full1;
		else 
		full0_d =  ~full0;
		end
		en =1'b1;
	end
end

always @ (posedge clk or posedge reset) begin
	if(reset)
	begin
		buffindex <= 0;
		wr <= 0;
		full1 <= 0;
		full0 <= 0;
	end
	else
	begin
		if(en)
		begin
			if(wr) 
			begin
				xnbuff1real[buffindex] <= #1 realin_d;
				xnbuff1imag[buffindex] <= #1 imagin_d;
				//$display("real: %h, imag: %h,index: %d",realin_d,imagin_d,buffindex);
			end
			else
			begin
				xnbuff0real[buffindex] <= #1 realin_d;
				xnbuff0imag[buffindex] <= #1 imagin_d;
				//$display("real: %h, imag: %h,index: %d",realin_d,imagin_d,buffindex);
			end
		end
		full0 <= #1 full0_d;
		full1 <= #1 full1_d;
		wr <= #1 wr_d;
		buffindex <= #1 buffindex_d;	
	end
end


wire[7:0]ineven_index1a,ineven_index1b,ineven_index1c,ineven_index1d;
wire[7:0]ineven_index2a,ineven_index2b,ineven_index2c,ineven_index2d;
wire[7:0]ineven_index3a,ineven_index3b,ineven_index3c,ineven_index3d;
wire[7:0]ineven_index4a,ineven_index4b,ineven_index4c,ineven_index4d;
wire[7:0]ineven_index5a,ineven_index5b,ineven_index5c,ineven_index5d;
wire[7:0]ineven_index6a,ineven_index6b,ineven_index6c,ineven_index6d;
wire[7:0]ineven_index7a,ineven_index7b,ineven_index7c,ineven_index7d;
wire[7:0]ineven_index8a,ineven_index8b,ineven_index8c,ineven_index8d;
wire[7:0]inodd_index1a,inodd_index1b,inodd_index1c,inodd_index1d;
wire[7:0]inodd_index2a,inodd_index2b,inodd_index2c,inodd_index2d;
wire[7:0]inodd_index3a,inodd_index3b,inodd_index3c,inodd_index3d;
wire[7:0]inodd_index4a,inodd_index4b,inodd_index4c,inodd_index4d;
wire[7:0]inodd_index5a,inodd_index5b,inodd_index5c,inodd_index5d;
wire[7:0]inodd_index6a,inodd_index6b,inodd_index6c,inodd_index6d;
wire[7:0]inodd_index7a,inodd_index7b,inodd_index7c,inodd_index7d;
wire[7:0]inodd_index8a,inodd_index8b,inodd_index8c,inodd_index8d;

wire st_fully2,st_fully3,st_fully4,st_fully5,st_fully6,st_fully7,st_fully8;
wire st_fullx2,st_fullx3,st_fullx4,st_fullx5,st_fullx6,st_fullx7,st_fullx8;
wire fully1,fully2,fully3,fully4,fully5,fully6,fully7,fully8;
wire fullx1,fullx2,fullx3,fullx4,fullx5,fullx6,fullx7,fullx8;
wire buff_rd_full_1,buff_rd_full_2,buff_rd_full_3,buff_rd_full_4,
buff_rd_full_5,buff_rd_full_6,buff_rd_full_7,buff_rd_valid_8;

wire [19:0] bfx0real1a,bfx1real1a;
wire signed[19:0] bfx0imag1a,bfx1imag1a;
wire [19:0] bfx0real1b,bfx1real1b;
wire signed[19:0] bfx0imag1b,bfx1imag1b;
wire [19:0] bfx0real1c,bfx1real1c;
wire signed[19:0] bfx0imag1c,bfx1imag1c;
wire [19:0] bfx0real1d,bfx1real1d;
wire signed[19:0] bfx0imag1d,bfx1imag1d;
wire [19:0] bfx0real2a,bfx1real2a;
wire signed[19:0] bfx0imag2a,bfx1imag2a;
wire [19:0] bfx0real2b,bfx1real2b;
wire signed[19:0] bfx0imag2b,bfx1imag2b;
wire [19:0] bfx0real2c,bfx1real2c;
wire signed[19:0] bfx0imag2c,bfx1imag2c;
wire [19:0] bfx0real2d,bfx1real2d;
wire signed[19:0] bfx0imag2d,bfx1imag2d;
wire [19:0] bfx0real3a,bfx1real3a;
wire signed[19:0] bfx0imag3a,bfx1imag3a;
wire [19:0] bfx0real3b,bfx1real3b;
wire signed[19:0] bfx0imag3b,bfx1imag3b;
wire [19:0] bfx0real3c,bfx1real3c;
wire signed[19:0] bfx0imag3c,bfx1imag3c;
wire [19:0] bfx0real3d,bfx1real3d;
wire signed[19:0] bfx0imag3d,bfx1imag3d;
wire [19:0] bfx0real4a,bfx1real4a;
wire signed[19:0] bfx0imag4a,bfx1imag4a;
wire [19:0] bfx0real4b,bfx1real4b;
wire signed[19:0] bfx0imag4b,bfx1imag4b;
wire [19:0] bfx0real4c,bfx1real4c;
wire signed[19:0] bfx0imag4c,bfx1imag4c;
wire [19:0] bfx0real4d,bfx1real4d;
wire signed[19:0] bfx0imag4d,bfx1imag4d;
wire [19:0] bfx0real5a,bfx1real5a;
wire signed[19:0] bfx0imag5a,bfx1imag5a;
wire [19:0] bfx0real5b,bfx1real5b;
wire signed[19:0] bfx0imag5b,bfx1imag5b;
wire [19:0] bfx0real5c,bfx1real5c;
wire signed[19:0] bfx0imag5c,bfx1imag5c;
wire [19:0] bfx0real5d,bfx1real5d;
wire signed[19:0] bfx0imag5d,bfx1imag5d;
wire [19:0] bfx0real6a,bfx1real6a;
wire signed[19:0] bfx0imag6a,bfx1imag6a;
wire [19:0] bfx0real6b,bfx1real6b;
wire signed[19:0] bfx0imag6b,bfx1imag6b;
wire [19:0] bfx0real6c,bfx1real6c;
wire signed[19:0] bfx0imag6c,bfx1imag6c;
wire [19:0] bfx0real6d,bfx1real6d;
wire signed[19:0] bfx0imag6d,bfx1imag6d;
wire [19:0] bfx0real7a,bfx1real7a;
wire signed[19:0] bfx0imag7a,bfx1imag7a;
wire [19:0] bfx0real7b,bfx1real7b;
wire signed[19:0] bfx0imag7b,bfx1imag7b;
wire [19:0] bfx0real7c,bfx1real7c;
wire signed[19:0] bfx0imag7c,bfx1imag7c;
wire [19:0] bfx0real7d,bfx1real7d;
wire signed[19:0] bfx0imag7d,bfx1imag7d;
wire [19:0] bfx0real8a,bfx1real8a;
wire signed[19:0] bfx0imag8a,bfx1imag8a;
wire [19:0] bfx0real8b,bfx1real8b;
wire signed[19:0] bfx0imag8b,bfx1imag8b;
wire [19:0] bfx0real8c,bfx1real8c;
wire signed[19:0] bfx0imag8c,bfx1imag8c;
wire [19:0] bfx0real8d,bfx1real8d;
wire signed[19:0] bfx0imag8d,bfx1imag8d;

assign bfx0real1a = rd1?xnbuff1real[ineven_index1a]:xnbuff0real[ineven_index1a];
assign bfx0imag1a = rd1?xnbuff1imag[ineven_index1a]:xnbuff0imag[ineven_index1a];
assign bfx1real1a = rd1?xnbuff1real[inodd_index1a]:xnbuff0real[inodd_index1a];
assign bfx1imag1a = rd1?xnbuff1imag[inodd_index1a]:xnbuff0imag[inodd_index1a];

assign bfx0real1b = rd1?xnbuff1real[ineven_index1b]:xnbuff0real[ineven_index1b];
assign bfx0imag1b = rd1?xnbuff1imag[ineven_index1b]:xnbuff0imag[ineven_index1b];
assign bfx1real1b = rd1?xnbuff1real[inodd_index1b]:xnbuff0real[inodd_index1b];
assign bfx1imag1b = rd1?xnbuff1imag[inodd_index1b]:xnbuff0imag[inodd_index1b];

assign bfx0real1c = rd1?xnbuff1real[ineven_index1c]:xnbuff0real[ineven_index1c];
assign bfx0imag1c = rd1?xnbuff1imag[ineven_index1c]:xnbuff0imag[ineven_index1c];
assign bfx1real1c = rd1?xnbuff1real[inodd_index1c]:xnbuff0real[inodd_index1c];
assign bfx1imag1c = rd1?xnbuff1imag[inodd_index1c]:xnbuff0imag[inodd_index1c];

assign bfx0real1d = rd1?xnbuff1real[ineven_index1d]:xnbuff0real[ineven_index1d];
assign bfx0imag1d = rd1?xnbuff1imag[ineven_index1d]:xnbuff0imag[ineven_index1d];
assign bfx1real1d = rd1?xnbuff1real[inodd_index1d]:xnbuff0real[inodd_index1d];
assign bfx1imag1d = rd1?xnbuff1imag[inodd_index1d]:xnbuff0imag[inodd_index1d];




//**************************************************************//
/* working state machines*/
/*Two working concurrently at a time, starts when the buffer from 
previous level is full*/
localparam [3:0] level1 = 0;
localparam [3:0] level2 = 1;
localparam [3:0] level3 = 2;
localparam [3:0] level4 = 3;
localparam [3:0] level5 = 4;
localparam [3:0] level6 = 5;
localparam [3:0] level7 = 6;
localparam [3:0] level8 = 7;
localparam [3:0] level_out = 8;

state_machine stage1(
clk,
reset,
bfx0real1a,
bfx0imag1a,
bfx1real1a,
bfx1imag1a,
bfx0real1b,
bfx0imag1b,
bfx1real1b,
bfx1imag1b,
bfx0real1c,
bfx0imag1c,
bfx1real1c,
bfx1imag1c,
bfx0real1d,
bfx0imag1d,
bfx1real1d,
bfx1imag1d,
ineven_index2a,
inodd_index2a,
ineven_index2b,
inodd_index2b,
ineven_index2c,
inodd_index2c,
ineven_index2d,
inodd_index2d,
buff_rd_full,
rd2,
level1,
st_fully2,
st_fullx2,

level1_machine_state,
ineven_index1a,
inodd_index1a,
ineven_index1b,
inodd_index1b,
ineven_index1c,
inodd_index1c,
ineven_index1d,
inodd_index1d,
bfx0real2a,
bfx0imag2a,
bfx1real2a,
bfx1imag2a,
bfx0real2b,
bfx0imag2b,
bfx1real2b,
bfx1imag2b,
bfx0real2c,
bfx0imag2c,
bfx1real2c,
bfx1imag2c,
bfx0real2d,
bfx0imag2d,
bfx1real2d,
bfx1imag2d,
rd1,
st_full1,
st_full0,
buff_rd_full_1
);


state_machine stage2(
clk,
reset,
bfx0real2a,
bfx0imag2a,
bfx1real2a,
bfx1imag2a,
bfx0real2b,
bfx0imag2b,
bfx1real2b,
bfx1imag2b,
bfx0real2c,
bfx0imag2c,
bfx1real2c,
bfx1imag2c,
bfx0real2d,
bfx0imag2d,
bfx1real2d,
bfx1imag2d,
ineven_index3a,
inodd_index3a,
ineven_index3b,
inodd_index3b,
ineven_index3c,
inodd_index3c,
ineven_index3d,
inodd_index3d,
buff_rd_full_1,
rd3,
level2,
st_fully3,
st_fullx3,

level2_machine_state,
ineven_index2a,
inodd_index2a,
ineven_index2b,
inodd_index2b,
ineven_index2c,
inodd_index2c,
ineven_index2d,
inodd_index2d,
bfx0real3a,
bfx0imag3a,
bfx1real3a,
bfx1imag3a,
bfx0real3b,
bfx0imag3b,
bfx1real3b,
bfx1imag3b,
bfx0real3c,
bfx0imag3c,
bfx1real3c,
bfx1imag3c,
bfx0real3d,
bfx0imag3d,
bfx1real3d,
bfx1imag3d,
rd2,
st_fully2,
st_fullx2,
buff_rd_full_2
);


state_machine stage3(
clk,
reset,
bfx0real3a,
bfx0imag3a,
bfx1real3a,
bfx1imag3a,
bfx0real3b,
bfx0imag3b,
bfx1real3b,
bfx1imag3b,
bfx0real3c,
bfx0imag3c,
bfx1real3c,
bfx1imag3c,
bfx0real3d,
bfx0imag3d,
bfx1real3d,
bfx1imag3d,
ineven_index4a,
inodd_index4a,
ineven_index4b,
inodd_index4b,
ineven_index4c,
inodd_index4c,
ineven_index4d,
inodd_index4d,
buff_rd_full_2,
rd4,
level3,
st_fully4,
st_fullx4,

level3_machine_state,
ineven_index3a,
inodd_index3a,
ineven_index3b,
inodd_index3b,
ineven_index3c,
inodd_index3c,
ineven_index3d,
inodd_index3d,
bfx0real4a,
bfx0imag4a,
bfx1real4a,
bfx1imag4a,
bfx0real4b,
bfx0imag4b,
bfx1real4b,
bfx1imag4b,
bfx0real4c,
bfx0imag4c,
bfx1real4c,
bfx1imag4c,
bfx0real4d,
bfx0imag4d,
bfx1real4d,
bfx1imag4d,
rd3,
st_fully3,
st_fullx3,
buff_rd_full_3
);


state_machine stage4(
clk,
reset,
bfx0real4a,
bfx0imag4a,
bfx1real4a,
bfx1imag4a,
bfx0real4b,
bfx0imag4b,
bfx1real4b,
bfx1imag4b,
bfx0real4c,
bfx0imag4c,
bfx1real4c,
bfx1imag4c,
bfx0real4d,
bfx0imag4d,
bfx1real4d,
bfx1imag4d,
ineven_index5a,
inodd_index5a,
ineven_index5b,
inodd_index5b,
ineven_index5c,
inodd_index5c,
ineven_index5d,
inodd_index5d,
buff_rd_full_3,
rd5,
level4,
st_fully5,
st_fullx5,

level4_machine_state,
ineven_index4a,
inodd_index4a,
ineven_index4b,
inodd_index4b,
ineven_index4c,
inodd_index4c,
ineven_index4d,
inodd_index4d,
bfx0real5a,
bfx0imag5a,
bfx1real5a,
bfx1imag5a,
bfx0real5b,
bfx0imag5b,
bfx1real5b,
bfx1imag5b,
bfx0real5c,
bfx0imag5c,
bfx1real5c,
bfx1imag5c,
bfx0real5d,
bfx0imag5d,
bfx1real5d,
bfx1imag5d,
rd4,
st_fully4,
st_fullx4,
buff_rd_full_4
);


state_machine stage5(
clk,
reset,
bfx0real5a,
bfx0imag5a,
bfx1real5a,
bfx1imag5a,
bfx0real5b,
bfx0imag5b,
bfx1real5b,
bfx1imag5b,
bfx0real5c,
bfx0imag5c,
bfx1real5c,
bfx1imag5c,
bfx0real5d,
bfx0imag5d,
bfx1real5d,
bfx1imag5d,
ineven_index6a,
inodd_index6a,
ineven_index6b,
inodd_index6b,
ineven_index6c,
inodd_index6c,
ineven_index6d,
inodd_index6d,
buff_rd_full_4,
rd6,
level5,
st_fully6,
st_fullx6,

level5_machine_state,
ineven_index5a,
inodd_index5a,
ineven_index5b,
inodd_index5b,
ineven_index5c,
inodd_index5c,
ineven_index5d,
inodd_index5d,
bfx0real6a,
bfx0imag6a,
bfx1real6a,
bfx1imag6a,
bfx0real6b,
bfx0imag6b,
bfx1real6b,
bfx1imag6b,
bfx0real6c,
bfx0imag6c,
bfx1real6c,
bfx1imag6c,
bfx0real6d,
bfx0imag6d,
bfx1real6d,
bfx1imag6d,
rd5,
st_fully5,
st_fullx5,
buff_rd_full_5
);

state_machine stage6(
clk,
reset,
bfx0real6a,
bfx0imag6a,
bfx1real6a,
bfx1imag6a,
bfx0real6b,
bfx0imag6b,
bfx1real6b,
bfx1imag6b,
bfx0real6c,
bfx0imag6c,
bfx1real6c,
bfx1imag6c,
bfx0real6d,
bfx0imag6d,
bfx1real6d,
bfx1imag6d,
ineven_index7a,
inodd_index7a,
ineven_index7b,
inodd_index7b,
ineven_index7c,
inodd_index7c,
ineven_index7d,
inodd_index7d,
buff_rd_full_5,
rd7,
level6,
st_fully7,
st_fullx7,

level6_machine_state,
ineven_index6a,
inodd_index6a,
ineven_index6b,
inodd_index6b,
ineven_index6c,
inodd_index6c,
ineven_index6d,
inodd_index6d,
bfx0real7a,
bfx0imag7a,
bfx1real7a,
bfx1imag7a,
bfx0real7b,
bfx0imag7b,
bfx1real7b,
bfx1imag7b,
bfx0real7c,
bfx0imag7c,
bfx1real7c,
bfx1imag7c,
bfx0real7d,
bfx0imag7d,
bfx1real7d,
bfx1imag7d,
rd6,
st_fully6,
st_fullx6,
buff_rd_full_6
);


state_machine stage7(
clk,
reset,
bfx0real7a,
bfx0imag7a,
bfx1real7a,
bfx1imag7a,
bfx0real7b,
bfx0imag7b,
bfx1real7b,
bfx1imag7b,
bfx0real7c,
bfx0imag7c,
bfx1real7c,
bfx1imag7c,
bfx0real7d,
bfx0imag7d,
bfx1real7d,
bfx1imag7d,
ineven_index8a,
inodd_index8a,
ineven_index8b,
inodd_index8b,
ineven_index8c,
inodd_index8c,
ineven_index8d,
inodd_index8d,
buff_rd_full_6,
rd8,
level7,
st_fully8,
st_fullx8,

level7_machine_state,
ineven_index7a,
inodd_index7a,
ineven_index7b,
inodd_index7b,
ineven_index7c,
inodd_index7c,
ineven_index7d,
inodd_index7d,
bfx0real8a,
bfx0imag8a,
bfx1real8a,
bfx1imag8a,
bfx0real8b,
bfx0imag8b,
bfx1real8b,
bfx1imag8b,
bfx0real8c,
bfx0imag8c,
bfx1real8c,
bfx1imag8c,
bfx0real8d,
bfx0imag8d,
bfx1real8d,
bfx1imag8d,
rd7,
st_fully7,
st_fullx7,
buff_rd_full_7
);

state_machine stage8(
clk,
reset,
bfx0real8a,
bfx0imag8a,
bfx1real8a,
bfx1imag8a,
bfx0real8b,
bfx0imag8b,
bfx1real8b,
bfx1imag8b,
bfx0real8c,
bfx0imag8c,
bfx1real8c,
bfx1imag8c,
bfx0real8d,
bfx0imag8d,
bfx1real8d,
bfx1imag8d,
buffout_index,
,
,
,
,
,
,
,
buff_rd_full_7,
rd_out,
level8,
st_fully_out,
st_fullx_out,

level8_machine_state,
ineven_index8a,
inodd_index8a,
ineven_index8b,
inodd_index8b,
ineven_index8c,
inodd_index8c,
ineven_index8d,
inodd_index8d,
realoutw,
imagoutw,
,
,
,
,
,
,
,
,
,
,
,
,
,
,
rd8,
st_fully8,
st_fullx8,
buff_rd_valid_8
);





/******************* Final Ouput *************************/
//reg [7:0] buffout_index;
reg rd_out_d;
reg [19:0] realout_reg_d;
reg [19:0] imagout_reg_d;
reg [7:0] buffout_index_d;
reg startout_reg_d;


always @ (*) begin
	rd_out_d =  rd_out;
	st_fully_out_d = st_fully_out;
  st_fullx_out_d = st_fullx_out;

	buffout_index_d = buffout_index;
	startout_reg_d = 0;
	if(buff_rd_valid_8)
	begin
		if(buffout_index == 0)startout_reg_d = 1;
		buffout_index_d =  buffout_index + 1;
		realout_reg_d =  realoutw;
		imagout_reg_d = imagoutw;
	end
	else
	if(buffout_index > 0)
	begin
		buffout_index_d =  buffout_index + 1;
		realout_reg_d =  realoutw;
		imagout_reg_d = imagoutw;
	end
	else
	begin
		realout_reg_d =  0;
		imagout_reg_d = 0;
	end
	if(&buffout_index)
	begin
		if (rd_out)
		begin
	 		st_fully_out_d = ~st_fully_out;
	 	end
	 	else
	 	begin
	 		st_fullx_out_d = ~st_fullx_out;
	 	end
		rd_out_d =  ~rd_out;
	end
end

always @(*) begin
	startout_reg = pushout[0]; 
	realout_reg = realpipe[0];//
	imagout_reg = imagpipe[0];
end

always @ (posedge (clk) or posedge (reset)) begin
if(reset)
	begin
		pushout[0] <= 0;
		rd_out <= 0;
		realpipe[0] <= 0;
		imagpipe[0] <= 0;
		buffout_index <= 0;
		st_fully_out <= 0;
    st_fullx_out <= 0;
	end
	else
	begin
	st_fully_out <= #1 st_fully_out_d;
  st_fullx_out <= #1 st_fullx_out_d;
		buffout_index <= #1 buffout_index_d;
		rd_out <= #1 rd_out_d;
		pushout[0] <= #1 startout_reg_d;
		realpipe[0] <= #1 realout_reg_d;
		imagpipe[0] <= #1 imagout_reg_d;
		pushout[1] <= #1 pushout[0];
		realpipe[1] <= #1 realpipe[0];
		imagpipe[1] <= #1 imagpipe[0];
		pushout[2] <= #1 pushout[1];
		realpipe[2] <= #1 realpipe[1];
		imagpipe[2] <= #1 imagpipe[1];
		pushout[3] <= #1 pushout[2];
		realpipe[3] <= #1 realpipe[2];
		imagpipe[3] <= #1 imagpipe[2];
		pushout[4] <= #1 pushout[3];
		realpipe[4] <= #1 realpipe[3];
		imagpipe[4] <= #1 imagpipe[3];
		pushout[5] <= #1 pushout[4];
		realpipe[5] <= #1 realpipe[4];
		imagpipe[5] <= #1 imagpipe[4];
		pushout[6] <= #1 pushout[5];
		realpipe[6] <= #1 realpipe[5];
		imagpipe[6] <= #1 imagpipe[5];
		pushout[7] <= #1 pushout[6];
		realpipe[7] <= #1 realpipe[6];
		imagpipe[7] <= #1 imagpipe[6];
		pushout[8] <= #1 pushout[7];
		realpipe[8] <= #1 realpipe[7];
		imagpipe[8] <= #1 imagpipe[7];
		pushout[9] <= #1 pushout[8];
		realpipe[9] <= #1 realpipe[8];
		imagpipe[9] <= #1 imagpipe[8];
		pushout[10] <= #1 pushout[9];
		realpipe[10] <= #1 realpipe[9];
		imagpipe[10] <= #1 imagpipe[9];
	
	end
end
	
//initial begin
//$monitor("startout_reg = %b",startout_reg);
//end

initial begin
  for(int i=0; i<11; i++) begin
    pushout[i] = 0;
    realpipe[i] = 0;
    imagpipe[i] = 0;
  end
end
endmodule : fft
