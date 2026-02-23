3-input dynamic xnor (loading 0.2p, 0.4ns<delay<0.8ns)

.option post= 2
.prot
.lib '../cic018.l' tt
.unprot
.global vdd gnd


.subckt inv in out
mp0 	out 	in		vdd		vdd		P_18	l=0.18u		w=1u
mn0		out 	in		gnd		gnd		N_18	l=0.18u		w=0.5u
.ends

.subckt xnor		 clk		a	 b		c	out
xinv1	a	a_	inv
xinv2	b	b_	inv
xinv3	c	c_	inv
*xinv4	out	out_	inv4

mp0 	out 	clk		vdd		vdd		P_18		l=0.18u		w=2u 
mn10 	net7 	clk		gnd		gnd		N_18		l=0.18u		w=2u m=2

mn0 	out 	c		net2	gnd		N_18		l=0.18u		w=2u  
mn1 	out 	c_		net1	gnd		N_18		l=0.18u		w=2u  

mn2 	net1 	b		net3	gnd		N_18		l=0.18u		w=2u  
mn3 	net3 	a_		net7	gnd		N_18		l=0.18u		w=2u  
mn4 	net1 	b_		net4	gnd		N_18		l=0.18u		w=2u  
mn5 	net4	a		net7	gnd		N_18		l=0.18u		w=2u  

mn6 	net2 	b		net5	gnd		N_18		l=0.18u		w=2u  
mn7 	net5 	a		net7	gnd		N_18		l=0.18u		w=2u  
mn8 	net2 	b_		net6	gnd		N_18		l=0.18u		w=2u  
mn9 	net6 	a_		net7	gnd		N_18		l=0.18u		w=2u  
.ends

*V<name>  <positive_node>  <negative_node>  <value>
vvdd	vdd		0		1.4v
vgnd	gnd		0		0

xxnor	clk		a2 	a1	a0	out		xnor
c1		out		gnd		0.2p

*pulse init gnd	delay
vclk	clk		0	pulse(1.4	0		0.6n	0.2n	0.2n	2.49n	5n)
va0		a0		0	pulse(1.4	0		0.6n	0.2n	0.2n	4.9n	10n)
va1		a1		0	pulse(1.4	0		0.6n	0.2n	0.2n	9.9n	20n)
va2		a2		0	pulse(1.4	0		0.6n	0.2n	0.2n	19.9n	40n)

.meas	tran	delayT001	trig	v(clk)	val=0.7v	rise=2
+							targ	v(out)	val=0.7v	fall=1
.meas	tran	delayT010	trig	v(clk)	val=0.7v	rise=3
+							targ	v(out)	val=0.7v	fall=2
.meas	tran	delayT100	trig	v(clk)	val=0.7v	rise=5
+							targ	v(out)	val=0.7v	fall=3
.meas	tran	delayT111	trig	v(clk)	val=0.7v	rise=8
+							targ	v(out)	val=0.7v	fall=4

.meas 	tran	pw	avg	power
.meas tran pdp=param('pw*delayN')

.tran	0.1n	60n  *sweep k 1 10 1 
.end