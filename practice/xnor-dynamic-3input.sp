3-input dynamic xnor (loading 0.2p, 0.4ns<delay<0.8ns)

.option = 2
.prot
.lib  'cic018.l' tt
.unprot
.global vdd gnd


.subcircuit inv in out
mp0 	out 	in		vdd		vdd		P_18	l=0.18u		w=1u
mn0		out 	in		gnd		gnd		P_18	l=0.18u		w=0.5u
.ends

.subcircuit xor		 clk		a	 b		c		out
xinv1	a	a_	inv
xinv2	b	b_	inv
mp0 	out 	clk		vdd		gnd		P_18		l=0.18u		w=1u
mn10 	net7 	clk		gnd		gnd		N_18		l=0.18u		w=1.5u
mn0 	out 	c		net1	gnd		N_18		l=0.18u		w=1.5u
mn1 	out 	c_		net2	gnd		N_18		l=0.18u		w=1.5u
mn2 	net1 	a_		net3	gnd		N_18		l=0.18u		w=1.5u
mn3 	net3 	b		gnd		gnd		N_18		l=0.18u		w=1.5u
mn4 	net1 	a		net4	gnd		N_18		l=0.18u		w=1.5u
mn5 	net4	b_		gnd		gnd		N_18		l=0.18u		w=1.5u
mn6 	net2 	a		net5	gnd		N_18		l=0.18u		w=1.5u
mn7 	net2 	b		gnd		gnd		N_18		l=0.18u		w=1.5u
mn8 	net5 	a_		net6	gnd		N_18		l=0.18u		w=1.5u
mn9 	net6 	b_		gnd		gnd		N_18		l=0.18u		w=1.5u
.ends

vvdd	1.4v 	vdd
vgnd	0		gnd

xxor	clk		a 	b	c	out		xor
c1		out		gnd		0.2p

va	a	0	pulse(1.8	0	0.2n	0.2n	0.1n	4.9n	10n)
vb	b	0	pulse(1.8	0	0.2n	0.2n	0.1n	9.9n	20n)
vb	b	0	pulse(1.8	0	0.2n	0.2n	0.1n	19.9n	40n)

.tran	0.1n	60n
.end