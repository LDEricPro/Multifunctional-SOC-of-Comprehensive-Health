
d
Command: %s
53*	vivadotcl23
route_design -directive Explore2default:defaultZ4-113h px? 
?
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-347h px? 
?
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xc7a100t2default:defaultZ17-349h px? 
p
,Running DRC as a precondition to command %s
22*	vivadotcl2 
route_design2default:defaultZ4-22h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
?
?Clock Placer Checks: Poor placement for routing between an IO pin and BUFG. 
Resolution: Poor placement of an IO pin and a BUFG has resulted in the router using a non-dedicated path between the two.  There are several things that could trigger this DRC, each of which can cause unpredictable clock insertion delays that result in poor timing.  This DRC could be caused by any of the following: (a) a clock port was placed on a pin that is not a CCIO-pin (b)the BUFG has not been placed in the same half of the device or SLR as the CCIO-pin (c) a single ended clock has been placed on the N-Side of a differential pair CCIO-pin.
 This is normally an ERROR but the CLOCK_DEDICATED_ROUTE constraint is set to FALSE allowing your design to continue. The use of this override is highly discouraged as it may lead to very poor timing results. It is recommended that this error condition be corrected in the design.

	%s (IBUF.O) is locked to %s
	%s (BUFG.I) is provisionally placed by clockplacer on %s
%s*DRC2d
 "N
DAPLink_tri_o_IBUF[15]_inst	DAPLink_tri_o_IBUF[15]_inst2default:default2default:default2@
 "*
	IOB_X0Y82
	IOB_X0Y822default:default2default:default2n
 "X
 DAPLink_tri_o_IBUF_BUFG[15]_inst	 DAPLink_tri_o_IBUF_BUFG[15]_inst2default:default2default:default2H
 "2
BUFGCTRL_X0Y0
BUFGCTRL_X0Y02default:default2default:default2;
 #DRC|Implementation|Placement|Clocks2default:default8ZPLCK-12h px? 
b
DRC finished with %s
79*	vivadotcl2(
0 Errors, 1 Warnings2default:defaultZ4-198h px? 
e
BPlease refer to the DRC report (report_drc) for more information.
80*	vivadotclZ4-199h px? 
V

Starting %s Task
103*constraints2
Routing2default:defaultZ18-103h px? 
^
Using Router directive '%s'.
20*	routeflow2
Explore2default:defaultZ35-270h px? 
}
BMultithreading enabled for route_design using a maximum of %s CPUs17*	routeflow2
22default:defaultZ35-254h px? 
p

Phase %s%s
101*constraints2
1 2default:default2#
Build RT Design2default:defaultZ18-101h px? 
C
.Phase 1 Build RT Design | Checksum: 18b815137
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:53 ; elapsed = 00:00:41 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
v

Phase %s%s
101*constraints2
2 2default:default2)
Router Initialization2default:defaultZ18-101h px? 
o

Phase %s%s
101*constraints2
2.1 2default:default2 
Create Timer2default:defaultZ18-101h px? 
B
-Phase 2.1 Create Timer | Checksum: 18b815137
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:54 ; elapsed = 00:00:42 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
{

Phase %s%s
101*constraints2
2.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px? 
N
9Phase 2.2 Fix Topology Constraints | Checksum: 18b815137
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:54 ; elapsed = 00:00:42 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
t

Phase %s%s
101*constraints2
2.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px? 
G
2Phase 2.3 Pre Route Cleanup | Checksum: 18b815137
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:54 ; elapsed = 00:00:42 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
p

Phase %s%s
101*constraints2
2.4 2default:default2!
Update Timing2default:defaultZ18-101h px? 
C
.Phase 2.4 Update Timing | Checksum: 2474931ea
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:01:11 ; elapsed = 00:00:54 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
?
Intermediate Timing Summary %s164*route2K
7| WNS=-0.832 | TNS=-3.536 | WHS=-5.391 | THS=-693.055|
2default:defaultZ35-416h px? 
}

