3-input xor (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd


.subckt  inv  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=0.6u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.25u
.ends

.subckt  inv2_8  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=1.68u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.7u
.ends

.subckt  inv4  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=2.4u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=1u
.ends

.subckt  inv8  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=4.8u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=2u
.ends

.subckt  inv16  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=9.6u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=4u
.ends

.subckt  inv22_6  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=4.52u m=3
mn		out		in		gnd		gnd		N_18		l=0.18u	w=5.65u
.ends

.subckt  inv64  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=2.4u m=16
mn		out		in		gnd		gnd		N_18		l=0.18u	w=1u m=16
.ends

*1
xINV_1 in net inv
xINV_1_2 net out1 inv64

*2
xINV_2 in net2 inv
xINV_2_2 net2 net3 inv8
xINV_2_3 net3 out2 inv64

*3
xINV_3 in net4 inv
xINV_3_2 net4 net5 inv4
xINV_3_3 net5 net6 inv16
xINV_3_4 net6 out3 inv64

*4
xINV_4 in net7 inv
xINV_4_2 net7 net8 inv2_8
xINV_4_3 net8 net9 inv8
xINV_4_4 net9 net10 inv22_6
xINV_4_5 net10 out4 inv64


vvdd	vdd		0		1.8
vgnd	gnd		0		0

*名稱 線路 接地 pulse(V1 V2 TD TR TF PW Per)
vin		in		gnd		pulse(0 	1.8		0.1n	0.1n	0.1n	4.9n	10n)

.meas	tran	delay1	trig	v(in)	val=0.9		rise=2
+						targ	v(net)	val=0.9		fall=2

.meas	tran	delay2	trig	v(in)	val=0.9		rise=2
+						targ	v(net3)	val=0.9		rise=2

.meas	tran	delay3	trig	v(in)	val=0.9		rise=2
+						targ	v(net6)	val=0.9		fall=2

.meas	tran	delay4	trig	v(in)	val=0.9		rise=2
+						targ	v(net10) val=0.9	rise=2

.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 640n (*sweep 	k 	0.05p  0.5p   0.05p)
.end
