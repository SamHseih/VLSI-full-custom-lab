2-input xor (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd


.subckt  inv  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=1u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.5u
.ends

.subckt  xor  a b  out
xINV_A a a_  inv
xINV_B b b_  inv
mp0		net2	a		vdd		vdd		P_18		l=0.18u	w=1u
mp1		net3	a_		vdd		vdd		P_18		l=0.18u	w=1u
mp2		out		b_		net2	vdd		P_18		l=0.18u	w=1u
mp3		out		b		net3	vdd		P_18		l=0.18u	w=1u

mn0		out		a_		net0	gnd		N_18		l=0.18u	w=0.5u
mn1		out		a		net1	gnd		N_18		l=0.18u	w=0.5u
mn2		net0	b_		gnd		gnd		N_18		l=0.18u	w=0.5u
mn3		net1	b		gnd		gnd		N_18		l=0.18u	w=0.5u
.ends

 


xXOR_1 a b out xor
c1 out gnd k

vvdd	vdd		0		1.8
vgnd	gnd		0		0

va		a		0		pulse(0	1.8	5n		0.01n	0.01n	4.99n	10n)
vb		b		0		pulse(0	1.8	5n		0.01n	0.01n	9.99n	20n)

.meas	tran	delayN	trig	v(b)	val=0.9	rise=1
+						targ	v(out)	val=0.9	fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 50n (sweep 	k 	0.02p  0.3p   0.1p)
.end
