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
Mp_pre  dyn_node clk vdd vdd P_18 W=2u L=0.18u
* --- Keeper Logic ---
* 呼叫您定義的 Inverter (Input: dyn_node -> Output: out)
Xinv    dyn_node out inv

* Keeper PMOS (Feedback)
* Gate 接到 out, Drain 接回 dyn_node (維持高電位用)
Mp_keep dyn_node out vdd vdd P_18 W=0.5u L=0.18u

* [區塊 A] (Top)
* 主電晶體 A
Mn_A_main dyn_node a mid_node gnd N_18 W=1u L=0.18u
* 電晶體 m2 (與 A 並聯，根據圖片 a2)
Mn_m2    a dyn_node mid_node gnd N_18 W=1u L=0.18u

* [區塊 B] (Bottom)
* 主電晶體 B
Mn_B_main mid_node b n_foot   gnd N_18 W=1u L=0.18u
* 電晶體 m3 (與 B 並聯，根據圖片 a2)
Mn_m3    b mid_node n_foot   gnd N_18 W=1u L=0.18u
* --- Footer Transistor ---
Mn_foot   n_foot   clk gnd    gnd N_18 W=2u L=0.18u
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