Phase %s%s
101*constraints2
2.5 2default:default2.
Update Timing for Bus Skew2default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
2.5.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 2.5.1 Update Timing | Checksum: 2216cb457
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:01:21 ; elapsed = 00:00:59 . Memory (MB): peak = 2129.656 ; gain = 33.8322default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-0.832 | TNS=-3.534 | WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
P
;Phase 2.5 Update Timing for Bus Skew | Checksum: 196dca252
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:01:21 ; elapsed = 00:01:00 . Memory (MB): peak = 2130.691 ; gain = 34.8672default:defaulth px? 
I
4Phase 2 Router Initialization | Checksum: 255f1238f
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:01:21 ; elapsed = 00:01:00 . Memory (MB): peak = 2130.691 ; gain = 34.8672default:defaulth px? 
p

Phase %s%s
101*constraints2
3 2default:default2#
Initial Routing2default:defaultZ18-101h px? 
C
.Phase 3 Initial Routing | Checksum: 15a4f2d0f
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:01:36 ; elapsed = 00:01:08 . Memory (MB): peak = 2132.059 ; gain = 36.2342default:defaulth px? 
?	
>Design has %s pins with tight setup and hold constraints.

%s
244*route2
22default:default2?
?The top 5 pins with tight setup and hold constraints:

+--------------------------+--------------------------+----------------------------------------------------------------------------------------------------------+
|       Launch Clock       |      Capture Clock       |                                                 Pin                                                      |
+--------------------------+--------------------------+----------------------------------------------------------------------------------------------------------+
|                    SWCLK |                    SWCLK |m3_for_arty_a7_i/Cortex_M3_0/inst/u_CORTEXM3INTEGRATION/uDAPSWJDP/uDAPSwjWatcher/FSM_onehot_State_cdc_check_reg[33]/D|
|                    SWCLK |                    SWCLK |m3_for_arty_a7_i/Cortex_M3_0/inst/u_CORTEXM3INTEGRATION/uDAPSWJDP/uDAPSwjWatcher/FSM_onehot_State_cdc_check_reg[4]/D|
+--------------------------+--------------------------+----------------------------------------------------------------------------------------------------------+

File with complete list of pins: tight_setup_hold_pins.txt
2default:defaultZ35-580h px? 
s

Phase %s%s
101*constraints2
4 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px? 
u

Phase %s%s
101*constraints2
4.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-1.710 | TNS=-22.145| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
H
3Phase 4.1 Global Iteration 0 | Checksum: 124964ee9
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:29 ; elapsed = 00:02:17 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
u

Phase %s%s
101*constraints2
4.2 2default:default2&
Global Iteration 12default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-1.710 | TNS=-18.544| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
H
3Phase 4.2 Global Iteration 1 | Checksum: 1ee9164b4
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:33 ; elapsed = 00:02:20 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
F
1Phase 4 Rip-up And Reroute | Checksum: 1ee9164b4
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:33 ; elapsed = 00:02:20 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
|

Phase %s%s
101*constraints2
5 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
5.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
5.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 5.1.1 Update Timing | Checksum: 193276f60
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:36 ; elapsed = 00:02:22 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-1.710 | TNS=-18.544| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
C
.Phase 5.1 Delay CleanUp | Checksum: 1ba72a164
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:37 ; elapsed = 00:02:23 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
z

Phase %s%s
101*constraints2
5.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px? 
M
8Phase 5.2 Clock Skew Optimization | Checksum: 1ba72a164
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:37 ; elapsed = 00:02:23 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
O
:Phase 5 Delay and Skew Optimization | Checksum: 1ba72a164
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:37 ; elapsed = 00:02:23 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
n

Phase %s%s
101*constraints2
6 2default:default2!
Post Hold Fix2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
6.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px? 
r

