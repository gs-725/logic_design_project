module car_start_check(pin,engineoil1,batteryvoltage1,oilpressure1,fuellevel1,waterlevel1,
	tyrepressure1,seatbelt,airbag,enginetemp1,rain_sensor_auto,rain_level,headlight,drivemode,war_engineoil,war_batteryvoltage,war_oilpressure,war_fuellevel,
	war_waterlevel,war_tyrepressure,war_seatbelt,war_airbag,war_enginetemp,
	key,readytogo,rs,es,as,ds,ys,wiperspeed,foglight,lowbeam,highbeam,height,expectedrange);


input [16:1]pin,engineoil1,batteryvoltage1,oilpressure1,fuellevel1,waterlevel1,
	tyrepressure1,enginetemp1;
input seatbelt,airbag,rain_sensor_auto;
input [2:1]rain_level;
input [3:1]headlight;
input [4:1]drivemode;
output foglight,lowbeam,highbeam;
output [4:1]height;
wire [7:0]fuel;


output war_engineoil,war_batteryvoltage,war_oilpressure,war_fuellevel,
	war_waterlevel,war_tyrepressure,war_seatbelt,war_airbag,war_enginetemp,
	key,readytogo;
	output [2:1]wiperspeed;
output [10:1]rs,es,as,ds,ys;
output [15:0]expectedrange;

wire engineoil,batteryvoltage,oilpressure,fuellevel,waterlevel,
	tyrepressure,enginetemp;

parameter [16:1]stdengineoil1=520,stdbatteryvoltage1=50,stdoilpressure1=100,stdfuellevel1=1,stdwaterlevel1=400,
	stdtyrepressure1=70,stdenginetemp1=190;
	parameter[7:0]mileage=29;
	
and(fuel[7],fuellevel1[8],key);
and(fuel[6],fuellevel1[7],key);
and(fuel[5],fuellevel1[6],key);
and(fuel[4],fuellevel1[5],key);
and(fuel[3],fuellevel1[4],key);
and(fuel[2],fuellevel1[3],key);	
and(fuel[1],fuellevel1[2],key);
and(fuel[0],fuellevel1[1],key);
	
	
multiplyer_eight ma1(fuel,mileage,expectedrange);
wire t1,r1,s1,
     t2,r2,s2,
     t3,r3,s3,
     t4,r4,s4,
     t5,r5,s5,
     t6,r6,s6,
     t7,r7,s7;
	  
wire [4:1]rain;
or(rain[4],key,key);
or(rain[3],rain_sensor_auto,rain_sensor_auto);
or(rain[2],rain_level[2],rain_level[2]);
or(rain[1],rain_level[1],rain_level[1]);


rain_sensor rs1(rain,wiperspeed);		
headlight_adjustment head11(key,headlight,foglight,lowbeam,highbeam);
ride_height_adjustment rd451(readytogo,drivemode,height);

comparator cmp161(engineoil1,stdengineoil1,t1,r1,s1),
	   cmp162(batteryvoltage1,stdbatteryvoltage1,t2,r2,s2),
	   cmp163(oilpressure1,stdoilpressure1,t3,r3,s3),
           cmp164(fuellevel1,stdfuellevel1,t4,r4,s4),
           cmp165(waterlevel1,stdwaterlevel1,t5,r5,s5),
           cmp166(tyrepressure1,stdtyrepressure1,t6,r6,s6),
           cmp17(enginetemp1,stdenginetemp1,t7,r7,s7);

or(enginetemp,t7,s7);
or(tyrepressure,r6,s6);
or(waterlevel,r5,s5);
or(fuellevel,r4,s4);
or(oilpressure,r3,s3);
or(batteryvoltage,r2,s2);
or(engineoil,r1,s1);



digi_lock lock1(pin,key);

wire p1,p2,p3,p4,p5,p6,p7,p8,p9;

and(p1,key,engineoil);
and(p2,key,batteryvoltage);
and(p3,key,oilpressure);
and(p4,key,fuellevel);
and(p5,key,waterlevel);




and(p6,key,tyrepressure);
and(p7,key,enginetemp);
and(p8,key,airbag);
and(p9,key,seatbelt);

wire n1,n2,n3,n4,n5,n6,n7,n8,n9;
not(n1,p1);
not(n2,p2);
not(n3,p3);
not(n4,p4);
not(n5,p5);
not(n6,p6);
not(n7,p7);
not(n8,p8);
not(n9,p9);



and(war_engineoil,key,n1);
and(war_batteryvoltage,key,n2);
and(war_oilpressure,key,n3);
and(war_fuellevel,key,n4);
and(war_waterlevel,key,n5);
and(war_tyrepressure,key,n6);
and(war_enginetemp,key,n7);
and(war_airbag,key,n8);
and(war_seatbelt,key,n9);


