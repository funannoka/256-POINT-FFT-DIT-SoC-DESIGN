module state_machine (
clk,
reset,
bfx1_0real,
bfx1_0imag,
bfx1_1real,
bfx1_1imag,
bfx2_0real,
bfx2_0imag,
bfx2_1real,
bfx2_1imag,
bfx3_0real,
bfx3_0imag,
bfx3_1real,
bfx3_1imag,
bfx4_0real,
bfx4_0imag,
bfx4_1real,
bfx4_1imag,
ineven_index1,
inodd_index1,
ineven_index2,
inodd_index2,
ineven_index3,
inodd_index3,
ineven_index4,
inodd_index4,
buff_rd_full,
rd_in,
level,
st_fully_in,
st_fullx_in,


state,
ineven_index1_out,
inodd_index1_out,
ineven_index2_out,
inodd_index2_out,
ineven_index3_out,
inodd_index3_out,
ineven_index4_out,
inodd_index4_out,
bfx1_0real_out,
bfx1_0imag_out,
bfx1_1real_out,
bfx1_1imag_out,
bfx2_0real_out,
bfx2_0imag_out,
bfx2_1real_out,
bfx2_1imag_out,
bfx3_0real_out,
bfx3_0imag_out,
bfx3_1real_out,
bfx3_1imag_out,
bfx4_0real_out,
bfx4_0imag_out,
bfx4_1real_out,
bfx4_1imag_out,
rd_out,
st_fully_out,
st_fullx_out,
buff_rd_full_out
);

input clk;
input reset;
input [19:0]bfx1_0real;
input [19:0]bfx1_0imag;
input [19:0]bfx1_1real;
input [19:0]bfx1_1imag;
input [19:0]bfx2_0real;
input [19:0]bfx2_0imag;
input [19:0]bfx2_1real;
input [19:0]bfx2_1imag;
input [19:0]bfx3_0real;
input [19:0]bfx3_0imag;
input [19:0]bfx3_1real;
input [19:0]bfx3_1imag;
input [19:0]bfx4_0real;
input [19:0]bfx4_0imag;
input [19:0]bfx4_1real;
input [19:0]bfx4_1imag;
input [7:0] ineven_index1;
input [7:0] inodd_index1;
input [7:0] ineven_index2;
input [7:0] inodd_index2;
input [7:0] ineven_index3;
input [7:0] inodd_index3;
input [7:0] ineven_index4;
input [7:0] inodd_index4;
input buff_rd_full;
input rd_in;
input [3:0]level;
input st_fully_in;
input st_fullx_in;

output [1:0] state;

output [7:0] ineven_index1_out;
output [7:0] inodd_index1_out;
output [7:0] ineven_index2_out;
output [7:0] inodd_index2_out;
output [7:0] ineven_index3_out;
output [7:0] inodd_index3_out;
output [7:0] ineven_index4_out;
output [7:0] inodd_index4_out;
output [19:0] bfx1_0real_out;
output [19:0] bfx1_0imag_out;
output [19:0] bfx1_1real_out;
output [19:0] bfx1_1imag_out;
output [19:0] bfx2_0real_out;
output [19:0] bfx2_0imag_out;
output [19:0] bfx2_1real_out;
output [19:0] bfx2_1imag_out;
output [19:0] bfx3_0real_out;
output [19:0] bfx3_0imag_out;
output [19:0] bfx3_1real_out;
output [19:0] bfx3_1imag_out;
output [19:0] bfx4_0real_out;
output [19:0] bfx4_0imag_out;
output [19:0] bfx4_1real_out;
output [19:0] bfx4_1imag_out;

output rd_out;
output st_fully_out;
output st_fullx_out;
output buff_rd_full_out;


parameter state_init = 0;
parameter state_idle = 1;
parameter state_busy = 2;
parameter state_send = 3;
parameter stage_1 = 0;
parameter stage_2 = 1;
parameter stage_3 = 2;
parameter stage_4 = 3;
parameter stage_5 = 4;
parameter stage_6 = 5;
parameter stage_7 = 6;
parameter stage_8 = 7;
parameter stage_out = 8;

