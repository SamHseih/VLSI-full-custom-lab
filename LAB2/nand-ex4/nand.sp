2-input nand (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  
  a b  out
mp0		out		b		vdd		vdd		P_18		l=0.18u	w=2u
mp1		out		a		vdd		vdd		P_18		l=0.18u	w=2u
mn0		out		b		net		gnd		N_18		l=0.18u	w=2u
mn1		net		a		gnd		gnd		N_18		l=0.18u	w=2u
.ends

xc a b out1 nand
xd c out1 out2 nand
xe d out2 out3 nand
xf e out3 out4 nand

c1 out1 gnd 0.02p
c2 out2 gnd 0.02p
c3 out3 gnd 0.02p
c4 out4 gnd 0.02p

vvdd	vdd		0		1.8
vgnd	gnd		0		0


va		a		0		pulse(1.8	0	0.1n		0.1n	0.1n	9.9n	20n)
vb		b		0		1.8v
vc		c		0		1.8v
vd		d		0		1.8v
ve		e		0		1.8v
vf		f		0		1.8v

.meas	tran	delayN0	trig	v(a)	val=0.9	rise=1
+						targ	v(out1)	val=0.9	fall=1
.meas	tran	delayN1	trig	v(a)	val=0.9	rise=1
+						targ	v(out2)	val=0.9	rise=1
.meas	tran	delayN2	trig	v(a)	val=0.9	rise=1
+						targ	v(out3)	val=0.9	fall=1
.meas	tran	delayN3	trig	v(a)	val=0.9	rise=1
+						targ	v(out4)	val=0.9	rise=1


.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 80n *(sweep k 	0.02p  0.3p   0.1p)
.end
