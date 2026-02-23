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

.subckt  inv44_7  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=4.47u m=6
mn		out		in		gnd		gnd		N_18		l=0.18u	w=5.59u m=2
.ends

.subckt  inv12_6  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=7.56u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=3.15u
.ends

.subckt  inv158_77  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=6.35u m=15
mn		out		in		gnd		gnd		N_18		l=0.18u	w=7.94u m=5
.ends

.subckt  inv6_69  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=4u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=1.67u
.ends

.subckt  inv229_4  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=9.83u m=14
mn		out		in		gnd		gnd		N_18		l=0.18u	w=9.55u m=6
.ends

.subckt  inv4_573  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=2.74u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=1.14u
.ends

.subckt  inv20_91  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=6.27u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=6.22u
.ends

.subckt  inv95_63  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=8.2u m=7
mn		out		in		gnd		gnd		N_18		l=0.18u	w=5.97u m=4
.ends

.subckt  inv437_33  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=8.74u m=30
mn		out		in		gnd		gnd		N_18		l=0.18u	w=5.46u m=20
.ends

.subckt  inv3_55  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=2.13u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.88u
.ends

.subckt  inv563_67  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=8.45u m=40
mn		out		in		gnd		gnd		N_18		l=0.18u	w=9.39u m=15
.ends

.subckt  inv2000  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=2.4u m=500
mn		out		in		gnd		gnd		N_18		l=0.18u	w=1u m=500
.ends

*1
xINV_1 in out1 inv
xINV_1_2 out1 n inv2000

*2
xINV_2 in n2 inv
xINV_2_2 n2 out2 inv44_7
xINV_2_3 out2 n3 inv2000

*3
xINV_3 in n4 inv
xINV_3_2 n4 n5 inv12_6
xINV_3_3 n5 out3 inv158_77
xINV_3_4 out3 n6 inv2000

*4
xINV_4 in n7 inv
xINV_4_2 n7 n8 inv6_69
xINV_4_3 n8 n9 inv44_7
xINV_4_4 n9 out4 inv229_4
xINV_4_5 out4 n10 inv2000

*5
xINV_5 in n11 inv
xINV_5_2 n11 n12 inv4_573
xINV_5_3 n12 n13 inv20_91
xINV_5_4 n13 n14 inv95_63
xINV_5_5 n14 out5 inv437_33
xINV_5_6 out5 n15 inv2000

*6
xINV_6 in n16 inv
xINV_6_2 n16 n17 inv3_55
xINV_6_3 n17 n18 inv12_6
xINV_6_4 n18 n19 inv44_7
xINV_6_5 n19 n20 inv158_77
xINV_6_6 n20 out6 inv563_67
xINV_6_7 out6 n21 inv2000

vvdd	vdd		0		1.8
vgnd	gnd		0		0

*名稱 線路 接地 pulse(V1 V2 TD TR TF PW Per)
vin		in		gnd		pulse(0 	1.8		0.1n	0.1n	0.1n	4.9n	10n)

.meas	tran	delay1	trig	v(in)	val=0.9		rise=2
+						targ	v(out1)	val=0.9		fall=2

.meas	tran	delay2	trig	v(in)	val=0.9		rise=2
+						targ	v(out2)	val=0.9		rise=2

.meas	tran	delay3	trig	v(in)	val=0.9		rise=2
+						targ	v(out3)	val=0.9		fall=2

.meas	tran	delay4	trig	v(in)	val=0.9		rise=2
+						targ	v(out4) val=0.9		rise=2

.meas	tran	delay5	trig	v(in)	val=0.9		rise=2
+						targ	v(out5) val=0.9		fall=2

.meas	tran	delay6	trig	v(in)	val=0.9		rise=2
+						targ	v(out6) val=0.9		rise=2


.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 640n (*sweep 	k 	0.05p  0.5p   0.05p)
.end