Phase %s%s
101*constraints2
6.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
E
0Phase 6.1.1 Update Timing | Checksum: 194be3fe7
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:41 ; elapsed = 00:02:25 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-1.710 | TNS=-18.544| WHS=-4.183 | THS=-12.497|
2default:defaultZ35-416h px? 
B
-Phase 6.1 Hold Fix Iter | Checksum: 595d3bd6
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:41 ; elapsed = 00:02:26 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
?	
?The router encountered %s pins that are both setup-critical and hold-critical and tried to fix hold violations at the expense of setup slack. Such pins are:
%s201*route2
132default:default2?
?	m3_for_arty_a7_i/Exin_IO_printer_0/inst/Exin_IO_printer_v1_0_S0_AXI_inst/printer/cnt_reg[0]/CLR
	m3_for_arty_a7_i/Exin_IO_printer_0/inst/Exin_IO_printer_v1_0_S0_AXI_inst/printer/cnt_reg[10]/CLR
	m3_for_arty_a7_i/Exin_IO_printer_0/inst/Exin_IO_printer_v1_0_S0_AXI_inst/printer/cnt_reg[12]/CLR
	m3_for_arty_a7_i/Exin_IO_printer_0/inst/Exin_IO_printer_v1_0_S0_AXI_inst/printer/cnt_reg[13]/CLR
	m3_for_arty_a7_i/Exin_IO_printer_0/inst/Exin_IO_printer_v1_0_S0_AXI_inst/printer/cnt_reg[14]/CLR
	m3_for_arty_a7_i/Exin_IO_printer_0/inst/Exin_IO_printer_v1_0_S0_AXI_inst/printer/cnt_reg[18]/CLR
	m3_for_arty_a7_i/Exin_IO_printer_0/inst/Exin_IO_printer_v1_0_S0_AXI_inst/printer/cnt_reg[1]/CLR
	m3_for_arty_a7_i/Exin_IO_printer_0/inst/Exin_IO_printer_v1_0_S0_AXI_inst/printer/cnt_reg[22]/CLR
	m3_for_arty_a7_i/Exin_IO_printer_0/inst/Exin_IO_printer_v1_0_S0_AXI_inst/printer/cnt_reg[23]/CLR
	m3_for_arty_a7_i/Exin_IO_printer_0/inst/Exin_IO_printer_v1_0_S0_AXI_inst/printer/cnt_reg[25]/CLR
	.. and 3 more pins.
2default:defaultZ35-468h px? 
@
+Phase 6 Post Hold Fix | Checksum: 5e4479f2
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:41 ; elapsed = 00:02:26 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
t

Phase %s%s
101*constraints2
7 2default:default2'
Timing Verification2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
7.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
C
.Phase 7.1 Update Timing | Checksum: 147d2ac7f
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:49 ; elapsed = 00:02:30 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-1.710 | TNS=-18.544| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
G
2Phase 7 Timing Verification | Checksum: 147d2ac7f
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:49 ; elapsed = 00:02:30 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
o

Phase %s%s
101*constraints2
8 2default:default2"
Route finalize2default:defaultZ18-101h px? 
B
-Phase 8 Route finalize | Checksum: 147d2ac7f
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:49 ; elapsed = 00:02:30 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
v

Phase %s%s
101*constraints2
9 2default:default2)
Verifying routed nets2default:defaultZ18-101h px? 
I
4Phase 9 Verifying routed nets | Checksum: 147d2ac7f
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:49 ; elapsed = 00:02:30 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
s

Phase %s%s
101*constraints2
10 2default:default2%
Depositing Routes2default:defaultZ18-101h px? 
F
1Phase 10 Depositing Routes | Checksum: 1e3f7cfd7
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:03:54 ; elapsed = 00:02:35 . Memory (MB): peak = 2136.215 ; gain = 40.3912default:defaulth px? 
w

Phase %s%s
101*constraints2
11 2default:default2)
Incr Placement Change2default:defaultZ18-101h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0152default:default2
2136.2152default:default2
0.0002default:defaultZ17-268h px? 
?
hPost Placement Timing Summary WNS=%s. For the most accurate timing information please run report_timing.610*place2
-1.7102default:defaultZ30-746h px? 
@
+Ending IncrPlace Task | Checksum: ff7da6d9
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:00:20 ; elapsed = 00:00:14 . Memory (MB): peak = 2174.305 ; gain = 38.0902default:defaulth px? 
J
5Phase 11 Incr Placement Change | Checksum: 1e3f7cfd7
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:04:15 ; elapsed = 00:02:51 . Memory (MB): peak = 2174.305 ; gain = 78.4802default:defaulth px? 
q

Phase %s%s
101*constraints2
12 2default:default2#
Build RT Design2default:defaultZ18-101h px? 
C
.Phase 12 Build RT Design | Checksum: 457abe6a
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:04:25 ; elapsed = 00:03:02 . Memory (MB): peak = 2174.305 ; gain = 78.4802default:defaulth px? 
w

Phase %s%s
101*constraints2
13 2default:default2)
Router Initialization2default:defaultZ18-101h px? 
p

Phase %s%s
101*constraints2
13.1 2default:default2 
Create Timer2default:defaultZ18-101h px? 
B
-Phase 13.1 Create Timer | Checksum: d02accaf
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:04:27 ; elapsed = 00:03:04 . Memory (MB): peak = 2174.305 ; gain = 78.4802default:defaulth px? 
|

