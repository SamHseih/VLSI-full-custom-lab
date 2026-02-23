3-input xor (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd


.subckt  inv  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=2u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=1u
.ends

.subckt  xor3  a b c out
xINV_A a a_  inv
xINV_B b b_  inv
xINV_C c c_  inv
xINV_X x_0 x_  inv

mn0		a		b_		x_0		gnd		N_18		l=0.18u	w=1u
mn1		a_		b		x_0 	gnd		N_18		l=0.18u	w=1u
xINV_X1 x_0 x_1  inv
xINV_X2 x_1 x  inv
mn2		c		x_		out		gnd		N_18		l=0.18u	w=1u
mn3		c_		x		out		gnd		N_18		l=0.18u	w=1u
.ends

 


xXOR_1 a b c out xor3
c1 out gnd 0.02p

vvdd	vdd		0		1.8
vgnd	gnd		0		0

*(pulse脈衝 0(起始點) 1.8(最高點) 5n(開始延遲的時間)  0.01n(切換的時間) 0.01n 2.49n(在輸入1的時間) 5n(週期))
va		a		0		pulse(1.8	0	0.1n	0.1n	0.1n	39.9n	80n)
vb		b		0		pulse(1.8	0	0.1n	0.1n	0.1n	79.9n	160n)
vc		c		0		pulse(1.8	0	0.1n	0.1n	0.1n	159.9n	320n)

.meas	tran	delayN	trig	v(a)	val=0.9	rise=1
+						targ	v(out)	val=0.9	rise=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 640n (*sweep 	k 	0.05p  0.5p   0.05p)
.end