reg fully1,fully1_d;
reg	fullx1,fullx1_d;
reg wr,wr_d;
reg doneb_prev[0:1];
reg push[0:7];

wire buffy_full;
wire buffx_full;
assign buffy_full = fully1 + st_fully_in;
assign buffx_full = fullx1 + st_fullx_in;
wire buff_wr_full;
assign buff_rd_full_out = (level ==stage_8)?push[0]:(rd_in?buffy_full:buffx_full);
assign buff_wr_full = wr?buffy_full:buffx_full;

reg [19:0]buff_yreal1[0:255];
reg [19:0]buff_yimag1[0:255];
reg [19:0]buff_xreal1[0:255];
reg [19:0]buff_ximag1[0:255];
reg [7:0]outeven_indexb1,evenindex1_b;
reg [7:0]outodd_indexb1,oddindexb1_b;
reg [7:0]outeven_indexb2,evenindex2_b;
reg [7:0]outodd_indexb2,oddindexb2_b;
reg [7:0]outeven_indexb3,evenindex3_b;
reg [7:0]outodd_indexb3,oddindexb3_b;
reg [7:0]outeven_indexb4,evenindex4_b;
reg [7:0]outodd_indexb4,oddindexb4_b;
reg[7:0]num_of_series1,num_of_series1_d;
reg[7:0]which_series1,which_series1_d;
reg[7:0]outeven_index1,outeven_index1_d;
reg[7:0]outeven_index2,outeven_index2_d;
reg[7:0]outeven_index3,outeven_index3_d;
reg[7:0]outeven_index4,outeven_index4_d;
reg[7:0]outodd_index1;
reg[7:0]outodd_index2;
reg[7:0]outodd_index3;
reg[7:0]outodd_index4;
wire [7:0] outodd_index1_d;
wire [7:0] outodd_index2_d;
wire [7:0] outodd_index3_d;
wire [7:0] outodd_index4_d;
reg [1:0] machine_state,machine_state_d;
wire [19:0]tfreal1,tfreal2,tfreal3,tfreal4;
reg [19:0] wreal1,wreal1_d;
reg [19:0] wreal2,wreal2_d;
reg [19:0] wreal3,wreal3_d;
reg [19:0] wreal4,wreal4_d;
wire [19:0]tfimag1,tfimag2,tfimag3,tfimag4;
reg [19:0] wimag1,wimag1_d;
reg [19:0] wimag2,wimag2_d;
reg [19:0] wimag3,wimag3_d;
reg [19:0] wimag4,wimag4_d;
wire [19:0]oddbrealb1,brealb1;
reg [19:0]breal1_b,oddbreal1_b;
wire [19:0]oddbimagb1,bimagb1;
reg [19:0]bimag1_b,oddbimag1_b;
wire [19:0]oddbrealb2,brealb2;
reg [19:0]breal2_b,oddbreal2_b;
wire [19:0]oddbimagb2,bimagb2;
reg [19:0]bimag2_b,oddbimag2_b;
wire [19:0]oddbrealb3,brealb3;
reg [19:0]breal3_b,oddbreal3_b;
wire [19:0]oddbimagb3,bimagb3;
reg [19:0]bimag3_b,oddbimag3_b;
wire [19:0]oddbrealb4,brealb4;
reg [19:0]breal4_b,oddbreal4_b;
wire[19:0]oddbimagb4,bimagb4;
reg [19:0]bimag4_b,oddbimag4_b;
reg [19:0] x0real1,x0real1_d;
reg [19:0] x0imag1,x0imag1_d;
reg [19:0] x1real1,x1real1_d;
reg [19:0] x1imag1,x1imag1_d;
reg [19:0] x0real2,x0real2_d;
reg [19:0] x0imag2,x0imag2_d;
reg [19:0] x1real2,x1real2_d;
reg [19:0] x1imag2,x1imag2_d;
reg [19:0] x0real3,x0real3_d;
reg [19:0] x0imag3,x0imag3_d;
reg [19:0] x1real3,x1real3_d;
reg [19:0] x1imag3,x1imag3_d;
reg [19:0] x0real4,x0real4_d;
reg [19:0] x0imag4,x0imag4_d;
reg [19:0] x1real4,x1real4_d;
reg [19:0] x1imag4,x1imag4_d;
reg tfenable1,tfenable1_d;
reg tfenable2,tfenable2_d;
reg tfenable3,tfenable3_d;
reg tfenable4,tfenable4_d;
reg bfpushin1,bfpushin1_d,bfpushout1_d;
wire bfpushout1,bfpushout2,bfpushout3,bfpushout4;
wire [17:0] cntrl_out1;
wire[17:0] cntrl_in1;
wire [17:0] cntrl_out2;
wire[17:0] cntrl_in2;
wire [17:0] cntrl_out3;
wire[17:0] cntrl_in3;
wire [17:0] cntrl_out4;
wire[17:0] cntrl_in4;

