module butterfly (
clk,
reset,
pushin,
wreal,
wimag,
x1real,
x1imag,
x2real,
x2imag,
cntrl_in,
pushout,
out1real,
out1imag,
out2real,
out2imag,
level,
cntrl_out
);

input clk;
input reset;
input pushin;
input [3:0] level;
input [17:0] cntrl_in;
input signed [19:0] wreal;
input signed [19:0] wimag;
input signed [19:0] x1real;
input signed [19:0] x1imag;
input signed [19:0] x2real;
input signed [19:0] x2imag;
output pushout;	
output signed [19:0] out1real;
output signed [19:0] out1imag;
output signed [19:0] out2real;
output signed [19:0] out2imag;	
output reg [17:0] cntrl_out;							

reg signed [19:0] x1_re_d,x1_re;// x1real;
reg signed [19:0] x1_im_d,x1_im;// x1imag;
reg signed [19:0] x2_re_d,x2_re;// x2real;
reg signed [19:0] x2_im_d,x2_im;// x2imag;
reg signed [19:0] tf_re_d,tf_re;// wreal;
reg signed [19:0] tf_im_d,tf_im; //wimag
reg signed [19:0] x2_im_re,x2_im_re_d;
reg signed [19:0] out1real_reg;
reg signed [19:0] out1imag_reg;
reg signed [19:0] out2real_reg,out2real_reg_d;
reg signed [19:0] out2imag_reg,out2imag_reg_d;
reg signed [19:0] out_imag1_round,out_imag2_round;
reg signed [19:0]out_imag1_round_d,out_imag2_round_d;
reg signed [39:0] mul1_re1_d,mul1_re1,mul1_re1_2;
reg signed [39:0] mul1_re2_d,mul1_re2,mul1_re2_2;
reg signed [39:0] mul1_im1_d,mul1_im1,mul1_im1_2;
reg signed [39:0] mul1_im2_d,mul1_im2,mul1_im2_2;
reg signed [19:0] sum1_re;
reg signed [19:0] sum1_re_d;
reg signed [19:0] sum1_re_2,sum1_re_3;
reg signed [19:0] sum1_im;
reg signed [19:0] sum1_im_d;
reg signed [19:0] sum1_im_2,sum1_im_3;
reg signed [19:0] mul1_re1_trunc_d,mul1_re2_trunc_d;
reg signed [19:0] mul1_re1_trunc,mul1_re2_trunc;
reg signed [19:0]mul1_im1_trunc_d,mul1_im2_trunc_d;
reg signed [19:0] mul1_im1_trunc,mul1_im2_trunc;
reg signed [25:0] sum1_im_trunc;
reg signed[25:0] sum1_im_trunc_d;

reg [17:0] cntrl_d[0:10];
reg [17:0] cntrl_reg;
reg signed [19:0] x1_re_2,x1_re_3,x1_re_4,x1_re_5,x1_re_6,x1_re_7,x1_re_8;// x1real;
reg signed [19:0] x1_im_2,x1_im_3,x1_im_4,x1_im_5,x1_im_6,x1_im_7,x1_im_8;// x1imag;
reg signed [19:0] x2_re_2,x2_re_3,x2_re_4,x2_re_5,x2_re_6;// x1real;
reg signed [19:0] x2_im_2,x2_im_3,x2_im_4,x2_im_5,x2_im_6;// x1imag;

reg signed [20:0] s1_re_d;
reg signed [20:0] s1_im_d;
reg signed [20:0] s2_re_d;
reg signed [20:0] s2_im_d;

