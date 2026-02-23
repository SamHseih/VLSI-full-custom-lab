3-input xor (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd


.subckt  inv  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=1u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.5u
.ends

.subckt  xor3  a b c out
xINV_A a a_  inv
xINV_B b b_  inv
xINV_C c c_  inv
mp0		net2	a		vdd		vdd		P_18		l=0.18u	w=1u
mp1		net3	a_		vdd		vdd		P_18		l=0.18u	w=1u
mp2		net4	b		net2	vdd		P_18		l=0.18u	w=1u
mp3		net4	b_		net3	vdd		P_18		l=0.18u	w=1u
mp4		out		c_		net4	vdd		P_18		l=0.18u	w=1u

mp5		net9	a		vdd		vdd		P_18		l=0.18u	w=1u
mp6		net10	a_		vdd		vdd		P_18		l=0.18u	w=1u
mp7		net11	b_		net9	vdd		P_18		l=0.18u	w=1u
mp8		net11	b		net10	vdd		P_18		l=0.18u	w=1u
mp9		out		c		net11	vdd		P_18		l=0.18u	w=1u

mn0		net5	b		net0	gnd		N_18		l=0.18u	w=0.5u
mn1		net5	b_		net1	gnd		N_18		l=0.18u	w=0.5u
mn2		net0	a_		gnd		gnd		N_18		l=0.18u	w=0.5u
mn3		net1	a		gnd		gnd		N_18		l=0.18u	w=0.5u
mn4		out		c		net5	gnd		N_18		l=0.18u	w=0.5u

mn5		out 	c_		net8	gnd		N_18		l=0.18u	w=0.5u
mn6		net8	b		net6	gnd		N_18		l=0.18u	w=0.5u
mn7		net8	b_		net7	gnd		N_18		l=0.18u	w=0.5u
mn8		net6	a		gnd		gnd		N_18		l=0.18u	w=0.5u
mn9		net7	a_		gnd 	gnd		N_18		l=0.18u	w=0.5u
.ends

 


xXOR_1 a b c out xor3
c1 out gnd 0.02p

vvdd	vdd		0		1.8
vgnd	gnd		0		0

*(pulse脈衝 0(起始點) 1.8(最高點) 5n(開始延遲的時間)  0.01n(切換的時間) 0.01n 2.49n(在輸入1的時間) 5n(週期))
va		a		0		pulse(1.8	0	0.1n	0.1n	0.1n	4.9n	10n)
vb		b		0		pulse(1.8	0	0.1n	0.1n	0.1n	9.9n	20n)
vc		c		0		pulse(1.8	0	0.1n	0.1n	0.1n	19.9n	40n)

.meas	tran	delayN	trig	v(a)	val=0.9	rise=1
+						targ	v(out)	val=0.9	rise=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 640n (*sweep 	k 	0.02p  0.3p   0.1p)
.end