reg done_reg,done_d,doneb4,doneb;
reg rd_bufb1,rd_b4,rd_bufb4,en;
reg rd1,rd1_d,rd1_prev;
reg	st_fullx,st_fullx_d;
reg st_fully,st_fully_d; 
assign st_fully_out =st_fully;
assign st_fullx_out =st_fullx;
wire [6:0] tf_index1;
wire [6:0] tf_index2;
wire [6:0] tf_index3;
wire [6:0] tf_index4;


assign ineven_index1_out = (outeven_index1 & which_series1) | ((outeven_index1 & ~which_series1) <<1);
assign inodd_index1_out = ineven_index1_out + num_of_series1; 
assign ineven_index2_out = (outeven_index2 & which_series1) | ((outeven_index2 & ~which_series1) <<1);
assign inodd_index2_out = ineven_index2_out + num_of_series1;
assign ineven_index3_out = (outeven_index3 & which_series1) | ((outeven_index3 & ~which_series1) <<1);
assign inodd_index3_out = ineven_index3_out + num_of_series1; 
assign ineven_index4_out = (outeven_index4 & which_series1) | ((outeven_index4 & ~which_series1) <<1);
assign inodd_index4_out = ineven_index4_out + num_of_series1;  
assign cntrl_in1 = {1'b0,outeven_index1,outodd_index1,1'b0};
assign cntrl_in2 = {1'b0,outeven_index2,outodd_index2,1'b0};
assign cntrl_in3 = {1'b0,outeven_index3,outodd_index3,1'b0};
assign cntrl_in4 = {rd1_prev,outeven_index4,outodd_index4,done_reg};
assign outeven_indexb1 = cntrl_out1[16:9];
assign outodd_indexb1 = cntrl_out1[8:1];
assign outeven_indexb2 = cntrl_out2[16:9];
assign outodd_indexb2 = cntrl_out2[8:1];
assign outeven_indexb3 = cntrl_out3[16:9];
assign outodd_indexb3 = cntrl_out3[8:1];
assign outeven_indexb4 = cntrl_out4[16:9];
assign outodd_indexb4 = cntrl_out4[8:1];
assign rd_bufb1 = cntrl_out4[17];
assign doneb4 = cntrl_out4[0];
assign tf_index1 = outeven_index1 & ~which_series1;  
assign tf_index2 = outeven_index2 & ~which_series1;  
assign tf_index3 = outeven_index3 & ~which_series1;  
assign tf_index4 = outeven_index4 & ~which_series1;  
assign rd_out = rd1;