reg signed [20:0] s1_re[0:10];
reg signed [20:0] s1_real;
reg signed [20:0] s1_im[0:10];
reg signed [20:0] s1_imag;
reg signed [20:0] s2_re [0:10];
reg signed [20:0] s2_real;
reg signed [20:0] s2_im [0:10];
reg signed [20:0] s2_imag;
reg [10:0] valid;
reg pushout_reg,valid_in;
wire signed [19:0] x2_re_w,x2_imag_w,wreal_w,w_imag_w;
localparam [3:0] stage_1 = 0;
localparam [3:0] stage_2 = 1;
localparam [3:0] stage_3 = 2;
localparam [3:0] stage_4 = 3;
localparam [3:0] stage_5 = 4;
localparam [3:0] stage_6 = 5;
localparam [3:0] stage_7 = 6;
localparam [3:0] stage_8 = 7;
localparam [3:0] stage_out = 8;
assign x2_re_w = x2_re_d;
assign x2_imag_w = x2_im_d;
assign wreal_w = tf_re_d;
assign w_imag_w = tf_im_d;
assign pushout = pushout_reg;
assign out1real = out1real_reg;
assign out1imag = out1imag_reg;
assign out2real = out2real_reg;
assign out2imag = out2imag_reg;
wire signed[26:0]s1_trunc,s2_trunc;
wire signed[20:0] s1_to_zero,s1_from_zero;
wire signed[20:0] s2_to_zero,s2_from_zero;
wire signed[20:0] s1_rl_to_zero,s1_rl_from_zero;
wire signed[20:0] s2_rl_to_zero,s2_rl_from_zero;
wire signed [39:0] mul1_re1_to_zero_d,mul1_re1_from_zero_d,mul1_im1_to_zero_d,mul1_im1_from_zero_d;
reg signed [39:0] mul1_re1_to_zero,mul1_re1_from_zero,mul1_im1_to_zero,mul1_im1_from_zero;
wire signed [39:0] mul1_re2_to_zero_d,mul1_im2_to_zero_d,mul1_re2_from_zero_d,mul1_im2_from_zero_d;
reg signed [39:0] mul1_re2_to_zero,mul1_im2_to_zero,mul1_re2_from_zero,mul1_im2_from_zero;
wire signed [28:0] sum_im_to_zero,sum_im_from_zero; //29 bit

