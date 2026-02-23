2-input nand (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  nand  a b  out
mp0		out		b		vdd		vdd		P_18		l=0.18u	w=1u
mp1		out		a		vdd		vdd		P_18		l=0.18u	w=1u
mn0		out		b		net		gnd		N_18		l=0.18u	w=1u
mn1		net		a		gnd		gnd		N_18		l=0.18u	w=1u
.ends

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

.subckt  nand6  a b c d e f  out
* PMOS network: parallel
mp0     out     a       vdd     vdd     P_18    l=0.18u w=1u
mp1     out     b       vdd     vdd     P_18    l=0.18u w=1u
mp2     out     c       vdd     vdd     P_18    l=0.18u w=1u
mp3     out     d       vdd     vdd     P_18    l=0.18u w=1u
mp4     out     e       vdd     vdd     P_18    l=0.18u w=1u
mp5     out     f       vdd     vdd     P_18    l=0.18u w=1u

* NMOS network: series
mn0     out     a       net0    gnd     N_18    l=0.18u w=2u
mn1     net0    b       net1    gnd     N_18    l=0.18u w=2u
mn2     net1    c       net2    gnd     N_18    l=0.18u w=2u
mn3     net2    d       net3    gnd     N_18    l=0.18u w=2u
mn4     net3    e       net4    gnd     N_18    l=0.18u w=2u
mn5     net4    f       gnd     gnd     N_18    l=0.18u w=2u
.ends

.subckt  nand8  a b c d e f g h  out
* PMOS network: parallel
mp0     out     a       vdd     vdd     P_18    l=0.18u w=1u
mp1     out     b       vdd     vdd     P_18    l=0.18u w=1u
mp2     out     c       vdd     vdd     P_18    l=0.18u w=1u
mp3     out     d       vdd     vdd     P_18    l=0.18u w=1u
mp4     out     e       vdd     vdd     P_18    l=0.18u w=1u
mp5     out     f       vdd     vdd     P_18    l=0.18u w=1u
mp6     out     g       vdd     vdd     P_18    l=0.18u w=1u
mp7     out     h       vdd     vdd     P_18    l=0.18u w=1u

* NMOS network: series
mn0     out     a       net0    gnd     N_18    l=0.18u w=2u
mn1     net0    b       net1    gnd     N_18    l=0.18u w=2u
mn2     net1    c       net2    gnd     N_18    l=0.18u w=2u
mn3     net2    d       net3    gnd     N_18    l=0.18u w=2u
mn4     net3    e       net4    gnd     N_18    l=0.18u w=2u
mn5     net4    f       net5    gnd     N_18    l=0.18u w=2u
mn6     net5    g       net6    gnd     N_18    l=0.18u w=2u
mn7     net6    h       gnd     gnd     N_18    l=0.18u w=2u
.ends

xnand a b out0 nand
c1 out0 gnd 0.05p

xnand4 a b c d out1 nand4
c2 out1 gnd 0.05p

xnand6 a b c d e f out2 nand6
c3 out2 gnd 0.05p

xnand8 a b c d e f g h out3 nand8
c4 out3 gnd 0.05p

vvdd	vdd		0		1.8
vgnd	gnd		0		0


va		a		0		pulse(1.8	0	0.1n		0.1n	0.1n	9.9n	20n)
vb		b		0		1.8v
vc		c		0		1.8v
vd		d		0		1.8v
ve		e		0		1.8v
vf		f		0		1.8v
vg		g		0		1.8v
vh		h		0		1.8v

*va		a		0		pulse(0	1.8	5n		0.01n	0.01n	4.9n	10n)
*vb		b		0		pulse(0	1.8	5n		0.01n	0.01n	9.9n	20n)
*vc		c		0		pulse(0	1.8	5n		0.01n	0.01n	19.9n	40n)
*vd		d		0		pulse(0	1.8	5n		0.01n	0.01n	39.9n	80n)
*ve		e		0		pulse(0	1.8	5n		0.01n	0.01n	89.9n	160n)
*vf		f		0		pulse(0	1.8	5n		0.01n	0.01n	159.9n	320n)
*vg		g		0		pulse(0	1.8	5n		0.01n	0.01n	319.9n	640n)
*vh		h		0		pulse(0	1.8	5n		0.01n	0.01n	639.9n	1280n)

.meas	tran	delayN0	trig	v(a)	val=0.9	rise=1
+						targ	v(out0)	val=0.9	fall=1

.meas	tran	delayN1	trig	v(d)	val=0.9	rise=1
+						targ	v(out1)	val=0.9	fall=1

.meas	tran	delayN2	trig	v(f)	val=0.9	rise=1
+						targ	v(out2)	val=0.9	fall=1

.meas	tran	delayN3	trig	v(h)	val=0.9	rise=1
+						targ	v(out3)	val=0.9	fall=1




.meas tran pw avg power


.meas tran pdp=param('pw*delayN')


.tran 0.1n 1500n *(sweep 	k 	0.3u  5u   0.1u)
.end