assign bfx1_0real_out = rd_in?buff_yreal1[ineven_index1]:buff_xreal1[ineven_index1];
assign bfx1_0imag_out = rd_in?buff_yimag1[ineven_index1]:buff_ximag1[ineven_index1];
assign bfx1_1real_out = rd_in?buff_yreal1[inodd_index1]:buff_xreal1[inodd_index1];
assign bfx1_1imag_out = rd_in?buff_yimag1[inodd_index1]:buff_ximag1[inodd_index1];
assign bfx2_0real_out = rd_in?buff_yreal1[ineven_index2]:buff_xreal1[ineven_index2];
assign bfx2_0imag_out = rd_in?buff_yimag1[ineven_index2]:buff_ximag1[ineven_index2];
assign bfx2_1real_out = rd_in?buff_yreal1[inodd_index2]:buff_xreal1[inodd_index2];
assign bfx2_1imag_out = rd_in?buff_yimag1[inodd_index2]:buff_ximag1[inodd_index2];
assign bfx3_0real_out = rd_in?buff_yreal1[ineven_index3]:buff_xreal1[ineven_index3];
assign bfx3_0imag_out = rd_in?buff_yimag1[ineven_index3]:buff_ximag1[ineven_index3];
assign bfx3_1real_out = rd_in?buff_yreal1[inodd_index3]:buff_xreal1[inodd_index3];
assign bfx3_1imag_out = rd_in?buff_yimag1[inodd_index3]:buff_ximag1[inodd_index3];
assign bfx4_0real_out = rd_in?buff_yreal1[ineven_index4]:buff_xreal1[ineven_index4];
assign bfx4_0imag_out = rd_in?buff_yimag1[ineven_index4]:buff_ximag1[ineven_index4];
assign bfx4_1real_out = rd_in?buff_yreal1[inodd_index4]:buff_xreal1[inodd_index4];
assign bfx4_1imag_out = rd_in?buff_yimag1[inodd_index4]:buff_ximag1[inodd_index4];

