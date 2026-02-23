*2-input full-adder (loading c=0.1p)
.option post=2
.prot 
.lib 'cic018.l' tt
.unprot
.global vdd gnd

.subckt  fulladder  a b ci co s
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
mp12	s		s_		vdd		vdd		P_18		l=0.18u	w=2u m=4
mn12	s		s_		gnd	 	gnd		N_18		l=0.18u	w=1u m=4
*co inv
mp13	co		co_		vdd		vdd		P_18		l=0.18u	w=2u
mn13	co		co_		gnd	 	gnd		N_18		l=0.18u	w=1u

.ends

xfad a b ci co sum fulladder
c1 sum gnd 0.1p
c2 co gnd 0.1p

vvdd	vdd		gnd		1.8
vgnd	gnd		gnd		0

*va		a		gnd		pulse(1.8	0		1n		0.1n	0.1n	39.9n	80n)
*vb		b		gnd		pulse(1.8	0		1n		0.1n	0.1n	79.9n	160n)
*vc		ci		gnd		pulse(1.8	0		1n		0.1n	0.1n	159.9n	320n)

Va		a		gnd		1.8v
Vb		b		gnd		0
Vc		ci		0		pulse(1.8	0		1n		0.1n	0.1n	9.9n	20n)
*Vc		ci		gnd		pulse(1.8	0		1n		0.1n	0.1n	9.9n	200n)

.meas	tran	delayTFCo	trig	v(ci)	val=0.9	rise=1
+						targ	v(co)	val=0.9	rise=1

.meas	tran	delayTFSum	trig	v(ci)	val=0.9	rise=1
+						targ	v(sum)	val=0.9	fall=1


.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.05n 400n (sweep 	k 	1  10   0.5)
.end