Phase %s%s
101*constraints2
13.2 2default:default2,
Fix Topology Constraints2default:defaultZ18-101h px? 
N
9Phase 13.2 Fix Topology Constraints | Checksum: d02accaf
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:04:28 ; elapsed = 00:03:04 . Memory (MB): peak = 2174.305 ; gain = 78.4802default:defaulth px? 
u

Phase %s%s
101*constraints2
13.3 2default:default2%
Pre Route Cleanup2default:defaultZ18-101h px? 
H
3Phase 13.3 Pre Route Cleanup | Checksum: 133a6411b
*commonh px? 
?

%s
*constraints2p
\Time (s): cpu = 00:04:28 ; elapsed = 00:03:04 . Memory (MB): peak = 2174.305 ; gain = 78.4802default:defaulth px? 
q

Phase %s%s
101*constraints2
13.4 2default:default2!
Update Timing2default:defaultZ18-101h px? 
D
/Phase 13.4 Update Timing | Checksum: 157f44b2a
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:04:48 ; elapsed = 00:03:17 . Memory (MB): peak = 2204.203 ; gain = 108.3792default:defaulth px? 
?
Intermediate Timing Summary %s164*route2K
7| WNS=-1.710 | TNS=-10.492| WHS=-5.544 | THS=-693.724|
2default:defaultZ35-416h px? 
~

Phase %s%s
101*constraints2
13.5 2default:default2.
Update Timing for Bus Skew2default:defaultZ18-101h px? 
s

Phase %s%s
101*constraints2
13.5.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
F
1Phase 13.5.1 Update Timing | Checksum: 165974a6d
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:04:58 ; elapsed = 00:03:23 . Memory (MB): peak = 2255.641 ; gain = 159.8162default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-1.710 | TNS=-10.488| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
Q
<Phase 13.5 Update Timing for Bus Skew | Checksum: 101186efb
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:04:58 ; elapsed = 00:03:23 . Memory (MB): peak = 2257.160 ; gain = 161.3362default:defaulth px? 
J
5Phase 13 Router Initialization | Checksum: 16f75beb0
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:04:58 ; elapsed = 00:03:23 . Memory (MB): peak = 2257.160 ; gain = 161.3362default:defaulth px? 
q

Phase %s%s
101*constraints2
14 2default:default2#
Initial Routing2default:defaultZ18-101h px? 
D
/Phase 14 Initial Routing | Checksum: 214738f12
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:05 ; elapsed = 00:03:27 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
?
>Design has %s pins with tight setup and hold constraints.

%s
244*route2
1252default:default2?
?The top 5 pins with tight setup and hold constraints:

+--------------------------+--------------------------+----------------------------------------------------------------------------------------------------------+
|       Launch Clock       |      Capture Clock       |                                                 Pin                                                      |
+--------------------------+--------------------------+----------------------------------------------------------------------------------------------------------+
|                    SWCLK |                    SWCLK |m3_for_arty_a7_i/Cortex_M3_0/inst/u_CORTEXM3INTEGRATION/uDAPSWJDP/uDAPSwjWatcher/FSM_onehot_State_cdc_check_reg[16]/D|
|                    SWCLK |                    SWCLK |m3_for_arty_a7_i/Cortex_M3_0/inst/u_CORTEXM3INTEGRATION/uDAPSWJDP/uDAPSwjWatcher/FSM_onehot_State_cdc_check_reg[20]/D|
|                    SWCLK |                    SWCLK |m3_for_arty_a7_i/Cortex_M3_0/inst/u_CORTEXM3INTEGRATION/uDAPSWJDP/uDAPSwjWatcher/FSM_onehot_State_cdc_check_reg[29]/D|
|                    SWCLK |                    SWCLK |m3_for_arty_a7_i/Cortex_M3_0/inst/u_CORTEXM3INTEGRATION/uDAPSWJDP/uDAPSwjWatcher/FSM_onehot_State_cdc_check_reg[19]/D|
|                    SWCLK |                    SWCLK |m3_for_arty_a7_i/Cortex_M3_0/inst/u_CORTEXM3INTEGRATION/uDAPSWJDP/uDAPSwjWatcher/FSM_onehot_State_cdc_check_reg[33]/D|
+--------------------------+--------------------------+----------------------------------------------------------------------------------------------------------+