and(readytogo,p1,p2,p3,p4,p5,p6,p7,p8,p9);

r r11(readytogo,rs);
e e1(readytogo,es);
a a1(readytogo,as);
d d1(readytogo,ds);
y y1(readytogo,ys);

endmodule


module a(input t,output [10:1]segment);
//1,2,4,5,6,8
wire t1,p,w;
not(t1,t);
or(p,t1,t);
and(w,t1,t);

and(segment[1],t,p);
and(segment[2],t,p);
and(segment[4],t,p);
and(segment[5],t,p);
and(segment[6],t,p);
and(segment[8],t,p);
and(segment[3],t,w);
and(segment[7],t,w);
and(segment[9],t,w);
and(segment[10],t,w);

endmodule

module comparator(a,b,t,r,s);

input [16:1]a,b;
wire t1,s1;

output t,r,s;
equal_comparator cmp11(a,b,s);
lessthan_comparator ltcmp1(b,a,t1);
not(s1,s);
and(t,s1,t1);

wire y;
or(y,s,t);

not(r,y);



endmodule

module d(input a,output [10:1]segment);
//1,2,3,4,5,6
wire a1,p,w;
not(a1,a);
or(p,a1,a);
and(w,a1,a);


and(segment[1],a,p);
and(segment[2],a,p);
and(segment[3],a,p);
and(segment[4],a,p);
and(segment[5],a,p);
and(segment[6],a,p);
and(segment[7],a,w);
and(segment[8],a,w);
and(segment[9],a,w);
and(segment[10],a,w);

endmodule

module e(input a,output [10:1]segment);
//1,2,3,6,8
wire a1,p,w;
not(a1,a);
or(p,a1,a);
and(w,a1,a);


and(segment[1],a,p);
and(segment[2],a,p);
and(segment[3],a,p);
and(segment[6],a,p);
and(segment[8],a,p);
and(segment[4],a,w);
and(segment[5],a,w);
and(segment[7],a,w);
and(segment[9],a,w);
and(segment[10],a,w);

endmodule

module equal_comparator(input [16:1]a,b,output s);

wire [16:1]e;

xnor_gate x1(a[1],b[1],e[1]),
	  x2(a[2],b[2],e[2]),
  	  x3(a[3],b[3],e[3]),
	  x4(a[4],b[4],e[4]),
	  x5(a[5],b[5],e[5]),
 	  x6(a[6],b[6],e[6]),
	  x7(a[7],b[7],e[7]),
	  x8(a[8],b[8],e[8]),
	  x9(a[9],b[9],e[9]),
	  x10(a[10],b[10],e[10]),
	  x11(a[11],b[11],e[11]),
	  x12(a[12],b[12],e[12]),
	  x13(a[13],b[13],e[13]),
	  x14(a[14],b[14],e[14]),
	  x15(a[15],b[15],e[15]),
	  x16(a[16],b[16],e[16]);


and(s,e[1],e[2],e[3],e[4],e[5],e[6],e[7],e[8],e[9],e[10],
	e[11],e[12],e[13],e[14],e[15],e[16]);

endmodule

module full_adder_carry(input a,b,c,output carry);

wire w1,w2,w3;

and(w1,a,b);
and(w2,b,c);
and(w3,a,c);
or(carry,w1,w2,w3);

endmodule



module lessthan_comparator(input [16:1]a,b1,output t);

wire [15:1]carry;
wire one,a1;
wire [16:1]b;
not(a1,a[16]);
or(one,a1,a[16]);


not(b[1],b1[1]);
not(b[2],b1[2]);
not(b[3],b1[3]);
not(b[4],b1[4]);
not(b[5],b1[5]);
not(b[6],b1[6]);
not(b[7],b1[7]);
not(b[8],b1[8]);
not(b[9],b1[9]);
not(b[10],b1[10]);
not(b[11],b1[11]);
not(b[12],b1[12]);
not(b[13],b1[13]);
not(b[14],b1[14]);
not(b[15],b1[15]);
not(b[16],b1[16]);





