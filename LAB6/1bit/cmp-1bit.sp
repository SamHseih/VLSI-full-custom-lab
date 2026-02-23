2-input inv (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  nand  a b  out
mp0		out		a		vdd		vdd		P_18		l=0.18u	w=1u
mp1		out		b		vdd		vdd		P_18		l=0.18u	w=1u 
mn0		out		a		net		gnd		N_18		l=0.18u	w=1u 
mn1		net		b		gnd		gnd		N_18		l=0.18u	w=1u 
.ends

.subckt  nor  a b  out
mp0		net		a		vdd		vdd		P_18		l=0.18u	w=2u m=10
mp1		out		b		net		vdd		P_18		l=0.18u	w=2u m=10
mn0		out		a		gnd		gnd		N_18		l=0.18u	w=0.5u m=10
mn1		out		b		gnd		gnd		N_18		l=0.18u	w=0.5u m=10
.ends

.subckt  inv  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=1u m=5
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.5u m=5
.ends

xinv A A_ inv
xinv2 B B_ inv

xnand A_ B out_greater_ nand
xnand2 A B_ out_less_ nand
xinv3 out_greater_ out_greater inv
xinv4 out_less_ out_less inv
xnor out_greater out_less out_eq nor

c1 out_greater gnd 0.1p
c2 out_less gnd 0.1p
c3 out_eq gnd 0.1p

vvdd	vdd		0		1.8
vgnd	gnd		0		0


va		A		0		pulse(1.8	0	1n		0.1n	0.1n	2.4n	5n)
vb		B		0		pulse(1.8	0	1n		0.1n	0.1n	4.9n	10n)

.meas	tran	delayeq	trig	v(A)	val=0.9	rise=2
+						targ	v(out_eq)	val=0.9	rise=1

.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.05n 40n (*sweep 	k 	1  10   1)
.end
