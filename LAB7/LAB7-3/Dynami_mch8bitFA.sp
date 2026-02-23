8-input Dynamic Manchester Carry-Generation Chain(Loading 0.05p@C0~C7)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=1u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.5u
.ends

.subckt  xor1  a b  out
xINV_A a a_  inv
xINV_B b b_  inv
mp0		net2	a		vdd		vdd		P_18		l=0.18u	w=1u
mp1		net3	a_		vdd		vdd		P_18		l=0.18u	w=1u
mp2		out		b_		net2	vdd		P_18		l=0.18u	w=1u
mp3		out		b		net3	vdd		P_18		l=0.18u	w=1u

mn0		out		a_		net0	gnd		N_18		l=0.18u	w=0.5u
mn1		out		a		net1	gnd		N_18		l=0.18u	w=0.5u
mn2		net0	b_		gnd		gnd		N_18		l=0.18u	w=0.5u
mn3		net1	b		gnd		gnd		N_18		l=0.18u	w=0.5u
.ends

.subckt  nand2  a b  out
mp0		out		a		vdd		vdd		P_18		l=0.18u	w=2u
mp1		out		b		vdd		vdd		P_18		l=0.18u	w=2u
mn0		out		a		net		gnd		N_18		l=0.18u	w=2u
mn1		net		b		gnd		gnd		N_18		l=0.18u	w=2u
.ends

.subckt  nand1  a b  out
mp0		out		a		vdd		vdd		P_18		l=0.18u	w=1u
mp1		out		b		vdd		vdd		P_18		l=0.18u	w=1u
mn0		out		a		net		gnd		N_18		l=0.18u	w=1u
mn1		net		b		gnd		gnd		N_18		l=0.18u	w=1u
.ends

.subckt  manch_stage  clk ci_ pi gi  	co_
mp0		co_		clk		vdd		vdd		P_18		l=0.18u	w=1u
mn0		co_		pi		ci_		gnd		N_18		l=0.18u	w=1u
mn1		co_		gi		net		gnd		N_18		l=0.18u	w=1u
mn2		net		clk		gnd		gnd		N_18		l=0.18u	w=1u
.ends

xg0_ a 	b  g0_ nand1
xg1_ a1 b1 g1_ nand1
xg2_ a2 b2 g2_ nand1
xg3_ a3 b3 g3_ nand1
xg4_ a4 b4 g4_ nand1
xg5_ a5 b5 g5_ nand1
xg6_ a6 b6 g6_ nand1
xg7_ a7 b7 g7_ nand1

xg0  	g0_ 	g0		inv
xg1 	g1_ 	g1		inv
xg2 	g2_ 	g2 		inv
xg3		g3_ 	g3 		inv
xg4 	g4_ 	g4 		inv
xg5 	g5_ 	g5		inv
xg6 	g6_ 	g6 		inv
xg7 	g7_		g7 		inv

xp0 	a 		b 		p0 		xor1
xp1 	a1 		b1 		p1 		xor1
xp2 	a2 		b2 		p2 		xor1
xp3 	a3 		b3 		p3 		xor1
xp4 	a4 		b4 		p4 		xor1
xp5 	a5 		b5 		p5 		xor1
xp6 	a6 		b6 		p6 		xor1
xp7 	a7 		b7 		p7 		xor1

xci_ ci ci_ inv
xstage0  clk ci_  p0 g0 co0_  manch_stage
xstage1  clk co0_ p1 g1 co1_  manch_stage
xstage2  clk co1_ p2 g2 co2_  manch_stage
xstage3  clk co2_ p3 g3 co3_  manch_stage
xstage4  clk co3_ p4 g4 co4_  manch_stage
xstage5  clk co4_ p5 g5 co5_  manch_stage
xstage6  clk co5_ p6 g6 co6_  manch_stage
xstage7  clk co6_ p7 g7 co7_  manch_stage

xco0 co0_ co0 inv
xco1 co1_ co1 inv
xco2 co2_ co2 inv
xco3 co3_ co3 inv
xco4 co4_ co4 inv
xco5 co5_ co5 inv
xco6 co6_ co6 inv
xco7 co7_ co7 inv

c0 co0 gnd 0.05p
c1 co1 gnd 0.05p
c2 co2 gnd 0.05p
c3 co3 gnd 0.05p
c4 co4 gnd 0.05p
c5 co5 gnd 0.05p
c6 co6 gnd 0.05p
c7 co7 gnd 0.05p

vvdd	vdd		0		1.8
vgnd	gnd		0		0

vclk	clk		gnd		pulse(0		1.8		2.1n	0.1n	0.1n	1.9n	4n)
va		a		gnd		pulse(1.8	0	1n	0.1n	0.1n	3.9n	8n)
vb		b		0		pulse(1.8	0	1n	0.1n	0.1n	7.9n	16n)
vci		ci		gnd		0

*PWL 使用方法 [n time + nV]*
va1		a1		gnd		pulse(1.8	0	1n	0.1n	0.1n	15.9n	32n)
vb1		b1		gnd		pulse(1.8	0	1n	0.1n	0.1n	31.9n	64n)

va2		a2		gnd		pulse(1.8	0	1n	0.1n	0.1n	63.9n	128n)
vb2		b2		gnd		pulse(1.8	0	1n	0.1n	0.1n	127.9n	256n)

va3		a3		gnd		PWL(0n 0 21n 0  21.1n 1.8)
vb3		b3		gnd		PWL(0n 1.8 49n 1.8  49.1n 0)

va4		a4		gnd		PWL(0n 0 21n 0  21.1n 1.8)
vb4		b4		gnd		PWL(0n 1.8 100n 1.8  100.1n 0)

va5		a5		gnd		PWL(0n 0 21n 0  21.1n 1.8)
vb5		b5		gnd		PWL(0n 1.8 100n 1.8  100.1n 0)

va6		a6		gnd		PWL(0n 0 21n 0  21.1n 1.8)
vb6		b6		gnd		PWL(0n 1.8 100n 1.8  100.1n 0)

va7		a7		gnd		PWL(0n 0 21n 0  21.1n 1.8)
vb7		b7		gnd		PWL(0n 1.8 100n 1.8  100.1n 0)

.meas	tran	delayN	trig	v(in)	val=0.9	rise=1
+						targ	v(out)	val=0.9	fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 200n *(sweep 	k 	0.5u  1u   0.01u)
.end