full_adder_carry c1(a[1],b[1],one,carry[15]),
		 c2(a[2],b[2],carry[15],carry[14]),
		 c3(a[3],b[3],carry[14],carry[13]),
		 c4(a[4],b[4],carry[13],carry[12]),
		 c5(a[5],b[5],carry[12],carry[11]),
		 c6(a[6],b[6],carry[11],carry[10]),
		 c7(a[7],b[7],carry[10],carry[9]),
		 c8(a[8],b[8],carry[9],carry[8]),
		 c9(a[9],b[9],carry[8],carry[7]),
		 c10(a[10],b[10],carry[7],carry[6]),
		 c11(a[11],b[11],carry[6],carry[5]),
		 c12(a[12],b[12],carry[5],carry[4]),
		 c13(a[13],b[13],carry[4],carry[3]),
		 c14(a[14],b[14],carry[3],carry[2]),
		 c15(a[15],b[15],carry[2],carry[1]),
		 c16(a[16],b[16],carry[1],t);

endmodule


 module digi_lock(
    input [16:1] pin,
    output y
);

parameter [16:1] passcode =9999;

wire [16:1] xor_results;

xnor_gate xnor1(pin[1],passcode[1],xor_results[1]),
	  xnor2(pin[2],passcode[2],xor_results[2]),
  	  xnor3(pin[3],passcode[3],xor_results[3]),
	  xnor4(pin[4],passcode[4],xor_results[4]),
	  xnor5(pin[5],passcode[5],xor_results[5]),
 	  xnor6(pin[6],passcode[6],xor_results[6]),
	  xnor7(pin[7],passcode[7],xor_results[7]),
	  xnor8(pin[8],passcode[8],xor_results[8]),
	  xnor9(pin[9],passcode[9],xor_results[9]),
	  xnor10(pin[10],passcode[10],xor_results[10]),
	  xnor11(pin[11],passcode[11],xor_results[11]),
	  xnor12(pin[12],passcode[12],xor_results[12]),
	  xnor13(pin[13],passcode[13],xor_results[13]),
	  xnor14(pin[14],passcode[14],xor_results[14]),
	  xnor15(pin[15],passcode[15],xor_results[15]),
	  xnor16(pin[16],passcode[16],xor_results[16]);


and(y,xor_results[1],xor_results[2],xor_results[3],xor_results[4],xor_results[5],
	xor_results[6],xor_results[7],xor_results[8],xor_results[9],xor_results[10],
	xor_results[11],xor_results[12],xor_results[13],xor_results[14],xor_results[15],
	xor_results[16]);



endmodule


module r(input a,output [10:1]segment);
//1,5,6,8,9
wire a1,p,w;
not(a1,a);
or(p,a1,a);
and(w,a1,a);

and(segment[1],a,p);
and(segment[5],a,p);
and(segment[6],a,p);
and(segment[8],a,p);
and(segment[9],a,p);
and(segment[2],a,w);
and(segment[3],a,w);
and(segment[4],a,w);
and(segment[7],a,w);
and(segment[10],a,w);

endmodule

module xnor_gate(a,b,y);

input a,b;
output y;

wire a1,b1,s,p1,p2;

not(a1,a);
not(b1,b);

and(p1,a1,b);
and(p2,a,b1);

or(s,p1,p2);
not(y,s);


endmodule

module y(input a,output [10:1]segment);
//5,7,10
wire a1,p,w;
not(a1,a);
or(p,a1,a);
and(w,a1,a);

and(segment[5],a,p);
and(segment[7],a,p);
and(segment[10],a,p);
and(segment[1],a,w);
and(segment[2],a,w);
and(segment[3],a,w);
and(segment[4],a,w);
and(segment[6],a,w);
and(segment[8],a,w);
and(segment[9],a,w);

endmodule

module rain_sensor(input [4:1]a,output [2:1]b);

and(b[2],a[2],a[3],a[4]);
and(b[1],a[1],a[3],a[4]);

endmodule

module headlight_adjustment(key,a,foglight,lowbeam,highbeam);
input [3:1]a;
input key;
output foglight,lowbeam,highbeam;
and(foglight,key,a[3]);
and(lowbeam,key,a[2]);
wire high;
and(high,key,a[1]);
wire low1;
not(low1,lowbeam);
and(highbeam,low1,high);
endmodule

module ride_height_adjustment(ready,drivemode,height);
input ready;
input [4:1]drivemode;
output [4:1]height;
wire [4:1]drivemode1;
and(drivemode1[4],ready,drivemode[4]);
and(drivemode1[3],ready,drivemode[3]);
and(drivemode1[2],ready,drivemode[2]);
and(drivemode1[1],ready,drivemode[1]);
wire [4:1] heights,heightn,heightc,heighto;
wire zero,one;
wire u;
not(u,ready);
and(zero,u,ready);
or(one,u,ready);

//max 15 heightlifted from wheel
//sports 0
//normal 5
//comfort 10
//ofroad 15

//sports
and(heights[4],zero,drivemode1[4]);
and(heights[3],zero,drivemode1[4]);
and(heights[2],zero,drivemode1[4]);
and(heights[1],zero,drivemode1[4]);

