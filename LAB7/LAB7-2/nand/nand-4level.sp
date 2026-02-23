4 level 2-input nand (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=1u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.5u
.ends

*
.subckt  nand  clk a b  out
mp0		out		clk		vdd		vdd		P_18		l=0.18u	w=1u
mn0		out		b		net		gnd		N_18		l=0.18u	w=1u
mn1		net		a		net2	gnd		N_18		l=0.18u	w=1u
mn2		net2	clk		gnd		gnd		N_18		l=0.18u	w=1u
.ends

.subckt  and_for_domino  clk a b  out
mp		out	clk		vdd		vdd		P_18		l=0.18u	w=1u
mkp		out	out		vdd		vdd		P_18		l=0.18u	w=0.5u
mn0		out	b		net		gnd		N_18		l=0.18u	w=1u
mn1		net		a		net2	gnd		N_18		l=0.18u	w=1u
mn2		net2	clk		gnd		gnd		N_18		l=0.18u	w=1u
.ends


*xnand1 clk a b out1 nand_for_domino
*c1 out1 gnd 0.1p
*xnand2 clk c out1 out2 nand_for_domino
*c2 out2 gnd 0.1p
*xnand3 clk d out2 out3 nand_for_domino
*c3 out3 gnd 0.1p
*xnand4 clk e out3 out4 nand_for_domino
*c4 out4 gnd 0.1p

xnand1 clk a b out1_ and_for_domino
c1 out1_ gnd 0.1p
xnand2 clk c out1 out2_ and_for_domino
c2 out2_ gnd 0.1p
xnand3 clk d out2 out3_ and_for_domino
c3 out3_ gnd 0.1p
xnand4 clk e out3 out4_ and_for_domino
c4 out4_ gnd 0.1p

xinv1 out1_ out1 inv
xinv2 out2_ out2 inv
xinv3 out3_ out3 inv
xinv4 out4_ out4 inv


vvdd	vdd		0		1.8
vgnd	gnd		0		0

va		a		0		pulse(1.8	0		0.1n	0.1n	0.1n	9.9n	20n)
vb		b		0		1.8
vc		c		0		1.8
vd		d		0		1.8
ve		e		0		1.8
vclk	clk		0		pulse(0		1.8		2.1n	0.1n	0.1n	1.9n	4n)



.meas	tran	delayN	trig	v(in)	val=0.9	rise=1
+						targ	v(out)	val=0.9	fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 40n *(sweep 	k 	0.5u  1u   0.01u)
.end
