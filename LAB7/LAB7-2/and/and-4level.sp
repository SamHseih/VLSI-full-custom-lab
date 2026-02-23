4 level 2-input and (loading c=0.1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=1u  
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.5u 
.ends

.subckt  and  clk a b  out
xinv	out_	out		inv
mp		out_	clk		vdd		vdd		P_18		l=0.18u	w=1u   
mkp		out_	out		vdd		vdd		P_18		l=0.18u	w=0.5u  															   
mn0		out_	b		net		gnd		N_18		l=0.18u	w=1u   
mn1		net		a		net2	gnd		N_18		l=0.18u	w=1u   
mn2		net2	clk		gnd		gnd		N_18		l=0.18u	w=1u   
.ends

xand1 clk a b out1 and
c1 out1 gnd 0.1p

xand2 clk c out1 out2 and
c2 out2 gnd 0.1p

xand3 clk d out2 out3 and
c3 out3 gnd 0.1p

xand4 clk e out3 out4 and
c4 out4 gnd 0.1p


vvdd	vdd		0		1.8
vgnd	gnd		0		0

va		a		0		pulse(1.8	0		0.1n	0.1n	0.1n	9.9n	20n)
vb		b		0		1.8
vc		c		0		1.8
vd		d		0		1.8
ve		e		0		1.8
vclk	clk		0		pulse(0		1.8		2.1n	0.1n	0.1n	1.9n	4n)



*.meas	tran	delayN	trig	v(in)	val=0.9	rise=1
*+						targ	v(out)	val=0.9	fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 40n (sweep 	k 	1  10   1) 
.end