//normal
and(heightn[4],zero,drivemode1[3]);
and(heightn[3],one,drivemode1[3]);
and(heightn[2],zero,drivemode1[3]);
and(heightn[1],one,drivemode1[3]);

//comfort
and(heightc[4],one,drivemode1[2]);
and(heightc[3],zero,drivemode1[2]);
and(heightc[2],one,drivemode1[2]);
and(heightc[1],zero,drivemode1[2]);

//ofroad
and(heighto[4],one,drivemode1[1]);
and(heighto[3],one,drivemode1[1]);
and(heighto[2],one,drivemode1[1]);
and(heighto[1],one,drivemode1[1]);

//finalheight

or(height[4],heights[4],heightn[4],heightc[4],heighto[4]);
or(height[3],heights[3],heightn[3],heightc[3],heighto[3]);
or(height[2],heights[2],heightn[2],heightc[2],heighto[2]);
or(height[1],heights[1],heightn[1],heightc[1],heighto[1]);

endmodule

module multiplyer_eight(a,b,y);
input [7:0]a,b;
output [15:0]y;
wire [161:0]c;

wire a1;
not(a1,a[5]);
wire zero;
and(zero,a1,a[5]);


and_gate and1(a[0],b[0],y[0]);

and_gate and2(a[1],b[0],c[0]);
and_gate and3(a[0],b[1],c[1]);
fa fa1(c[0],c[1],zero,y[1],c[2]);

and_gate and4(a[2],b[0],c[3]);
and_gate and5(a[1],b[1],c[4]);
and_gate and6(a[0],b[2],c[5]);
fa fa2(c[3],c[4],c[5],c[6],c[7]);
fa fa3(c[6],c[2],zero,y[2],c[8]);

and_gate and7(a[3],b[0],c[9]);
and_gate and8(a[2],b[1],c[10]);
and_gate and9(a[1],b[2],c[11]);
and_gate and10(a[0],b[3],c[12]);
fa fa4(c[9],c[10],c[11],c[13],c[14]);
fa fa5(c[12],c[7],c[8],c[15],c[16]);
fa fa6(c[15],c[13],zero,y[3],c[17]);


and_gate and11(a[4],b[0],c[18]);
and_gate and12(a[3],b[1],c[19]);
and_gate and13(a[2],b[2],c[20]);
and_gate and14(a[1],b[3],c[21]);
and_gate and15(a[0],b[4],c[22]);
fa fa7(c[18],c[19],c[20],c[23],c[24]);
fa fa8(c[21],c[22],c[14],c[25],c[26]);
fa fa9(c[16],c[17],c[23],c[27],c[28]);
fa fa10(c[27],c[25],zero,y[4],c[29]);


and_gate and16(a[5],b[0],c[30]);
and_gate and17(a[4],b[1],c[31]);
and_gate and18(a[3],b[2],c[32]);
and_gate and19(a[2],b[3],c[33]);
and_gate and20(a[1],b[4],c[34]);
and_gate and21(a[0],b[5],c[35]);
fa fa11(c[30],c[31],c[32],c[36],c[37]);
fa fa12(c[33],c[34],c[35],c[38],c[39]);
fa fa13(c[36],c[38],c[24],c[40],c[41]);
fa fa14(c[26],c[28],c[29],c[42],c[43]);
fa fa15(c[42],c[40],zero,y[5],c[44]);

and_gate and22(a[6],b[0],c[45]);
and_gate and23(a[5],b[1],c[46]);
and_gate and24(a[4],b[2],c[47]);
and_gate and25(a[3],b[3],c[48]);
and_gate and26(a[2],b[4],c[49]);
and_gate and27(a[1],b[5],c[50]);
and_gate and28(a[0],b[6],c[51]);
fa fa16(c[45],c[46],c[47],c[52],c[53]);
fa fa17(c[48],c[49],c[50],c[54],c[55]);
fa fa18(c[51],c[52],c[54],c[56],c[57]);
fa fa19(c[56],c[37],c[39],c[58],c[59]);
fa fa20(c[58],c[41],c[43],c[60],c[61]);
fa fa21(c[60],c[44],zero,y[6],c[62]);