always @ (*) begin
	tfenable1_d = tfenable1;
	tfenable2_d = tfenable2;
	tfenable3_d = tfenable3;
	tfenable4_d = tfenable4;
	which_series1_d = which_series1; 
	num_of_series1_d = num_of_series1;
	outeven_index1_d = outeven_index1;
	outeven_index2_d = outeven_index2;
	outeven_index3_d = outeven_index3;
	outeven_index4_d = outeven_index4;
	machine_state_d = machine_state;
	st_fullx_d = st_fullx;
	st_fully_d = st_fully; 
 	bfpushin1_d = bfpushin1;
	
	rd1_d = rd1;
	done_d = done_reg;
	 case (machine_state)
	 state_init:
	 	begin
	 	outeven_index1_d = 0;
	 	outeven_index2_d = 1;
	 	outeven_index3_d = 2;
	 	outeven_index4_d = 3;
	 	which_series1_d = {8{1'b1}} >> (level + 1); //127
	 	num_of_series1_d = 8'd128 >> level;
	 	tfenable1_d = 1;
		tfenable2_d = 1;
		tfenable3_d = 1;
		tfenable4_d = 1;
	 	bfpushin1_d = 1'b0;
	 	done_d = 1'b0;
	 	machine_state_d = state_idle;
	 	end
	 state_idle:
	 	begin
	 	tfenable1_d = 0;
		tfenable2_d = 0;
		tfenable3_d = 0;
		tfenable4_d = 0;
	 	bfpushin1_d = 0;
	 				
	 	if(buff_rd_full)
	 	begin
	 	machine_state_d = state_busy;
	 	bfpushin1_d = 1'b1;
	 	// $display("stage%d:bfly data in: real1: = %x,imag1 = %x,real2 = %x,imag2 = %x,index_even: %d,index_odd = %d",level+1,bfx1_0real,bfx1_0imag,bfx1_1real,bfx1_1imag,outeven_index1,outodd_index1);
 		//$display("stage%d:bfly data in: real1: = %x,imag1 = %x,real2 = %x,imag2 = %x,index_even: %d,index_odd = %d",level+1,bfx2_0real,bfx2_0imag,bfx2_1real,bfx2_1imag,outeven_index2,outodd_index2);
 		//$display("stage%d:bfly data in: real1: = %x,imag1 = %x,real2 = %x,imag2 = %x,index_even: %d,index_odd = %d",level+1,bfx3_0real,bfx3_0imag,bfx3_1real,bfx3_1imag,outeven_index3,outodd_index3);
 		//$display("stage%d:bfly data in: real1: = %x,imag1 = %x,real2 = %x,imag2 = %x,index_even: %d,index_odd = %d",level+1,bfx4_0real,bfx4_0imag,bfx4_1real,bfx4_1imag,outeven_index4,outodd_index4);
	 	end
	 //	else
	// 	$display("stage one: waiting for data!");
	 	end
	 state_busy:
	 	begin
	 	tfenable1_d = 1;
		tfenable2_d = 1;
		tfenable3_d = 1;
		tfenable4_d = 1;
		bfpushin1_d = 1'b0;
		if (&(outodd_index4))
	 	begin
	 	machine_state_d = state_init;
	 	//level = level + 1;
	 	if (rd1)
	 	begin
	 	st_fully_d = ~st_fully;
	// 	$display("st_fully = %d",st_fully);
	 	end
	 	else
	 	begin
	 	st_fullx_d = ~st_fullx;
	 //	$display("st_fullx = %d",st_fullx);
	 	end
	 	rd1_d = ~rd1;
	 	//$display("Done! num of series = %d",num_of_series1);
	 	end
	 	else
	 	begin
	 	outeven_index1_d = outeven_index1 + 4;
	 	outeven_index2_d = outeven_index2 + 4;
	 	outeven_index3_d = outeven_index3 + 4;
	 	outeven_index4_d = outeven_index4 + 4;
	 	machine_state_d = state_send;
	 	end
	 	end
	 state_send:
	 	begin
	 	tfenable1_d = 0;
		tfenable2_d = 0;
		tfenable3_d = 0;
		tfenable4_d = 0;
	 				
		bfpushin1_d = 1'b1;
		if (&(outodd_index4))
	 	begin
	 	done_d = 1'b1;
	 	end
	 	machine_state_d = state_busy;
 		//$display("stage%d:bfly data in: real1: = %x,imag1 = %x,real2 = %x,imag2 = %x,index_even: %d,index_odd = %d",level+1,bfx1_0real,bfx1_0imag,bfx1_1real,bfx1_1imag,outeven_index1,outodd_index1);
 		//$display("stage%d:bfly data in: real1: = %x,imag1 = %x,real2 = %x,imag2 = %x,index_even: %d,index_odd = %d",level+1,bfx2_0real,bfx2_0imag,bfx2_1real,bfx2_1imag,outeven_index2,outodd_index2);
 		//$display("stage%d:bfly data in: real1: = %x,imag1 = %x,real2 = %x,imag2 = %x,index_even: %d,index_odd = %d",level+1,bfx3_0real,bfx3_0imag,bfx3_1real,bfx3_1imag,outeven_index3,outodd_index3);
 		//$display("stage%d:bfly data in: real1: = %x,imag1 = %x,real2 = %x,imag2 = %x,index_even: %d,index_odd = %d",level+1,bfx4_0real,bfx4_0imag,bfx4_1real,bfx4_1imag,outeven_index4,outodd_index4);
	 	end
	 	default:
	 	begin
	 	machine_state_d = state_init;
	 	end
	endcase
end

always @ (posedge (clk) or posedge (reset)) begin
	if(reset) 
	begin
	 machine_state <= state_init;
	 tfenable1 <= 1'b0;
	 tfenable2 <= 1'b0;
	 tfenable3 <= 1'b0;
	 tfenable4 <= 1'b0;
	 bfpushin1 <= 1'b0;
	 rd1 <= 1'b0;
	 st_fullx <= 1'b0;
	 st_fully <= 1'b0; 
	 outeven_index1 <= 0;
	 outeven_index2 <= 0;
	 outeven_index3 <= 0;
	 outeven_index4 <= 0;
	 done_reg <= 0;
	 //level <= 0;
	 which_series1 <= {8{1'b1}} >> (level + 1); //127
	 num_of_series1 <= 8'd128 >> level;
	// $display("level =  %d, series = %d, series_num = %d",level+1,which_series1,num_of_series1);
	end
	else
	begin
	 machine_state <= #1 machine_state_d;
	 rd1 <= #1 rd1_d;
	 rd1_prev <= #1 rd1;
	 st_fullx <= #1 st_fullx_d;
	 st_fully <= #1 st_fully_d; 
	 done_reg <= #1 done_d;
	 outeven_index1 <= #1 outeven_index1_d;
	 outeven_index2 <= #1 outeven_index2_d;
	 outeven_index3 <= #1 outeven_index3_d;
	 outeven_index4 <= #1 outeven_index4_d;
   outodd_index1 <= #1 {1'b1,outeven_index1_d[6:0]};
   outodd_index2 <= #1 {1'b1,outeven_index2_d[6:0]};
   outodd_index3 <= #1 {1'b1,outeven_index3_d[6:0]};
   outodd_index4 <= #1 {1'b1,outeven_index4_d[6:0]};
	 which_series1 <= #1 which_series1_d; 
	 num_of_series1 <= #1 num_of_series1_d;
	 tfenable1 <= #1 tfenable1_d;
	 tfenable2 <= #1 tfenable2_d;
	 tfenable3 <= #1 tfenable3_d;
	 tfenable4 <= #1 tfenable4_d;
	 bfpushin1 <= #1 bfpushin1_d;
	end
end



always @ (*) begin
	en = 1'b0;
	fully1_d = fully1;
	fullx1_d = fullx1;
	wr_d =  wr;
	//if (bfpushout4)
	//begin
	breal1_b = brealb1;
	bimag1_b = bimagb1;
	oddbreal1_b = oddbrealb1;
	oddbimag1_b = oddbimagb1;
	evenindex1_b = outeven_indexb1;
	oddindexb1_b = outodd_indexb1;

	breal2_b = brealb2;
	bimag2_b = bimagb2;
	oddbreal2_b = oddbrealb2;
	oddbimag2_b = oddbimagb2;
	evenindex2_b = outeven_indexb2;
	oddindexb2_b = outodd_indexb2;

	breal3_b = brealb3;
	bimag3_b = bimagb3;
	oddbreal3_b = oddbrealb3;
	oddbimag3_b = oddbimagb3;
	evenindex3_b = outeven_indexb3;
	oddindexb3_b = outodd_indexb3;

	breal4_b = brealb4;
	bimag4_b = bimagb4;
	oddbreal4_b = oddbrealb4;
	oddbimag4_b = oddbimagb4;
	evenindex4_b = outeven_indexb4;
	oddindexb4_b = outodd_indexb4;
	doneb = doneb4;	
	bfpushout1_d = bfpushout4;
	if (~buff_wr_full & bfpushout4)
	begin
	if(doneb4)
	begin
	wr_d =  ~wr;
	if(wr)
	fully1_d = ~fully1;
	else
	fullx1_d = ~fullx1;
	end
	 en = 1'b1;
	end
end

always @ (posedge (clk) or posedge(reset)) begin
	if(reset)
	begin
	 push[0] <= 0;
	 doneb_prev[0] <= 0;
	 //rd_p1[0]  <= 0;
	 fully1 <= 0;
	 fullx1 <= 0;
	 wr <= 0;
	end
	else
	begin
	wr <= #1 wr_d;
	push[0] <= #1 bfpushout1_d;
	push[1] <= #1 push[0];
	push[2] <= #1 push[1];
	push[3] <= #1 push[2];
	push[4] <= #1 push[3];
	doneb_prev[0] <= #1 doneb;
	fully1 <= #1 fully1_d;
	fullx1 <= #1 fullx1_d;
 	if(en)
	begin
	 	if(wr)
	 	begin
	 		buff_yreal1[evenindex1_b]<= #1 breal1_b;
	 		buff_yimag1[evenindex1_b]<= #1 bimag1_b;
	 		buff_yreal1[oddindexb1_b] <= #1 oddbreal1_b;
	 		buff_yimag1[oddindexb1_b] <= #1 oddbimag1_b;
	 		
	 		buff_yreal1[evenindex2_b]<= #1 breal2_b;
	 		buff_yimag1[evenindex2_b]<= #1 bimag2_b;
	 		buff_yreal1[oddindexb2_b] <= #1 oddbreal2_b;
	 		buff_yimag1[oddindexb2_b] <= #1 oddbimag2_b;
	 		
	 		buff_yreal1[evenindex3_b]<= #1 breal3_b;
	 		buff_yimag1[evenindex3_b]<= #1 bimag3_b;
	 		buff_yreal1[oddindexb3_b] <= #1 oddbreal3_b;
	 		buff_yimag1[oddindexb3_b] <= #1 oddbimag3_b;
	 		
	 		buff_yreal1[evenindex4_b]<= #1 breal4_b;
	 		buff_yimag1[evenindex4_b]<= #1 bimag4_b;
	 		buff_yreal1[oddindexb4_b] <= #1 oddbreal4_b;
	 		buff_yimag1[oddindexb4_b] <= #1 oddbimag4_b;
	 		//$display("collecting ybf data stage %d,breal = %h,bimag = %h, out_index_b = %d",level+1,breal1_b,bimag1_b,evenindex1_b);
	 	 	//$display("collecting ybf data stage %d,oddbreal1 = %h,oddbimag = %h,out_index_b = %d",level+1,oddbreal1_b,oddbimag1_b,oddindexb1_b);
	 	 	//$display("collecting ybf data stage %d,breal = %h,bimag = %h, out_index_b = %d",level+1,breal2_b,bimag2_b,evenindex2_b);
	 	 	//$display("collecting ybf data stage %d,oddbreal1 = %h,oddbimag = %h,out_index_b = %d",level+1,oddbreal2_b,oddbimag2_b,oddindexb2_b);
	 	 	//$display("collecting ybf data stage %d,breal = %h,bimag = %h, out_index_b = %d",level+1,breal3_b,bimag3_b,evenindex3_b);
	 	 	//$display("collecting ybf data stage %d,oddbreal1 = %h,oddbimag = %h,out_index_b = %d",level+1,oddbreal3_b,oddbimag3_b,oddindexb3_b);
	 	 	//$display("collecting ybf data stage %d,breal = %h,bimag = %h, out_index_b = %d",level+1,breal4_b,bimag4_b,evenindex4_b);
	 	 	//$display("collecting ybf data stage %d,oddbreal1 = %h,oddbimag = %h,out_index_b = %d",level+1,oddbreal4_b,oddbimag4_b,oddindexb4_b);
	 	end
	 	else
	 	begin
	 		buff_xreal1[evenindex1_b]<= #1 breal1_b;
	 		buff_ximag1[evenindex1_b]<= #1 bimag1_b;
	 		buff_xreal1[oddindexb1_b] <= #1 oddbreal1_b;
	 		buff_ximag1[oddindexb1_b] <= #1 oddbimag1_b;
	 		
	 		buff_xreal1[evenindex2_b]<= #1 breal2_b;
	 		buff_ximag1[evenindex2_b]<= #1 bimag2_b;
	 		buff_xreal1[oddindexb2_b] <= #1 oddbreal2_b;
	 		buff_ximag1[oddindexb2_b] <= #1 oddbimag2_b;
	 		
	 		buff_xreal1[evenindex3_b]<= #1 breal3_b;
	 		buff_ximag1[evenindex3_b]<= #1 bimag3_b;
	 		buff_xreal1[oddindexb3_b] <= #1 oddbreal3_b;
	 		buff_ximag1[oddindexb3_b] <= #1 oddbimag3_b;
	 		
	 		buff_xreal1[evenindex4_b]<= #1 breal4_b;
	 		buff_ximag1[evenindex4_b]<= #1 bimag4_b;
	 		buff_xreal1[oddindexb4_b] <= #1 oddbreal4_b;
	 		buff_ximag1[oddindexb4_b] <= #1 oddbimag4_b;
	 	//	$display("collecting xbf data stage %d,breal = %h,bimag = %h, out_index_b = %d",level+1,breal1_b,bimag1_b,evenindex1_b);
	 	// 	$display("collecting xbf data stage %d,oddbreal1 = %h,oddbimag = %h,out_index_b = %d",level+1,oddbreal1_b,oddbimag1_b,oddindexb1_b);
	 	 //	$display("collecting xbf data stage %d,breal = %h,bimag = %h, out_index_b = %d",level+1,breal2_b,bimag2_b,evenindex2_b);
	 	 //	$display("collecting xbf data stage %d,oddbreal1 = %h,oddbimag = %h,out_index_b = %d",level+1,oddbreal2_b,oddbimag2_b,oddindexb2_b);
	 	 //	$display("collecting xbf data stage %d,breal = %h,bimag = %h, out_index_b = %d",level+1,breal3_b,bimag3_b,evenindex3_b);
	 	 //	$display("collecting xbf data stage %d,oddbreal1 = %h,oddbimag = %h,out_index_b = %d",level+1,oddbreal3_b,oddbimag3_b,oddindexb3_b);
	 	 //	$display("collecting xbf data stage %d,breal = %h,bimag = %h, out_index_b = %d",level+1,breal4_b,bimag4_b,evenindex4_b);
	 	 //	$display("collecting xbf data stage %d,oddbreal1 = %h,oddbimag = %h,out_index_b = %d",level+1,oddbreal4_b,oddbimag4_b,oddindexb4_b);
	 	end
	end	  	
 end
end


butterfly bfly1(
clk,
reset,
bfpushin1,
tfreal1,
tfimag1,
bfx1_0real,
bfx1_0imag,
bfx1_1real,
bfx1_1imag,
cntrl_in1,
bfpushout1,
brealb1,
bimagb1,
oddbrealb1,
oddbimagb1,
level,
cntrl_out1
);

butterfly bfly2(
clk,
reset,
bfpushin1,
tfreal2,
tfimag2,
bfx2_0real,
bfx2_0imag,
bfx2_1real,
bfx2_1imag,
cntrl_in2,
bfpushout2,
brealb2,
bimagb2,
oddbrealb2,
oddbimagb2,
level,
cntrl_out2
);


butterfly bfly3(
clk,
reset,
bfpushin1,
tfreal3,
tfimag3,
bfx3_0real,
bfx3_0imag,
bfx3_1real,
bfx3_1imag,
cntrl_in3,
bfpushout3,
brealb3,
bimagb3,
oddbrealb3,
oddbimagb3,
level,
cntrl_out3
);



butterfly bfly4(
clk,
reset,
bfpushin1,
tfreal4,
tfimag4,
bfx4_0real,
bfx4_0imag,
bfx4_1real,
bfx4_1imag,
cntrl_in4,
bfpushout4,
brealb4,
bimagb4,
oddbrealb4,
oddbimagb4,
level,
cntrl_out4
);

tf twiddlefactor1(clk,tf_index1,tfenable1,tfreal1,tfimag1);	
tf twiddlefactor2(clk,tf_index2,tfenable2,tfreal2,tfimag2);		
tf twiddlefactor3(clk,tf_index3,tfenable3,tfreal3,tfimag3);		
tf twiddlefactor4(clk,tf_index4,tfenable4,tfreal4,tfimag4);			
endmodule
