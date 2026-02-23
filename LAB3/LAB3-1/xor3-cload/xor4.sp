2-input xor4 (loading c=0.01p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd



.subckt  inv  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=1u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.5u
.ends

.subckt  invd  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=0.25u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.5u
.ends

.subckt  xor4  a b c d  out
xINV_A a a_  inv
xINV_B b b_  inv
xINV_C c c_	 inv
xINV_D d d_	 invd

*w_left
mp0		l1		a		vdd		vdd		P_18		l=0.18u	w=1u
mp1		l2		a_		vdd		vdd		P_18		l=0.18u	w=1u
mp2		l0		b_		l1		vdd		P_18		l=0.18u	w=1u
mp3		l0		b		l2		vdd		P_18		l=0.18u	w=1u
mpc0	w		c_		l0		vdd		P_18		l=0.18u	w=1u

*w_right
mp4		l4		a_		vdd		vdd		P_18		l=0.18u	w=1u
mp5		l5		a		vdd		vdd		P_18		l=0.18u	w=1u
mp6		l3		b_		l4		vdd		P_18		l=0.18u	w=1u
mp7		l3		b		l5		vdd		P_18		l=0.18u	w=1u
mpc1	w		c		l3		vdd		P_18		l=0.18u	w=1u

mpd0	out		d_		w		vdd		P_18		l=0.18u	w=1u

*X_left
mp8		l9		a_		vdd		vdd		P_18		l=0.18u	w=1u
mp9		l10 	a		vdd		vdd		P_18		l=0.18u	w=1u
mp10	l8		b_		l9		vdd		P_18		l=0.18u	w=1u
mp11	l8		b		l10		vdd		P_18		l=0.18u	w=1u
mpc2	x		c_		l8		vdd		P_18		l=0.18u	w=1u
*X_right
mp12	l12		a		vdd		vdd		P_18		l=0.18u	w=1u
mp13	l13		a_		vdd		vdd		P_18		l=0.18u	w=1u
mp14	l11		b_		l12 	vdd		P_18		l=0.18u	w=1u
mp15	l11		b		l13 	vdd		P_18		l=0.18u	w=1u
mpc3	x		c		l11		vdd		P_18		l=0.18u	w=1u

mpd1	out		d		x		vdd		P_18		l=0.18u	w=1u

*Y_left
mn0		dl0		a_		dl1		gnd		N_18		l=0.18u	w=0.5u
mn1		dl0		a		dl2 	gnd		N_18		l=0.18u	w=0.5u
mn2		dl1		b_		gnd		gnd		N_18		l=0.18u	w=0.5u
mn3		dl2		b		gnd		gnd		N_18		l=0.18u	w=0.5u
mnc0	y		c_		dl0		gnd		N_18		l=0.18u	w=0.5u

*Y_right
mn4		dl3		a		dl4 	gnd		N_18		l=0.18u	w=0.5u
mn5		dl3		a_		dl5 	gnd		N_18		l=0.18u	w=0.5u
mn6		dl4		b_		gnd		gnd		N_18		l=0.18u	w=0.5u
mn7		dl5		b		gnd		gnd		N_18		l=0.18u	w=0.5u
mnc1	y		c		dl3		gnd		N_18		l=0.18u	w=0.5u

mnd0	out		d_		y		gnd		N_18		l=0.18u	w=0.5u

*Z_left
mn8		dl6		a		dl7		gnd		N_18		l=0.18u	w=0.5u
mn9		dl6		a_		dl8 	gnd		N_18		l=0.18u	w=0.5u
mn10	dl7		b_		gnd		gnd		N_18		l=0.18u	w=0.5u
mn11	dl8		b		gnd		gnd		N_18		l=0.18u	w=0.5u
mnc2	z		c_		dl6 	gnd		N_18		l=0.18u	w=0.5u

*Z_right
mn12	dl9		a_		dl10 	gnd		N_18		l=0.18u	w=0.5u
mn13	dl9		a		dl11 	gnd		N_18		l=0.18u	w=0.5u
mn14	dl10	b_		gnd		gnd		N_18		l=0.18u	w=0.5u
mn15	dl11 	b		gnd		gnd		N_18		l=0.18u	w=0.5u
mnc3	z		c		dl9 	gnd		N_18		l=0.18u	w=0.5u

mnd1	out		d		z		gnd		N_18		l=0.18u	w=0.5u

.ends

 


xXOR_1 a b c d out xor4
c1 out gnd k

vvdd	vdd		0		1.8
vgnd	gnd		0		0

vin		in		0		pulse(0	1.8	5n		0.01n	0.01n	2.9n	5n)
va		a		0		pulse(0	1.8	5n		0.01n	0.01n	4.9n	10n)
vb		b		0		pulse(0	1.8	5n		0.01n	0.01n	9.9n	20n)
vc		c		0		pulse(0	1.8	5n		0.01n	0.01n	19.9n	40n)
vd		d		0		pulse(0	1.8	5n		0.01n	0.01n	39.9n	80n)

.meas	tran	delayN	trig	v(b)	val=0.9	rise=1
+						targ	v(out)	val=0.9	fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 100n (sweep 	k 	0.02p  0.3p   0.1p)
.end