//Convergent rounding - round-up/round-down half to even 
assign	s1_to_zero = s1_imag + {{20{1'b0}},!s1_imag[1],{0{s1_imag[1]}}}; //trunc      
assign	s2_to_zero = s2_imag + {{20{1'b0}},!s2_imag[1],{0{s2_imag[1]}}}; //trunc    
assign	s1_from_zero = s1_imag + {{20{1'b0}},s1_imag[1],{0{!s1_imag[1]}}}; //round       
assign	s2_from_zero = s2_imag + {{20{1'b0}},s2_imag[1],{0{!s2_imag[1]}}}; //round  
  
assign mul1_re1_to_zero_d = mul1_re1_d + {{22{1'b0}},!mul1_re1_d[18],{17{mul1_re1_d[18]}}};
assign mul1_re1_from_zero_d = mul1_re1_d + {{22{1'b0}},mul1_re1_d[18],{17{!mul1_re1_d[18]}}};
assign mul1_re2_to_zero_d = mul1_re2_d + {{22{1'b0}},!mul1_re2_d[18],{17{mul1_re2_d[18]}}};
assign mul1_re2_from_zero_d = mul1_re2_d + {{22{1'b0}},mul1_re2_d[18],{17{!mul1_re2_d[18]}}};
  
assign mul1_im1_to_zero_d = mul1_im1_d + {{22{1'b0}},!mul1_im1_d[18],{17{mul1_im1_d[18]}}};
assign mul1_im1_from_zero_d = mul1_im1_d + {{22{1'b0}},mul1_im1_d[18],{17{!mul1_im1_d[18]}}};
assign mul1_im2_to_zero_d = mul1_im2_d + {{22{1'b0}},!mul1_im2_d[18],{17{mul1_im2_d[18]}}};
assign mul1_im2_from_zero_d = mul1_im2_d + {{22{1'b0}},mul1_im2_d[18],{17{!mul1_im2_d[18]}}};

assign sum_im_to_zero = sum1_im + {{26{1'b0}},!sum1_im[3],{4{sum1_im[3]}}};
assign sum_im_from_zero = sum1_im + {{26{1'b0}},sum1_im[3],{4{!sum1_im[3]}}};

DW02_mult_3_stage #(20,20) d0 (.A(x2_re_w), .B(wreal_w),.TC(1'b1),.CLK(clk), .PRODUCT(mul1_re1_d));
DW02_mult_3_stage #(20,20) d1 (.A(x2_imag_w), .B(w_imag_w),.TC(1'b1),.CLK(clk), .PRODUCT(mul1_re2_d));
DW02_mult_3_stage #(20,20) d2 (.A(x2_re_w), .B(w_imag_w),.TC(1'b1),.CLK(clk), .PRODUCT(mul1_im1_d));
DW02_mult_3_stage #(20,20) d3 (.A(x2_imag_w), .B(wreal_w),.TC(1'b1),.CLK(clk), .PRODUCT(mul1_im2_d));

always @(*) begin
	valid_in = pushin;
	if(pushin)
	begin
	//stage 1
	x1_re_d = x1real;
	x1_im_d = x1imag;
	x2_re_d = x2real;
	x2_im_d = x2imag;
	x2_im_re_d = x2imag;
	tf_re_d = wreal;
	tf_im_d = wimag;
	cntrl_reg = cntrl_in;
	end
	else
	begin
	x1_re_d = x1_re;
	x1_im_d = x1_im;
	x2_re_d = x2_re;
	x2_im_d = x2_im;
	x2_im_re_d = x2_im_re;
	tf_re_d = tf_re;
	tf_im_d = tf_im;
	cntrl_reg = cntrl_d[0];
	end
	
 mul1_im2_trunc_d = (mul1_im2_d > 0)?mul1_im2_from_zero_d[39:18]:mul1_im2_to_zero_d[39:18];
 mul1_im1_trunc_d = (mul1_im1_d > 0)?mul1_im1_from_zero_d[39:18]:mul1_im1_to_zero_d[39:18];
 sum1_re_d = (mul1_re1 >>> 18) - (mul1_re2 >>> 18); //
 sum1_im_d =  mul1_im1_trunc + mul1_im2_trunc;
 
 //sum1_im_trunc_d = (sum1_im > 0)?sum_im_from_zero[28:3]:sum_im_to_zero[28:3];
 
	s1_re_d = x1_re_5 + sum1_re; 
	s1_im_d = x1_im_5  + sum1_im; 
	s2_re_d = x1_re_5 - sum1_re;
	s2_im_d = x1_im_5  - sum1_im;
	
 out1imag_reg =(s1_imag > 0)?s1_from_zero[20:1]:s1_to_zero[20:1];
 out2imag_reg =(s2_imag > 0)?s2_from_zero[20:1]:s2_to_zero[20:1];

	out2real_reg = s2_re[0] >>> 1; 
	out1real_reg = s1_re[0] >>> 1; 
	cntrl_out = cntrl_d[5];  
	pushout_reg = valid[5];        
end


always @(posedge clk or posedge reset) begin
	if(reset)begin
		valid <= 0;
		x2_re <= 0;
		x2_im <=0;
		x1_re <= 0;
		x1_im <= 0;
		tf_re <= 0;
		tf_im <= 0;
		valid <= 0;
		x2_re_2 <= 0;
		x2_im_2 <= 0;
		x1_re_2 <= 0;
		x1_im_2 <= 0;
		mul1_im1 <= 0;
		mul1_im2 <= 0;
		x2_im_3 <= 0;
		x2_re_3 <= 0;
		x1_im_3 <= 0;
		x1_re_3 <= 0;
		x2_im_4 <= 0;
		x2_re_4 <= 0;
		x1_im_4 <= 0;
		x1_re_4 <= 0;
		sum1_im <= 0;
		sum1_re <= 0;
		s1_imag <= 0;
		s2_imag <= 0;
		x2_im_re <= 0;
		s1_real <= 0;
		s2_real <= 0;
		//sum1_im_trunc <= 0;
	end
	else
	begin
	  valid[0] <= #1 valid_in;
	  cntrl_d[0] <= #1 cntrl_reg;
		valid[1] <= #1 valid[0];
		cntrl_d[1] <= #1 cntrl_d[0];
		x2_re <= #1 x2_re_d;
		x2_im <= #1 x2_im_d;
		x1_re <= #1 x1_re_d;
		x1_im <= #1 x1_im_d;
		tf_re <= #1 tf_re_d;
		tf_im <= #1 tf_im_d;
		x2_im_re <= #1 x2_im_re_d;
		valid[2] <= #1 valid[1];
	  cntrl_d[2] <= #1 cntrl_d[1];
		x2_re_2 <= #1 x2_re;
		x2_im_2 <= #1 x2_im;
		x1_re_2 <= #1 x1_re;
		x1_im_2 <= #1 x1_im;
		mul1_re1 <= #1 mul1_re1_d;
		mul1_re2 <= #1 mul1_re2_d;
		mul1_im1 <= #1 mul1_im1_d;
		mul1_im2 <= #1 mul1_im2_d;
		mul1_re1_2 <= #1 mul1_re1;
		mul1_re2_2 <= #1 mul1_re2;
		mul1_im1_2 <= #1 mul1_im1;
		mul1_im2_2 <= #1 mul1_im2;
		valid[3] <= #1 valid[2];
	  cntrl_d[3] <= #1 cntrl_d[2];
		x2_im_3 <= #1 x2_im_2;
		x2_re_3 <= #1 x2_re_2;
		x1_im_3 <= #1 x1_im_2;
		x1_re_3 <= #1 x1_re_2;
		sum1_re <= #1 sum1_re_d;
		sum1_im <= #1 sum1_im_d;
		valid[4] <= #1 valid[3];
	  cntrl_d[4] <= #1 cntrl_d[3];
		x2_im_4 <= #1 x2_im_3;
		x2_re_4 <= #1 x2_re_3;
		x1_im_4 <= #1 x1_im_3;
		x1_re_4 <= #1 x1_re_3;
		sum1_re_2 <= #1 sum1_re;
		sum1_im_2 <= #1 sum1_im;	
		valid[5] <= #1 valid[4];
	  cntrl_d[5] <= #1 cntrl_d[4];
		s1_re[0] <= #1 s1_re_d;
		s1_im[0] <= #1 s1_im_d;
		s2_re[0] <= #1 s2_re_d;
		s2_im[0] <= #1 s2_im_d;
		sum1_im_trunc <= #1 sum1_im_trunc_d;
		mul1_re1_trunc <= #1 mul1_re1_trunc_d;
		mul1_re2_trunc <= #1 mul1_re2_trunc_d;
		mul1_im1_trunc <= #1 mul1_im1_trunc_d;
		mul1_im2_trunc <= #1 mul1_im2_trunc_d;
		
		mul1_im1_to_zero <= #1 mul1_im1_to_zero_d;
		mul1_im1_from_zero <= #1 mul1_im1_from_zero_d;
    mul1_im2_to_zero <= #1 mul1_im2_to_zero_d;
    mul1_im2_from_zero <= #1 mul1_im2_from_zero_d; 
    
    mul1_re1_to_zero <= #1 mul1_re1_to_zero_d;
		mul1_re1_from_zero <= #1 mul1_re1_from_zero_d;
    mul1_re2_to_zero <= #1 mul1_re2_to_zero_d;
    mul1_re2_from_zero <= #1 mul1_re2_from_zero_d; 
    
		s1_imag <= #1 s1_im_d;
		s2_imag <= #1 s2_im_d;
		s1_real <= #1 s1_re_d;
		s2_real <= #1 s2_re_d;
		out_imag1_round <= #1 out_imag1_round_d;
		out_imag2_round <= #1 out_imag2_round_d;
		x2_im_5 <= #1 x2_im_4;
		x2_re_5 <= #1 x2_re_4;
		x1_im_5 <= #1 x1_im_4;
		x1_re_5 <= #1 x1_re_4;
		sum1_re_3 <= #1 sum1_re_2;
		sum1_im_3 <= #1 sum1_im_2;
		x2_im_6 <= #1 x2_im_5;
		x2_re_6 <= #1 x2_re_5;
		x1_im_6 <= #1 x1_im_5;
		x1_re_6 <= #1 x1_re_5;
		x1_im_7 <= #1 x1_im_6;
		x1_re_7 <= #1 x1_re_6;
		x1_im_8 <= #1 x1_im_7;
		x1_re_8 <= #1 x1_re_7;
		valid[6] <= #1 valid[5];
		cntrl_d[6] <= #1 cntrl_d[5];
		s1_re[1] <= #1 s1_re[0];
		s1_im[1] <= #1 s1_im[0];
		s2_re[1] <= #1 s2_re[0];
		s2_im[1] <= #1 s2_im[0];
		valid[7] <= #1 valid[6];
		cntrl_d[7] <= #1 cntrl_d[6];
	end
end

//initial begin
  //for(int i=0; i<13; i++) begin
  //  s1_re[i] = 0;
  //  s1_im[i] = 0;
  //  s2_re[i] = 0;
//		s2_im[i] = 0;
 //   valid[i] = 0;
   // cntrl_d[i] = 0;
//  end
//end
endmodule:butterfly