File with complete list of pins: tight_setup_hold_pins.txt
2default:defaultZ35-580h px? 
t

Phase %s%s
101*constraints2
15 2default:default2&
Rip-up And Reroute2default:defaultZ18-101h px? 
v

Phase %s%s
101*constraints2
15.1 2default:default2&
Global Iteration 02default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-1.710 | TNS=-21.032| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
I
4Phase 15.1 Global Iteration 0 | Checksum: 16ab14d1f
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:32 ; elapsed = 00:03:51 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
v

Phase %s%s
101*constraints2
15.2 2default:default2&
Global Iteration 12default:defaultZ18-101h px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-1.710 | TNS=-19.063| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
I
4Phase 15.2 Global Iteration 1 | Checksum: 2534829df
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:34 ; elapsed = 00:03:53 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
G
2Phase 15 Rip-up And Reroute | Checksum: 2534829df
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:34 ; elapsed = 00:03:53 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
}

Phase %s%s
101*constraints2
16 2default:default2/
Delay and Skew Optimization2default:defaultZ18-101h px? 
q

Phase %s%s
101*constraints2
16.1 2default:default2!
Delay CleanUp2default:defaultZ18-101h px? 
s

Phase %s%s
101*constraints2
16.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
F
1Phase 16.1.1 Update Timing | Checksum: 1d4762c5b
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:38 ; elapsed = 00:03:55 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-1.710 | TNS=-19.063| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
D
/Phase 16.1 Delay CleanUp | Checksum: 1d20544fd
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:38 ; elapsed = 00:03:56 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
{

Phase %s%s
101*constraints2
16.2 2default:default2+
Clock Skew Optimization2default:defaultZ18-101h px? 
N
9Phase 16.2 Clock Skew Optimization | Checksum: 1d20544fd
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:38 ; elapsed = 00:03:56 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
P
;Phase 16 Delay and Skew Optimization | Checksum: 1d20544fd
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:38 ; elapsed = 00:03:56 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
o

Phase %s%s
101*constraints2
17 2default:default2!
Post Hold Fix2default:defaultZ18-101h px? 
q

Phase %s%s
101*constraints2
17.1 2default:default2!
Hold Fix Iter2default:defaultZ18-101h px? 
s

Phase %s%s
101*constraints2
17.1.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
F
1Phase 17.1.1 Update Timing | Checksum: 2435890d2
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:42 ; elapsed = 00:03:58 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-1.710 | TNS=-19.063| WHS=0.036  | THS=0.000  |
2default:defaultZ35-416h px? 
D
/Phase 17.1 Hold Fix Iter | Checksum: 203e50f4d
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:42 ; elapsed = 00:03:58 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
B
-Phase 17 Post Hold Fix | Checksum: 203e50f4d
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:42 ; elapsed = 00:03:59 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
u

Phase %s%s
101*constraints2
18 2default:default2'
Timing Verification2default:defaultZ18-101h px? 
q

Phase %s%s
101*constraints2
18.1 2default:default2!
Update Timing2default:defaultZ18-101h px? 
D
/Phase 18.1 Update Timing | Checksum: 22636c2c5
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:49 ; elapsed = 00:04:03 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
?
Intermediate Timing Summary %s164*route2J
6| WNS=-1.710 | TNS=-19.063| WHS=N/A    | THS=N/A    |
2default:defaultZ35-416h px? 
H
3Phase 18 Timing Verification | Checksum: 22636c2c5
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:49 ; elapsed = 00:04:03 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
n

Phase %s%s
101*constraints2
19 2default:default2 
Reset Design2default:defaultZ18-101h px? 
b
&%s nets already restored were skipped.120*route2
336892default:defaultZ35-307h px? 
A
,Phase 19 Reset Design | Checksum: 172af9a40
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:05:55 ; elapsed = 00:04:06 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
t

Phase %s%s
101*constraints2
20 2default:default2&
Post Router Timing2default:defaultZ18-101h px? 
?
?Timer settings changed to match sign-off timing analysis. Setup and Hold analysis on slow, fast Corners with nearest common node skew is enabled.
62*routeZ35-62h px? 
?
Post Routing Timing Summary %s
20*route2J
6| WNS=-1.710 | TNS=-18.487| WHS=0.053  | THS=0.000  |
2default:defaultZ35-20h px? 
?
dThe design did not meet timing requirements. Please run report_timing_summary for detailed reports.
39*routeZ35-39h px? 
?
?TNS is the sum of the worst slack violation on every endpoint in the design. Review the paths with the biggest WNS violations in the timing reports and modify your constraints or your design to improve both WNS and TNS.
96*routeZ35-253h px? 
F
1Phase 20 Post Router Timing | Checksum: d03aeefb
*commonh px? 
?

%s
*constraints2q
]Time (s): cpu = 00:06:13 ; elapsed = 00:04:16 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
@
Router Completed Successfully
2*	routeflowZ35-16h px? 
?

