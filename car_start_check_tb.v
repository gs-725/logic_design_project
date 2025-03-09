module car_start_check_tb;

reg seatbelt,airbag;
reg [16:1]pin,engineoil,batteryvoltage,oilpressure,fuellevel,waterlevel,
	tyrepressure,enginetemp;
reg[2:1]rain_level;
reg rain_sensor_auto;
reg [3:1]headlight;
reg[4:1]drivemode;
wire[4:1]height;
wire foglight,lowbeam,highbeam;
wire [15:0]expectedrange;

wire war_engineoil,war_batteryvoltage,war_oilpressure,war_fuellevel,
	war_waterlevel,war_tyrepressure,war_seatbelt,war_airbag,war_enginetemp,
	key,readytogo;
wire [10:1]rs,es,as,ds,ys;
wire [2:1]wiperspeed;

car_start_check car1(pin,engineoil,batteryvoltage,oilpressure,fuellevel,waterlevel,
	tyrepressure,seatbelt,airbag,enginetemp,rain_sensor_auto,rain_level,headlight,drivemode,war_engineoil,war_batteryvoltage,war_oilpressure,war_fuellevel,
	war_waterlevel,war_tyrepressure,war_seatbelt,war_airbag,war_enginetemp,
	key,readytogo,rs,es,as,ds,ys,wiperspeed,foglight,lowbeam,highbeam,height,expectedrange);
initial begin


		$monitor("pin=%d,engineoil=%d,batteryvoltage=%d,oilpressure=%d,fuellevel=%d,waterlevel=%d,tyrepressure=%d,seatbelt=%b,airbag=%b,enginetemp=%d,rain_sensor_auto=%b,rain_level=%d,headlight=%b,drivemode=%b,war_engineoil=%b,war_batteryvoltage=%b,war_oilpressure=%b,war_fuellevel=%b,war_waterlevel=%b,war_tyrepressure=%b,war_seatbelt=%b,war_airbag=%b,war_enginetemp=%b,key=%b,readytogo=%b,rs=%b,es=%b,as=%b,ds=%b,ys=%b,wiperspeed=%d,foglight=%b,lowbeam=%b,highbeam=%b,height=%d,expectedrang=%d",pin,engineoil,batteryvoltage,
			oilpressure,fuellevel,waterlevel,
			tyrepressure,seatbelt,airbag,enginetemp,rain_sensor_auto,rain_level,headlight,drivemode,
			war_engineoil,war_batteryvoltage,war_oilpressure,war_fuellevel,
			war_waterlevel,war_tyrepressure,war_seatbelt,war_airbag,war_enginetemp,
			key,readytogo,rs,es,as,ds,ys,wiperspeed,foglight,lowbeam,highbeam,height,expectedrange);

pin =1816;engineoil=530;batteryvoltage=53;oilpressure=101;fuellevel=10;waterlevel=450;tyrepressure=100;seatbelt=1;airbag=1;enginetemp=168;rain_sensor_auto=1;rain_level=3;headlight=3'b110;drivemode=4'b1000;
#30
pin =9999;engineoil=530;batteryvoltage=53;oilpressure=101;fuellevel=10;waterlevel=450;tyrepressure=100;seatbelt=1;airbag=1;enginetemp=168;rain_sensor_auto=1;rain_level=2;headlight=3'b110;drivemode=4'b0100;
#30
pin =2679;engineoil=513;batteryvoltage=13;oilpressure=1981;fuellevel=165;waterlevel=10;tyrepressure=65;seatbelt=1;airbag=1;enginetemp=210;rain_sensor_auto=0;rain_level=0;headlight=3'b100;drivemode=4'b0100;
#30

pin=9999;engineoil=519;batteryvoltage=25;oilpressure=10;fuellevel=0;waterlevel=60;tyrepressure=10;seatbelt=1;airbag=1;enginetemp=1000;rain_sensor_auto=1;rain_level=1;headlight=3'b100;drivemode=4'b0010;
#30

pin=9999;engineoil=520;batteryvoltage=50;oilpressure=100;fuellevel=1;waterlevel=400;tyrepressure=25;seatbelt=0;airbag=0;enginetemp=1000;rain_sensor_auto=1;rain_level=3;headlight=3'b010;drivemode=4'b0001;
#30

pin=9999;engineoil=1;batteryvoltage=0;oilpressure=1;fuellevel=0;waterlevel=1;tyrepressure=1;seatbelt=1;airbag=0;enginetemp=1;rain_sensor_auto=0;rain_level=0;headlight=3'b101;drivemode=4'b0100;
#30


$finish;

end

endmodule