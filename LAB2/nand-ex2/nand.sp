2-input nand (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  nand4  a b c d  out
mp0		out		a		vdd		vdd		P_18		l=0.18u	w=1u
mp1		out		b		vdd		vdd		P_18		l=0.18u	w=1u
mp3		out		c		vdd		vdd		P_18		l=0.18u	w=1u
mp4		out		d		vdd		vdd		P_18		l=0.18u	w=1u

mn0		out		a		net0	gnd		N_18		l=0.18u	w=2u
mn1		net0	b		net1	gnd		N_18		l=0.18u	w=2u
mn3		net1	c		net2	gnd		N_18		l=0.18u	w=2u
mn4		net2	d		gnd		gnd		N_18		l=0.18u	w=2u
.ends


xnand4 a b c d out1 nand4
c1 out1 gnd k


vvdd	vdd		0		1.8
vgnd	gnd		0		0


va		d		0		pulse(1.8	0	0.1n		0.1n	0.1n	9.9n	20n)
vb		b		0		1.8v
vc		c		0		1.8v
vd		a		0		1.8v

.meas	tran	delayN0	trig	v(d)	val=0.9	rise=1
+						targ	v(out1)	val=0.9	fall=1



.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 80n (sweep k 	0.02p  0.3p   0.1p)
.end
