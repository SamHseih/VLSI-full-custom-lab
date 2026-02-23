*2-input full-adder (loading c=0.1p)
.option post=2
.prot 
.lib 'cic018.l' tt
.unprot
.global vdd gnd

.param vdd = 1.8
.param PER = 20n
.param PW = 9.9n

.subckt  fulladder1bit  a b ci co s
*co
mp0		l0		a		vdd		vdd		P_18		l=0.18u	w=6u
mp1		l0		b		vdd		vdd		P_18		l=0.18u	w=4u
mp2		l1		b		l0		vdd		P_18		l=0.18u	w=6u
mp3		co_		a		l1		vdd		P_18		l=0.18u	w=6u
mp4		co_		ci		l0		vdd		P_18		l=0.18u	w=4u
*co
mn0		co_		ci		l2	 	gnd		N_18		l=0.18u	w=2u
mn1		co_		a		l3	 	gnd		N_18		l=0.18u	w=2u
mn2		l2		a		gnd	 	gnd		N_18		l=0.18u	w=2u
mn3		l2		b		gnd	 	gnd		N_18		l=0.18u	w=2u
mn4		l3		b		gnd	 	gnd		N_18		l=0.18u	w=2u


*sum
mp5		net2	ci		vdd		vdd		P_18		l=0.18u	w=4u  *m=k
mp6		net2	a		vdd		vdd		P_18		l=0.18u	w=4u  *m=k
mp7		net2	b		vdd		vdd		P_18		l=0.18u	w=4u  *m=k
mp8		r0		a		net2	vdd		P_18		l=0.18u	w=12u *m=k
mp9		r1		b		r0		vdd		P_18		l=0.18u	w=12u *m=k
mp10	s_		ci		r1		vdd		P_18		l=0.18u	w=12u *m=k
mp11	s_		co_		net2	vdd		P_18		l=0.18u	w=4u  *m=k
*sum
mn5		s_		co_		net3 	gnd		N_18		l=0.18u	w=2u  *m=k
mn6		net3	a		gnd	 	gnd		N_18		l=0.18u	w=2u  *m=k
mn7		net3	b		gnd	 	gnd		N_18		l=0.18u	w=2u  *m=k
mn8		net3	ci		gnd	 	gnd		N_18		l=0.18u	w=2u  *m=k
mn9		s_		ci		r2	 	gnd		N_18		l=0.18u	w=3u  *m=k
mn10	r2		a		r3	 	gnd		N_18		l=0.18u	w=3u  *m=k
mn11	r3		b		gnd	 	gnd		N_18		l=0.18u	w=3u  *m=k

*s inv
mp12	s		s_		vdd		vdd		P_18		l=0.18u	w=2u 
mn12	s		s_		gnd	 	gnd		N_18		l=0.18u	w=1u 
*co inv
mp13	co		co_		vdd		vdd		P_18		l=0.18u	w=2u m=4
mn13	co		co_		gnd	 	gnd		N_18		l=0.18u	w=1u m=4

.ends

xFA0 a0 b0 ci co0 s0 fulladder1bit
xFA1 a1 b1 co0 co1 s1 fulladder1bit
xFA2 a2 b2 co0 co2 s2 fulladder1bit
xFA3 a3 b3 co0 co3 s3 fulladder1bit
xFA4 a4 b4 co0 co4 s4 fulladder1bit
xFA5 a5 b5 co0 co5 s5 fulladder1bit
xFA6 a6 b6 co0 co6 s6 fulladder1bit
xFA7 a7 b7 co0 co7 s7 fulladder1bit

cs0 s0 gnd 0.1p
cs1 s1 gnd 0.1p
cs2 s2 gnd 0.1p
cs3 s3 gnd 0.1p
cs4 s4 gnd 0.1p
cs5 s5 gnd 0.1p
cs6 s6 gnd 0.1p
cs7 s7 gnd 0.1p

vvdd	vdd		gnd		vdd
vgnd	gnd		gnd		0

V0		a0		gnd		vdd
V1		a1		gnd		vdd
V2		a2		gnd		vdd
V3		a3		gnd		vdd
V4		a4		gnd		vdd
V5		a5		gnd		vdd
V6		a6		gnd		vdd
V7		a7		gnd		vdd

V8		b0		gnd		0v
V9		b1		gnd		0v
V10		b2		gnd		0v
V11  	b3		gnd		0v
V12		b4		gnd		0v
V13		b5		gnd		0v
V14		b6		gnd		0v
V15		b7		gnd		0v

Vc		ci		0		pulse(vdd	0		1n		0.1n	0.1n	'PW'	'PER')

.meas	tran	delayCo	trig	v(ci)	val=0.9	rise=1
+						targ	v(co7)	val=0.9	rise=1

.meas	tran	delaySum	trig	v(ci)	val=0.9	rise=1
+						targ	v(s7)	val=0.9	fall=1


.meas tran pw avg power

.meas tran pdp=param('pw*delayN')

.tran 0.5n 8000n (*sweep 	k 	1  10   0.5)


.alter VDD1p6_PER200n
.param vdd=1.6

.alter VDD1p4_PER2000n
.param vdd=1.4

.alter VDD1p2_PER20000n
.param vdd=1.2

.alter VDD1p0_PER20000n
.param vdd=1.0

.alter VDD1p0_8PER20000n
.param vdd=0.8

.alter VDD1p0_6PER20000n
.param vdd=0.6
.param PW=99.9n
.param PER=200n

.alter VDD1p0_4PER20000n
.param vdd=0.4
.param PW=999.9n
.param PER=2000n
.end
