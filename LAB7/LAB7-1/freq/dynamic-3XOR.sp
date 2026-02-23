3 input dynamic XOR(Loading = 0.1p)
.option post=2
.prot
.lib 'cic018.l' tt
.unprot
.global vdd gnd

.param TCLK=80n
.param PWCLK='TCLK/2-0.1n'   * 50% duty
.param PWCLK='TCLK/2-0.1n'   * 50% duty

vvdd	vdd		0		1.8
vgnd	gnd		0		0

.subckt  inv  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=2u
mn		out		in		gnd		gnd		N_18		l=0.18u	w=1u
.ends

.subckt  xor3 clk a b c out
xINV_A a a_  inv
xINV_B b b_  inv
xINV_C c c_  inv

mp0		out		clk		vdd 	vdd		P_18		l=0.18u	w=2u

mn0		out		a_		net0	gnd		N_18		l=0.18u	w=4u
mn1		net0	b		net1	gnd		N_18		l=0.18u	w=4u
mn2		net1	c		net_d	gnd		N_18		l=0.18u	w=4u
mn3		out		a_		net2	gnd		N_18		l=0.18u	w=4u
mn4		net2	b_		net3	gnd		N_18		l=0.18u	w=4u
mn5		net3 	c_		net_d 	gnd		N_18		l=0.18u	w=4u
mn6		out 	a		net4	gnd		N_18		l=0.18u	w=4u
mn7		net4	b		net5	gnd		N_18		l=0.18u	w=4u
mn8		net5	c_		net_d	gnd		N_18		l=0.18u	w=4u
mn9		out 	a		net6	gnd		N_18		l=0.18u	w=4u
mn10	net6	b_		net7	gnd		N_18		l=0.18u	w=4u
mn11	net7	c		net_d	gnd		N_18		l=0.18u	w=4u
mn12	net_d	clk		gnd		gnd		N_18		l=0.18u	w=4u
.ends


xXOR_1 clk a b c out xor3
c1 out gnd 0.1p

*name signal init pulse(脈衝) ( 0(起始點) 1.8(最高點) 5n(開始延遲的時間)  0.01n(切換的時間) 0.01n 2.49n(在輸入1的時間) 5n(週期))
vclk	clk		0		pulse(0		1.8		0.1n	0.1n	0.1n	'PWCLK'	'TCLK')

*low clk in t = (80n/2 ~ 80n)/2 ns
va		a		0		0
vb		b		0		0
vc		c		0		0

.meas	tran	delayN	trig	v(clk)	val=0.9	rise=1
+						targ	v(out)	val=0.9	fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 500n

.alter FREQ_2X
.param TCLK=40n

.alter FREQ_4X
.param TCLK=20n

.alter FREQ_8X
.param TCLK=10n
.end