%s
*constraints2q
]Time (s): cpu = 00:06:13 ; elapsed = 00:04:16 . Memory (MB): peak = 2291.645 ; gain = 195.8202default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1552default:default2
522default:default2
12default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
route_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
route_design: 2default:default2
00:06:182default:default2
00:04:192default:default2
2291.6452default:default2
195.8202default:defaultZ17-268h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0162default:default2
2291.6452default:default2
0.0002default:defaultZ17-268h px? 
H
&Writing timing data to binary archive.266*timingZ38-480h px? 
D
Writing placer database...
1603*designutilsZ20-1893h px? 
=
Writing XDEF routing.
211*designutilsZ20-211h px? 
J
#Writing XDEF routing logical nets.
209*designutilsZ20-209h px? 
J
#Writing XDEF routing special nets.
210*designutilsZ20-210h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2)
Write XDEF Complete: 2default:default2
00:00:132default:default2
00:00:052default:default2
2291.6452default:default2
0.0002default:defaultZ17-268h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2z
fV:/hardware/m3_for_arty_a7/m3_for_arty_a7/m3_for_arty_a7.runs/impl_1/m3_for_arty_a7_wrapper_routed.dcp2default:defaultZ17-1381h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:192default:default2
00:00:112default:default2
2291.6452default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
?Executing : report_drc -file m3_for_arty_a7_wrapper_drc_routed.rpt -pb m3_for_arty_a7_wrapper_drc_routed.pb -rpx m3_for_arty_a7_wrapper_drc_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
?report_drc -file m3_for_arty_a7_wrapper_drc_routed.rpt -pb m3_for_arty_a7_wrapper_drc_routed.pb -rpx m3_for_arty_a7_wrapper_drc_routed.rpx2default:defaultZ4-113h px? 
>
IP Catalog is up to date.1232*coregenZ19-1839h px? 
P
Running DRC with %s threads
24*drc2
22default:defaultZ23-27h px? 
?
#The results of DRC are in file %s.
168*coretcl2?
jV:/hardware/m3_for_arty_a7/m3_for_arty_a7/m3_for_arty_a7.runs/impl_1/m3_for_arty_a7_wrapper_drc_routed.rptjV:/hardware/m3_for_arty_a7/m3_for_arty_a7/m3_for_arty_a7.runs/impl_1/m3_for_arty_a7_wrapper_drc_routed.rpt2default:default8Z2-168h px? 
\
%s completed successfully
29*	vivadotcl2

