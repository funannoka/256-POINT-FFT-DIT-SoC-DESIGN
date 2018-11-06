module tf ( 
input clk,
input [6:0] indexbfly,
input enable,
output reg signed [19:0] outreal,
output reg signed [19:0]outimag);
always @ (posedge (clk)) begin
if (enable)
begin
case (indexbfly)
    7'd0:
		begin
			outreal <= 20'sd262144;
			outimag <= -20'sd0;
		end
    7'd1:
		begin
			outreal <= 20'sd262065;
			outimag <= -20'sd6433;
		end
    7'd2:
		begin
			outreal <= 20'sd261828;
			outimag <= -20'sd12863;
		end
    7'd3:
		begin
			outreal <= 20'sd261434;
			outimag <= -20'sd19285;
		end
    7'd4:
		begin
			outreal <= 20'sd260882;
			outimag <= -20'sd25695;
		end
    7'd5:
		begin
			outreal <= 20'sd260173;
			outimag <= -20'sd32089;
		end
    7'd6:
		begin
			outreal <= 20'sd259307;
			outimag <= -20'sd38465;
		end
    7'd7:
		begin
			outreal <= 20'sd258285;
			outimag <= -20'sd44817;
		end
    7'd8:
		begin
			outreal <= 20'sd257107;
			outimag <= -20'sd51142;
		end
    7'd9:
		begin
			outreal <= 20'sd255774;
			outimag <= -20'sd57436;
		end
    7'd10:
		begin
			outreal <= 20'sd254288;
			outimag <= -20'sd63696;
		end
    7'd11:
		begin
			outreal <= 20'sd252648;
			outimag <= -20'sd69917;
		end
    7'd12:
		begin
			outreal <= 20'sd250856;
			outimag <= -20'sd76096;
		end
    7'd13:
		begin
			outreal <= 20'sd248913;
			outimag <= -20'sd82230;
		end
    7'd14:
		begin
			outreal <= 20'sd246820;
			outimag <= -20'sd88314;
		end
    7'd15:
		begin
			outreal <= 20'sd244578;
			outimag <= -20'sd94344;
		end
    7'd16:
		begin
			outreal <= 20'sd242189;
			outimag <= -20'sd100318;
		end
    7'd17:
		begin
			outreal <= 20'sd239655;
			outimag <= -20'sd106232;
		end
    7'd18:
		begin
			outreal <= 20'sd236975;
			outimag <= -20'sd112081;
		end
    7'd19:
		begin
			outreal <= 20'sd234153;
			outimag <= -20'sd117863;
		end
    7'd20:
		begin
			outreal <= 20'sd231190;
			outimag <= -20'sd123574;
		end
    7'd21:
		begin
			outreal <= 20'sd228088;
			outimag <= -20'sd129210;
		end
    7'd22:
		begin
			outreal <= 20'sd224848;
			outimag <= -20'sd134769;
		end
    7'd23:
		begin
			outreal <= 20'sd221473;
			outimag <= -20'sd140246;
		end
    7'd24:
		begin
			outreal <= 20'sd217965;
			outimag <= -20'sd145639;
		end
    7'd25:
		begin
			outreal <= 20'sd214325;
			outimag <= -20'sd150945;
		end
    7'd26:
		begin
			outreal <= 20'sd210556;
			outimag <= -20'sd156159;
		end
    7'd27:
		begin
			outreal <= 20'sd206660;
			outimag <= -20'sd161279;
		end
    7'd28:
		begin
			outreal <= 20'sd202640;
			outimag <= -20'sd166302;
		end
    7'd29:
		begin
			outreal <= 20'sd198498;
			outimag <= -20'sd171225;
		end
    7'd30:
		begin
			outreal <= 20'sd194236;
			outimag <= -20'sd176045;
		end
    7'd31:
		begin
			outreal <= 20'sd189857;
			outimag <= -20'sd180759;
		end
    7'd32:
		begin
			outreal <= 20'sd185364;
			outimag <= -20'sd185364;
		end
    7'd33:
		begin
			outreal <= 20'sd180759;
			outimag <= -20'sd189857;
		end
    7'd34:
		begin
			outreal <= 20'sd176045;
			outimag <= -20'sd194236;
		end
    7'd35:
		begin
			outreal <= 20'sd171225;
			outimag <= -20'sd198498;
		end
    7'd36:
		begin
			outreal <= 20'sd166302;
			outimag <= -20'sd202640;
		end
    7'd37:
		begin
			outreal <= 20'sd161279;
			outimag <= -20'sd206660;
		end
    7'd38:
		begin
			outreal <= 20'sd156159;
			outimag <= -20'sd210556;
		end
    7'd39:
		begin
			outreal <= 20'sd150945;
			outimag <= -20'sd214325;
		end
    7'd40:
		begin
			outreal <= 20'sd145639;
			outimag <= -20'sd217965;
		end
    7'd41:
		begin
			outreal <= 20'sd140246;
			outimag <= -20'sd221473;
		end
    7'd42:
		begin
			outreal <= 20'sd134769;
			outimag <= -20'sd224848;
		end
    7'd43:
		begin
			outreal <= 20'sd129210;
			outimag <= -20'sd228088;
		end
    7'd44:
		begin
			outreal <= 20'sd123574;
			outimag <= -20'sd231190;
		end
    7'd45:
		begin
			outreal <= 20'sd117863;
			outimag <= -20'sd234153;
		end
    7'd46:
		begin
			outreal <= 20'sd112081;
			outimag <= -20'sd236975;
		end
    7'd47:
		begin
			outreal <= 20'sd106232;
			outimag <= -20'sd239655;
		end
    7'd48:
		begin
			outreal <= 20'sd100318;
			outimag <= -20'sd242189;
		end
    7'd49:
		begin
			outreal <= 20'sd94344;
			outimag <= -20'sd244578;
		end
    7'd50:
		begin
			outreal <= 20'sd88314;
			outimag <= -20'sd246820;
		end
    7'd51:
		begin
			outreal <= 20'sd82230;
			outimag <= -20'sd248913;
		end
    7'd52:
		begin
			outreal <= 20'sd76096;
			outimag <= -20'sd250856;
		end
    7'd53:
		begin
			outreal <= 20'sd69917;
			outimag <= -20'sd252648;
		end
    7'd54:
		begin
			outreal <= 20'sd63696;
			outimag <= -20'sd254288;
		end
    7'd55:
		begin
			outreal <= 20'sd57436;
			outimag <= -20'sd255774;
		end
    7'd56:
		begin
			outreal <= 20'sd51142;
			outimag <= -20'sd257107;
		end
    7'd57:
		begin
			outreal <= 20'sd44817;
			outimag <= -20'sd258285;
		end
    7'd58:
		begin
			outreal <= 20'sd38465;
			outimag <= -20'sd259307;
		end
    7'd59:
		begin
			outreal <= 20'sd32089;
			outimag <= -20'sd260173;
		end
    7'd60:
		begin
			outreal <= 20'sd25695;
			outimag <= -20'sd260882;
		end
    7'd61:
		begin
			outreal <= 20'sd19285;
			outimag <= -20'sd261434;
		end
    7'd62:
		begin
			outreal <= 20'sd12863;
			outimag <= -20'sd261828;
		end
    7'd63:
		begin
			outreal <= 20'sd6433;
			outimag <= -20'sd262065;
		end
    7'd64:
		begin
			outreal <= 20'sd0;
			outimag <= -20'sd262144;
		end
    7'd65:
		begin
			outreal <= -20'sd6433;
			outimag <= -20'sd262065;
		end
    7'd66:
		begin
			outreal <= -20'sd12863;
			outimag <= -20'sd261828;
		end
    7'd67:
		begin
			outreal <= -20'sd19285;
			outimag <= -20'sd261434;
		end
    7'd68:
		begin
			outreal <= -20'sd25695;
			outimag <= -20'sd260882;
		end
    7'd69:
		begin
			outreal <= -20'sd32089;
			outimag <= -20'sd260173;
		end
    7'd70:
		begin
			outreal <= -20'sd38465;
			outimag <= -20'sd259307;
		end
    7'd71:
		begin
			outreal <= -20'sd44817;
			outimag <= -20'sd258285;
		end
    7'd72:
		begin
			outreal <= -20'sd51142;
			outimag <= -20'sd257107;
		end
    7'd73:
		begin
			outreal <= -20'sd57436;
			outimag <= -20'sd255774;
		end
    7'd74:
		begin
			outreal <= -20'sd63696;
			outimag <= -20'sd254288;
		end
    7'd75:
		begin
			outreal <= -20'sd69917;
			outimag <= -20'sd252648;
		end
    7'd76:
		begin
			outreal <= -20'sd76096;
			outimag <= -20'sd250856;
		end
    7'd77:
		begin
			outreal <= -20'sd82230;
			outimag <= -20'sd248913;
		end
    7'd78:
		begin
			outreal <= -20'sd88314;
			outimag <= -20'sd246820;
		end
    7'd79:
		begin
			outreal <= -20'sd94344;
			outimag <= -20'sd244578;
		end
    7'd80:
		begin
			outreal <= -20'sd100318;
			outimag <= -20'sd242189;
		end
    7'd81:
		begin
			outreal <= -20'sd106232;
			outimag <= -20'sd239655;
		end
    7'd82:
		begin
			outreal <= -20'sd112081;
			outimag <= -20'sd236975;
		end
    7'd83:
		begin
			outreal <= -20'sd117863;
			outimag <= -20'sd234153;
		end
    7'd84:
		begin
			outreal <= -20'sd123574;
			outimag <= -20'sd231190;
		end
    7'd85:
		begin
			outreal <= -20'sd129210;
			outimag <= -20'sd228088;
		end
    7'd86:
		begin
			outreal <= -20'sd134769;
			outimag <= -20'sd224848;
		end
    7'd87:
		begin
			outreal <= -20'sd140246;
			outimag <= -20'sd221473;
		end
    7'd88:
		begin
			outreal <= -20'sd145639;
			outimag <= -20'sd217965;
		end
    7'd89:
		begin
			outreal <= -20'sd150945;
			outimag <= -20'sd214325;
		end
    7'd90:
		begin
			outreal <= -20'sd156159;
			outimag <= -20'sd210556;
		end
    7'd91:
		begin
			outreal <= -20'sd161279;
			outimag <= -20'sd206660;
		end
    7'd92:
		begin
			outreal <= -20'sd166302;
			outimag <= -20'sd202640;
		end
    7'd93:
		begin
			outreal <= -20'sd171225;
			outimag <= -20'sd198498;
		end
    7'd94:
		begin
			outreal <= -20'sd176045;
			outimag <= -20'sd194236;
		end
    7'd95:
		begin
			outreal <= -20'sd180759;
			outimag <= -20'sd189857;
		end
    7'd96:
		begin
			outreal <= -20'sd185364;
			outimag <= -20'sd185364;
		end
    7'd97:
		begin
			outreal <= -20'sd189857;
			outimag <= -20'sd180759;
		end
    7'd98:
		begin
			outreal <= -20'sd194236;
			outimag <= -20'sd176045;
		end
    7'd99:
		begin
			outreal <= -20'sd198498;
			outimag <= -20'sd171225;
		end
    7'd100:
		begin
			outreal <= -20'sd202640;
			outimag <= -20'sd166302;
		end
    7'd101:
		begin
			outreal <= -20'sd206660;
			outimag <= -20'sd161279;
		end
    7'd102:
		begin
			outreal <= -20'sd210556;
			outimag <= -20'sd156159;
		end
    7'd103:
		begin
			outreal <= -20'sd214325;
			outimag <= -20'sd150945;
		end
    7'd104:
		begin
			outreal <= -20'sd217965;
			outimag <= -20'sd145639;
		end
    7'd105:
		begin
			outreal <= -20'sd221473;
			outimag <= -20'sd140246;
		end
    7'd106:
		begin
			outreal <= -20'sd224848;
			outimag <= -20'sd134769;
		end
    7'd107:
		begin
			outreal <= -20'sd228088;
			outimag <= -20'sd129210;
		end
    7'd108:
		begin
			outreal <= -20'sd231190;
			outimag <= -20'sd123574;
		end
    7'd109:
		begin
			outreal <= -20'sd234153;
			outimag <= -20'sd117863;
		end
    7'd110:
		begin
			outreal <= -20'sd236975;
			outimag <= -20'sd112081;
		end
    7'd111:
		begin
			outreal <= -20'sd239655;
			outimag <= -20'sd106232;
		end
    7'd112:
		begin
			outreal <= -20'sd242189;
			outimag <= -20'sd100318;
		end
    7'd113:
		begin
			outreal <= -20'sd244578;
			outimag <= -20'sd94344;
		end
    7'd114:
		begin
			outreal <= -20'sd246820;
			outimag <= -20'sd88314;
		end
    7'd115:
		begin
			outreal <= -20'sd248913;
			outimag <= -20'sd82230;
		end
    7'd116:
		begin
			outreal <= -20'sd250856;
			outimag <= -20'sd76096;
		end
    7'd117:
		begin
			outreal <= -20'sd252648;
			outimag <= -20'sd69917;
		end
    7'd118:
		begin
			outreal <= -20'sd254288;
			outimag <= -20'sd63696;
		end
    7'd119:
		begin
			outreal <= -20'sd255774;
			outimag <= -20'sd57436;
		end
    7'd120:
		begin
			outreal <= -20'sd257107;
			outimag <= -20'sd51142;
		end
    7'd121:
		begin
			outreal <= -20'sd258285;
			outimag <= -20'sd44817;
		end
    7'd122:
		begin
			outreal <= -20'sd259307;
			outimag <= -20'sd38465;
		end
    7'd123:
		begin
			outreal <= -20'sd260173;
			outimag <= -20'sd32089;
		end
    7'd124:
		begin
			outreal <= -20'sd260882;
			outimag <= -20'sd25695;
		end
    7'd125:
		begin
			outreal <= -20'sd261434;
			outimag <= -20'sd19285;
		end
    7'd126:
		begin
			outreal <= -20'sd261828;
			outimag <= -20'sd12863;
		end
    7'd127:
		begin
			outreal <= -20'sd262065;
			outimag <= -20'sd6433;
		end
    default:
		begin
			outreal <= 20'd0;
			outimag <= 20'd0;
		end
   endcase
end
end
endmodule
