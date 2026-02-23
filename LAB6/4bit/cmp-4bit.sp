l2-input cmp (loading c=0.01p)
.option post=2
.prot
.lib  'cic018.l' tt
.unprot
.global vdd gnd

vvdd	vdd		0		1.8
vgnd	gnd		0		0

.subckt  nand  a b  out
mp0		out		a		vdd		vdd		P_18		l=0.18u	w=1u
mp1		out		b		vdd		vdd		P_18		l=0.18u	w=1u
mn0		out		a		net		gnd		N_18		l=0.18u	w=1u
mn1		net		b		gnd		gnd		N_18		l=0.18u	w=1u
.ends

.subckt  nor  a b  out
mp0		net		a		vdd		vdd		P_18		l=0.18u	w=2u
mp1		out		b		net		vdd		P_18		l=0.18u	w=2u
mn0		out		a		gnd		gnd		N_18		l=0.18u	w=0.5u
mn1		out		b		gnd		gnd		N_18		l=0.18u	w=0.5u
.ends

.subckt  inv  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=1u  m=3
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.5u m=3
.ends

.subckt cmp_2bit a1 a0 b1 b0 out_less out_equall out_greater
*1
xinv1 a0 a0_ inv
xinv2 a1 a1_ inv
xinv3 b0 b0_ inv
xinv4 b1 b1_ inv
*2
xc1 a1_ b1 c1_nor nor
xc2 a1_ b1 c2_nand nand
xc3 a0_ b0 c3_nand nand
xd2 a1 b1_ d2_nand nand
xd3 a0 b0_ d3_nand nand
xd1 b1_ a1 d1_nor nor
*4
xc4 c1_nor c3_nand c4_nor nor
xd4 d3_nand d1_nor d4_nor nor
xinv6 c4_nor c4_or inv
xinv7 d4_nor d4_or inv
*5
xc5 c4_or c2_nand out_less nand
xd5 d2_nand d4_or out_greater nand
*final
xe1 out_greater out_less out_equall nor
.ends

xcmp2_1 a3 a2 b3 b2 u_less u_eq u_gre cmp_2bit
xcmp2_2 a1 a0 b1 b0 d_less d_eq d_gre cmp_2bit

xf1_ u_eq d_less f1_nand nand
xf2_ u_eq d_gre f2_nand nand
xf1 f1_nand f1_and inv
xf2 f2_nand f2_and inv
xf3_ u_less f1_and f3_less_ nor
xf3 f3_less_ out_less inv
xf4_ u_eq d_eq f4_eq_ nand
xf4 f4_eq_ out_eq inv
xf5_ u_gre f2_and f5_gre_ nor
xf5 f5_gre_ out_gre inv

c1 out_gre gnd 0.1p
c2 out_less gnd 0.1p
c3 out_eq gnd 0.1p

Va0		a0		0		pulse(1.8	0	1n		0.1n	0.1n	4.9n	10n)
Va1		a1		0		pulse(1.8	0	1n		0.1n	0.1n	9.9n	20n)
Va2		a2		0		pulse(1.8	0	1n		0.1n	0.1n	19.9n	40n)
Va3		a3		0		pulse(1.8	0	1n		0.1n	0.1n	39.9n	80n)


Vb0		b0		0		pulse(1.8	0	1n		0.1n	0.1n	79.9n	160n)
vb1		b1		0		pulse(1.8	0	1n		0.1n	0.1n	159.9n	320n)
vb2		b2		0		pulse(1.8	0	1n		0.1n	0.1n	319.9n	640n)
vb3		b3		0		pulse(1.8	0	1n		0.1n	0.1n	639.9n	1280n)



.meas	tran	delayeq	trig	v(a0)	val=0.9	rise=9
+						targ	v(out_eq)	val=0.9	rise=1

.meas tran pw avg power

.meas tran pdp=param('pw*delayeq')


.tran 0.05n 2000n (*sweep 	k 	1  10   1)
.end
