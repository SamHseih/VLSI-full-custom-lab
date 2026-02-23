3-input dynamic xnor (loading 0.2p, 0.4ns<delay<0.8ns)

.option post= 2
.prot
.lib '../cic018.l' tt
.unprot
.global vdd gnd


.subckt inv in out
mp0 	out 	in		vdd		vdd		P_18	l=0.18u		w=2u
mn0		out 	in		gnd		gnd		N_18	l=0.18u		w=1u
.ends

.subckt xnor	a	 b		c	out
xinv1	a	a_	inv
xinv2	b	b_	inv
xinv3	c	c_	inv

mp0 	out 	gnd		vdd		vdd		P_18		l=0.18u		w=1.5u 

mn0 	out 	c		net2	gnd		N_18		l=0.18u		w=2.5u
mn1 	out 	c_		net1	gnd		N_18		l=0.18u		w=2.5u
*010
mn2 	net1 	b		net3	gnd		N_18		l=0.18u		w=2u  
mn3 	net3 	a_		gnd		gnd		N_18		l=0.18u		w=2.5u  
*001
mn4 	net1 	b_		net4	gnd		N_18		l=0.18u		w=2u  
mn5 	net4	a		gnd		gnd		N_18		l=0.18u		w=2.5u  																 
*111
mn6 	net2 	b		net5	gnd		N_18		l=0.18u		w=2u  
mn7 	net5 	a		gnd		gnd		N_18		l=0.18u		w=2.5u
*100
mn8 	net2 	b_		net6	gnd		N_18		l=0.18u		w=2u  
mn9 	net6 	a_		gnd		gnd		N_18		l=0.18u		w=2.5u
.ends

*V<name>  <positive_node>  <negative_node>  <value>
vvdd	vdd		0		1.4v
vgnd	gnd		0		0

xxnor	a0 	a1	a2	out		xnor
c1		out		gnd		0.2p

*pulse init gnd	delay
*bit-counter  pattern 
*vclk	clk		0	pulse(1.4	0		0.6n	0.2n	0.2n	2.49n	5n)
*va0		a0		0	pulse(1.4	0		0.6n	0.2n	0.2n	4.9n	10n)
*va1		a1		0	pulse(1.4	0		0.6n	0.2n	0.2n	9.9n	20n)
*va2		a2		0	pulse(1.4	0		0.6n	0.2n	0.2n	19.9n	40n)
*gray code patten
va0    a0    0  pulse(0 	1.4 	5.3n 	0.2n 	0.2n	9.9n 20n)
va1    a1    0  pulse(0 	1.4 	10.3n 	0.2n 	0.2n 	19.9n 40n)
va2    a2    0  pulse(0 	1.4 	20.3n 	0.2n 	0.2n 	19.9n 40n)

.meas	tran	delayT001	trig	v(a0)	val=0.7v	rise=1
+							targ	v(out)	val=0.7v	fall=1

.meas	tran	delayT010	trig	v(a0)	val=0.7v	fall=1
+							targ	v(out)	val=0.7v	fall=2

.meas	tran	delayT111	trig	v(a0)	val=0.7v	rise=2
+							targ	v(out)	val=0.7v	fall=3

.meas	tran	delayT100	trig	v(a0)	val=0.7v	fall=2	
+							targ	v(out)	val=0.7v	fall=4




.meas 	tran	pw	avg	power
.meas tran pdp=param('pw*delayN')

.tran	0.1n	60n  *sweep k 1 10 1 
.end