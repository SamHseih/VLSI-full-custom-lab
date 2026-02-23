2-input nand4 (loading c=0.01p)
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

 


xnand a b c d out nand4


vvdd	vdd		0		1.8
vgnd	gnd		0		0


vin		in		0		pulse(0	1.8	5n		0.01n	0.01n	4.9n	5n)
va		a		0		pulse(0	1.8	5n		0.01n	0.01n	4.9n	10n)
vb		b		0		pulse(0	1.8	5n		0.01n	0.01n	9.9n	20n)
vc		c		0		pulse(0	1.8	5n		0.01n	0.01n	19.9n	40n)
vd		d		0		pulse(0	1.8	5n		0.01n	0.01n	39.9n	80n)

.tran 0.1n 80n

.meas	tran	delayN	trig	v(in)	val=0.9	rise=1
+						targ	v(out)	val=0.9	fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 50n *(sweep 	k 	0.3u  5u   0.1u)
.end