report_drc2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2 
report_drc: 2default:default2
00:00:152default:default2
00:00:082default:default2
2291.6452default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
?Executing : report_methodology -file m3_for_arty_a7_wrapper_methodology_drc_routed.rpt -pb m3_for_arty_a7_wrapper_methodology_drc_routed.pb -rpx m3_for_arty_a7_wrapper_methodology_drc_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
?report_methodology -file m3_for_arty_a7_wrapper_methodology_drc_routed.rpt -pb m3_for_arty_a7_wrapper_methodology_drc_routed.pb -rpx m3_for_arty_a7_wrapper_methodology_drc_routed.rpx2default:defaultZ4-113h px? 
?
?%s: no pin(s)/port(s)/net(s) specified as objects, only virtual clock '%s' will be created. If you don't want this, please specify pin(s)/ports(s)/net(s) as objects to the command.
483*constraints2 
create_clock2default:default2 
slow_out_clk2default:default2O
9V:/hardware/m3_for_arty_a7/constraints/m3_for_arty_a7.xdc2default:default2
1192default:default8@Z18-483h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
Y
$Running Methodology with %s threads
74*drc2
22default:defaultZ23-133h px? 
?
2The results of Report Methodology are in file %s.
450*coretcl2?
vV:/hardware/m3_for_arty_a7/m3_for_arty_a7/m3_for_arty_a7.runs/impl_1/m3_for_arty_a7_wrapper_methodology_drc_routed.rptvV:/hardware/m3_for_arty_a7/m3_for_arty_a7/m3_for_arty_a7.runs/impl_1/m3_for_arty_a7_wrapper_methodology_drc_routed.rpt2default:default8Z2-1520h px? 
d
%s completed successfully
29*	vivadotcl2&
report_methodology2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2(
report_methodology: 2default:default2
00:00:262default:default2
00:00:142default:default2
2291.6452default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
?Executing : report_power -file m3_for_arty_a7_wrapper_power_routed.rpt -pb m3_for_arty_a7_wrapper_power_summary_routed.pb -rpx m3_for_arty_a7_wrapper_power_routed.rpx
2default:defaulth px? 
?
Command: %s
53*	vivadotcl2?
?report_power -file m3_for_arty_a7_wrapper_power_routed.rpt -pb m3_for_arty_a7_wrapper_power_summary_routed.pb -rpx m3_for_arty_a7_wrapper_power_routed.rpx2default:defaultZ4-113h px? 
?
?%s: no pin(s)/port(s)/net(s) specified as objects, only virtual clock '%s' will be created. If you don't want this, please specify pin(s)/ports(s)/net(s) as objects to the command.
483*constraints2 
create_clock2default:default2 
slow_out_clk2default:default2O
9V:/hardware/m3_for_arty_a7/constraints/m3_for_arty_a7.xdc2default:default2
1192default:default8@Z18-483h px? 
E
%Done setting XDC timing constraints.
35*timingZ38-35h px? 
K
,Running Vector-less Activity Propagation...
51*powerZ33-51h px? 
P
3
Finished Running Vector-less Activity Propagation
1*powerZ33-1h px? 
?
?Detected over-assertion of set/reset/preset/clear net with high fanouts, power estimation might not be accurate. Please run Tool - Power Constraint Wizard to set proper switching activities for control signals.282*powerZ33-332h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1692default:default2
532default:default2
12default:default2
02default:defaultZ4-41h px? 
^
%s completed successfully
29*	vivadotcl2 
report_power2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
report_power: 2default:default2
00:00:272default:default2
00:00:182default:default2
2291.6452default:default2
0.0002default:defaultZ17-268h px? 
?
%s4*runtcl2?
yExecuting : report_route_status -file m3_for_arty_a7_wrapper_route_status.rpt -pb m3_for_arty_a7_wrapper_route_status.pb
2default:defaulth px? 
?
%s4*runtcl2?
?Executing : report_timing_summary -max_paths 10 -file m3_for_arty_a7_wrapper_timing_summary_routed.rpt -pb m3_for_arty_a7_wrapper_timing_summary_routed.pb -rpx m3_for_arty_a7_wrapper_timing_summary_routed.rpx -warn_on_violation 
2default:defaulth px? 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px? 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px? 
?
rThe design failed to meet the timing requirements. Please see the %s report for details on the timing violations.
188*timing2"
timing summary2default:defaultZ38-282h px? 
?
}There are set_bus_skew constraint(s) in this design. Please run report_bus_skew to ensure that bus skew requirements are met.223*timingZ38-436h px? 
?
%s4*runtcl2s
_Executing : report_incremental_reuse -file m3_for_arty_a7_wrapper_incremental_reuse_routed.rpt
2default:defaulth px? 
g
BIncremental flow is disabled. No incremental reuse Info to report.423*	vivadotclZ4-1062h px? 
?
%s4*runtcl2s
_Executing : report_clock_utilization -file m3_for_arty_a7_wrapper_clock_utilization_routed.rpt
2default:defaulth px? 
?
%s4*runtcl2?
?Executing : report_bus_skew -warn_on_violation -file m3_for_arty_a7_wrapper_bus_skew_routed.rpt -pb m3_for_arty_a7_wrapper_bus_skew_routed.pb -rpx m3_for_arty_a7_wrapper_bus_skew_routed.rpx
2default:defaulth px? 
r
UpdateTimingParams:%s.
91*timing29
% Speed grade: -1, Delay Type: min_max2default:defaultZ38-91h px? 
|
CMultithreading enabled for timing update using a maximum of %s CPUs155*timing2
22default:defaultZ38-191h px? 


End Record