and_gate and29(a[7],b[0],c[63]);
and_gate and30(a[6],b[1],c[64]);
and_gate and31(a[5],b[2],c[65]);
and_gate and32(a[4],b[3],c[66]);
and_gate and33(a[3],b[4],c[67]);
and_gate and34(a[2],b[5],c[68]);
and_gate and35(a[1],b[6],c[69]);
and_gate and36(a[0],b[7],c[70]);
fa fa22(c[63],c[64],c[65],c[71],c[72]);
fa fa23(c[66],c[67],c[68],c[73],c[74]);
fa fa24(c[69],c[70],c[71],c[75],c[76]);
fa fa25(c[75],c[73],c[53],c[77],c[78]);
fa fa26(c[77],c[55],c[57],c[79],c[80]);
fa fa27(c[79],c[59],c[61],c[81],c[82]);
fa fa28(c[81],c[62],zero,y[7],c[83]);

and_gate and37(a[7],b[1],c[84]);
and_gate and38(a[6],b[2],c[85]);
and_gate and39(a[5],b[3],c[86]);
and_gate and40(a[4],b[4],c[87]);
and_gate and41(a[3],b[5],c[88]);
and_gate and42(a[2],b[6],c[89]);
and_gate and43(a[1],b[7],c[90]);
fa fa29(c[84],c[85],c[86],c[91],c[92]);
fa fa30(c[87],c[88],c[89],c[93],c[94]);
fa fa31(c[90],c[91],c[93],c[95],c[96]);
fa fa32(c[95],c[72],c[74],c[97],c[98]);
fa fa33(c[97],c[76],c[78],c[99],c[100]);
fa fa34(c[99],c[80],c[82],c[101],c[102]);
fa fa35(c[101],c[83],zero,y[8],c[103]);

and_gate and44(a[7],b[2],c[104]);
and_gate and45(a[6],b[3],c[105]);
and_gate and46(a[5],b[4],c[106]);
and_gate and47(a[4],b[5],c[107]);
and_gate and48(a[3],b[6],c[108]);
and_gate and49(a[2],b[7],c[109]);
fa fa36(c[104],c[105],c[106],c[110],c[111]);
fa fa37(c[107],c[108],c[109],c[112],c[113]);
fa fa38(c[110],c[92],c[94],c[114],c[115]);
fa fa39(c[112],c[96],c[98],c[116],c[117]);
fa fa401(c[114],c[100],c[102],c[118],c[119]);
fa fa40(c[116],c[103],c[118],y[9],c[120]);

and_gate and50(a[7],b[3],c[121]);
and_gate and51(a[6],b[4],c[122]);
and_gate and52(a[5],b[5],c[123]);
and_gate and53(a[4],b[6],c[124]);
and_gate and54(a[3],b[7],c[125]);
fa fa41(c[121],c[122],c[123],c[126],c[127]);
fa fa42(c[124],c[125],c[126],c[128],c[129]);
fa fa43(c[128],c[111],c[113],c[130],c[131]);
fa fa44(c[130],c[115],c[117],c[132],c[133]);
fa fa45(c[132],c[119],c[120],c[134],c[135]);
fa fa46(c[134],zero,zero,y[10],c[136]);

and_gate and55(a[7],b[4],c[137]);
and_gate and56(a[6],b[5],c[138]);
and_gate and57(a[5],b[6],c[139]);
and_gate and58(a[4],b[7],c[140]);
fa fa47(c[137],c[138],c[139],c[141],c[142]);
fa fa48(c[140],c[129],c[131],c[143],c[144]);
fa fa49(c[141],c[133],c[135],c[145],c[146]);
fa fa50(c[141],c[143],c[145],y[11],c[147]);

and_gate and59(a[7],b[5],c[148]);
and_gate and60(a[6],b[6],c[149]);
and_gate and61(a[5],b[7],c[150]);
fa fa51(c[148],c[149],c[150],c[151],c[152]);
fa fa52(c[151],c[142],c[144],c[153],c[154]);
fa fa53(c[153],c[146],c[147],y[12],c[155]);

and_gate and62(a[7],b[6],c[156]);
and_gate and63(a[6],b[7],c[157]);
fa fa54(c[156],c[157],c[152],c[158],c[159]);
fa fa55(c[158],c[154],c[155],y[13],c[160]);

and_gate and64(a[7],b[7],c[161]);
fa fa56(c[161],c[159],c[160],y[14],y[15]);


endmodule 

module xor_gate(a,b,y);
input a,b;
output y;

wire a1,b1,s,p1,p2;

not(a1,a);
not(b1,b);

and(p1,a1,b);
and(p2,a,b1);

or(y,p1,p2);
endmodule

module fa(input a,b,c,output sum,carry);

wire p1,p2,p3;

xor_gate x1(a,b,p1),
	 x2(p1,c,sum);
and(p2,c,p1);
and(p3,a,b);
or(carry,p2,p3);
endmodule

module and_gate(input a,b,output y);
and(y,a,b);
endmodule
















