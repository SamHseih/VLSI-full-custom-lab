2-input and dynamic (loading c=0.1p)
.option post=2
.prot 
.lib  'cic018.l' tt
.unprot
.global vdd gnd

.subckt  inv  in  out
mp		out		in		vdd		vdd		P_18		l=0.18u	w=1u  
mn		out		in		gnd		gnd		N_18		l=0.18u	w=0.5u 
.ends

.subckt  dyn_and2  a  b  clk  out_final
mp_pre  dyn_node  clk  vdd  vdd  P_18  W=2u  L=0.18u
* --- Keeper Circuit ---
* 1. Static Inverter (Output Driver)
xinv1 dyn_node out_final inv    

* 2. Keeper PMOS (Feedback)
* Gate 接 out_final (Inverter 的輸出), Drain 接 dyn_node
Mp_keep dyn_node  out_final vdd  vdd  P_18  W=0.5u L=0.18u

* --- Pull-Down Network (Logic Stack) ---
* 堆疊順序: dyn_node -> A -> B -> Node X -> B -> A -> Footer
* 1. Top NMOS (Gate A)
Mn_A_top  dyn_node  a    n1   gnd    N_18  W=1u   L=0.18u
* 2. Second NMOS (Gate B)
Mn_B_top  n1        b    x    gnd    N_18  W=1u   L=0.18u
* --- Node X (Feedback Point) ---
* 3. Third NMOS (Gate B)
Mn_B_bot  x         b    n2   gnd    N_18  W=1u   L=0.18u
* 4. Bottom NMOS (Gate A)
Mn_A_bot  n2        a    n_foot gnd  N_18  W=1u   L=0.18u
* --- Footer Transistor ---
Mn_foot   n_foot    clk  gnd    gnd    N_18  W=2u   L=0.18u

* --- Transistor M1 (Feedback Discharger) ---
* Gate: 接到節點 X
* Drain: 接到動態節點 (dyn_node)
* Source: 接地
M1  x  dyn_node  vss    gnd    N_18  W=1u   L=0.18u
.ends

x1 a b clk intermed dyn_and2
c1 dyn_and2 gnd 0.1p


vvdd	vdd		0		1.8
vgnd	gnd		0		0

va		a		0		pulse(1.8	0		0.1n	0.1n	0.1n	9.9n	20n)
vb		b		0		pulse(1.8	0		0.1n	0.1n	0.1n	19.9n	40n)
vclk	clk		0		pulse(0		1.8		2.1n	0.1n	0.1n	1.9n	4n)



*.meas	tran	delayN	trig	v(in)	val=0.9	rise=1
*+						targ	v(out)	val=0.9	fall=1
.meas tran pw avg power

.meas tran pdp=param('pw*delayN')


.tran 0.1n 40n (sweep 	k 	1  10   1) 
.end
