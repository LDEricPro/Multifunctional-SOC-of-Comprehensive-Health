
s
Command: %s
53*	vivadotcl2B
.phys_opt_design -directive AggressiveFanoutOpt2default:defaultZ4-113h px? 
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
u
)Directive used for phys_opt_design is: %s68*	vivadotcl2'
AggressiveFanoutOpt2default:defaultZ4-137h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0162default:default2
2095.8242default:default2
0.0002default:defaultZ17-268h px? 
a

Starting %s Task
103*constraints2&
Physical Synthesis2default:defaultZ18-103h px? 
?

Phase %s%s
101*constraints2
1 2default:default25
!Physical Synthesis Initialization2default:defaultZ18-101h px? 
?
EMultithreading enabled for phys_opt_design using a maximum of %s CPUs380*physynth2
22default:defaultZ32-721h px? 
?
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2default:default2
 2default:default2
-0.8892default:default2
-5.5772default:defaultZ32-619h px? 
U
@Phase 1 Physical Synthesis Initialization | Checksum: 1a933b005
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:07 ; elapsed = 00:00:04 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
?
(%s %s Timing Summary | WNS=%s | TNS=%s |333*physynth2
	Estimated2default:default2
 2default:default2
-0.8892default:default2
-5.5772default:defaultZ32-619h px? 
t

Phase %s%s
101*constraints2
2 2default:default2'
Fanout Optimization2default:defaultZ18-101h px? 
I
'No nets found for fanout-optimization.
64*physynthZ32-64h px? 
?
$Optimized %s %s. Created %s new %s.
216*physynth2
02default:default2
net2default:default2
02default:default2
instance2default:defaultZ32-232h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
42default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
G
2Phase 2 Fanout Optimization | Checksum: 1a933b005
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:08 ; elapsed = 00:00:06 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
}

Phase %s%s
101*constraints2
3 2default:default20
Placement Based Optimization2default:defaultZ18-101h px? 
?
=Identified %s candidate %s for placement-based optimization.
334*physynth2
42default:default2
nets2default:defaultZ32-660h px? 
?
/Processed net %s.  Did not re-place instance %s336*physynth2?
\m3_for_arty_a7_i/daplink_if_0/axi_xip_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/io2_i_sync\m3_for_arty_a7_i/daplink_if_0/axi_xip_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/io2_i_sync2default:default2?
[m3_for_arty_a7_i/daplink_if_0/axi_xip_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/IO2_I_REG	[m3_for_arty_a7_i/daplink_if_0/axi_xip_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/IO2_I_REG2default:default8Z32-662h px? 
?
/Processed net %s.  Did not re-place instance %s336*physynth2?
\m3_for_arty_a7_i/daplink_if_0/axi_xip_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/io0_i_sync\m3_for_arty_a7_i/daplink_if_0/axi_xip_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/io0_i_sync2default:default2?
[m3_for_arty_a7_i/daplink_if_0/axi_xip_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/IO0_I_REG	[m3_for_arty_a7_i/daplink_if_0/axi_xip_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/IO0_I_REG2default:default8Z32-662h px? 
?
/Processed net %s.  Did not re-place instance %s336*physynth2?
\m3_for_arty_a7_i/daplink_if_0/axi_xip_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/io1_i_sync\m3_for_arty_a7_i/daplink_if_0/axi_xip_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/io1_i_sync2default:default2?
[m3_for_arty_a7_i/daplink_if_0/axi_xip_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/IO1_I_REG	[m3_for_arty_a7_i/daplink_if_0/axi_xip_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/IO1_I_REG2default:default8Z32-662h px? 
?
/Processed net %s.  Did not re-place instance %s336*physynth2?
Xm3_for_arty_a7_i/daplink_if_0/axi_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/io3_i_syncXm3_for_arty_a7_i/daplink_if_0/axi_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/io3_i_sync2default:default2?
Wm3_for_arty_a7_i/daplink_if_0/axi_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/IO3_I_REG	Wm3_for_arty_a7_i/daplink_if_0/axi_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/IO3_I_REG2default:default8Z32-662h px? 
?
#Optimized %s %s.  Re-placed %s %s.
335*physynth2
02default:default2
net2default:default2
02default:default2
instance2default:defaultZ32-661h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0222default:default2
2095.8242default:default2
0.0002default:defaultZ17-268h px? 
P
;Phase 3 Placement Based Optimization | Checksum: 1a933b005
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:06 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
g

Phase %s%s
101*constraints2
4 2default:default2
Rewire2default:defaultZ18-101h px? 
a
Starting %s optimization...
227*physynth2
Signal Push2default:defaultZ32-246h px? 
h
.No nets found for rewiring (%s) optimization.
222*physynth2
 2default:defaultZ32-241h px? 
?
$Optimized %s %s. Created %s new %s.
216*physynth2
02default:default2
net2default:default2
02default:default2
instance2default:defaultZ32-232h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
42default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0162default:default2
2095.8242default:default2
0.0002default:defaultZ17-268h px? 
:
%Phase 4 Rewire | Checksum: 1a933b005
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:06 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
{

Phase %s%s
101*constraints2
5 2default:default2.
Critical Cell Optimization2default:defaultZ18-101h px? 
P
.No nets found for critical-cell optimization.
68*physynthZ32-68h px? 
?
$Optimized %s %s. Created %s new %s.
216*physynth2
02default:default2
net2default:default2
02default:default2
instance2default:defaultZ32-232h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
N
9Phase 5 Critical Cell Optimization | Checksum: 1a933b005
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:06 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
z

Phase %s%s
101*constraints2
6 2default:default2-
DSP Register Optimization2default:defaultZ18-101h px? 
j
FNo candidate cells for DSP register optimization found in the design.
274*physynthZ32-456h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
22default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
M
8Phase 6 DSP Register Optimization | Checksum: 1a933b005
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:06 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
{

Phase %s%s
101*constraints2
7 2default:default2.
BRAM Register Optimization2default:defaultZ18-101h px? 
?
\Property '%s' on BRAM cell '%s' Port '%s' is 0. Skip BRAM Register Optimization on the port
328*physynth2 
READ_WIDTH_B2default:default2?
?m3_for_arty_a7_i/axi_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/QSPI_LEGACY_MD_GEN.QSPI_CORE_INTERFACE_I/LOGIC_FOR_MD_12_GEN.SPI_MODE_1_LUT_LOGIC_I/QSPI_LOOK_UP_MODE_2_MEMORY_2.xpm_mem_gen_QSPI_LOOK_UP_MODE_2_MEMORY_2.xpm_memory_inst/xpm_memory_base_inst/gen_rd_a.douta_reg_reg	?m3_for_arty_a7_i/axi_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/QSPI_LEGACY_MD_GEN.QSPI_CORE_INTERFACE_I/LOGIC_FOR_MD_12_GEN.SPI_MODE_1_LUT_LOGIC_I/QSPI_LOOK_UP_MODE_2_MEMORY_2.xpm_mem_gen_QSPI_LOOK_UP_MODE_2_MEMORY_2.xpm_memory_inst/xpm_memory_base_inst/gen_rd_a.douta_reg_reg2default:default2
B2default:default8Z32-614h px? 
?
\Property '%s' on BRAM cell '%s' Port '%s' is 0. Skip BRAM Register Optimization on the port
328*physynth2 
READ_WIDTH_B2default:default2?
?m3_for_arty_a7_i/daplink_if_0/axi_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/QSPI_LEGACY_MD_GEN.QSPI_CORE_INTERFACE_I/LOGIC_FOR_MD_12_GEN.SPI_MODE_1_LUT_LOGIC_I/QSPI_LOOK_UP_MODE_2_MEMORY_1.xpm_mem_gen_QSPI_LOOK_UP_MODE_2_MEMORY_1.xpm_memory_inst/xpm_memory_base_inst/gen_rd_a.douta_reg_reg	?m3_for_arty_a7_i/daplink_if_0/axi_quad_spi_0/U0/NO_DUAL_QUAD_MODE.QSPI_NORMAL/QSPI_LEGACY_MD_GEN.QSPI_CORE_INTERFACE_I/LOGIC_FOR_MD_12_GEN.SPI_MODE_1_LUT_LOGIC_I/QSPI_LOOK_UP_MODE_2_MEMORY_1.xpm_mem_gen_QSPI_LOOK_UP_MODE_2_MEMORY_1.xpm_memory_inst/xpm_memory_base_inst/gen_rd_a.douta_reg_reg2default:default2
B2default:default8Z32-614h px? 
i
ENo candidate cells for BRAM register optimization found in the design297*physynthZ32-526h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
N
9Phase 7 BRAM Register Optimization | Checksum: 1a933b005
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:06 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
{

Phase %s%s
101*constraints2
8 2default:default2.
URAM Register Optimization2default:defaultZ18-101h px? 
j
FNo candidate cells for URAM register optimization found in the design
437*physynthZ32-846h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
N
9Phase 8 URAM Register Optimization | Checksum: 1a933b005
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:06 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
|

Phase %s%s
101*constraints2
9 2default:default2/
Shift Register Optimization2default:defaultZ18-101h px? 
h
DNo candidate cells for SRL register optimization found in the design349*physynthZ32-677h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
O
:Phase 9 Shift Register Optimization | Checksum: 1a933b005
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:06 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
{

Phase %s%s
101*constraints2
10 2default:default2-
Critical Pin Optimization2default:defaultZ18-101h px? 
[
7No candidate nets found for critical-pin optimization.
321*physynthZ32-607h px? 
?
!Optimized %s %s.  Swapped %s %s.
322*physynth2
02default:default2
net2default:default2
02default:default2
pin2default:defaultZ32-608h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
N
9Phase 10 Critical Pin Optimization | Checksum: 1a933b005
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:06 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 


Phase %s%s
101*constraints2
11 2default:default21
Very High Fanout Optimization2default:defaultZ18-101h px? 
?
=Pass %s. Identified %s candidate %s for fanout optimization.
76*physynth2
12default:default2
22default:default2
nets2default:defaultZ32-76h px? 
?
$Optimized %s %s. Created %s new %s.
216*physynth2
02default:default2
net2default:default2
02default:default2
instance2default:defaultZ32-232h px? 
?
aEnd %s Pass. Optimized %s %s. Created %s new %s, deleted %s existing %s and moved %s existing %s
415*physynth2
12default:default2
02default:default2
net or cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:default2
02default:default2
cell2default:defaultZ32-775h px? 
R
=Phase 11 Very High Fanout Optimization | Checksum: 1a933b005
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:07 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
z

Phase %s%s
101*constraints2
12 2default:default2,
BRAM Enable Optimization2default:defaultZ18-101h px? 
M
8Phase 12 BRAM Enable Optimization | Checksum: 1a933b005
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:09 ; elapsed = 00:00:07 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0142default:default2
2095.8242default:default2
0.0002default:defaultZ17-268h px? 
?
>Post Physical Optimization Timing Summary | WNS=%s | TNS=%s |
318*physynth2
-0.8892default:default2
-5.5772default:defaultZ32-603h px? 
B
-
Summary of Physical Synthesis Optimizations
*commonh px? 
B
-============================================
*commonh px? 


*commonh px? 


*commonh px? 
?
?-----------------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  Optimization       |  WNS Gain (ns)  |  TNS Gain (ns)  |  Added Cells  |  Removed Cells  |  Optimized Cells/Nets  |  Dont Touch  |  Iterations  |  Elapsed   |
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px? 
?
?|  Fanout             |          0.000  |          0.000  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Placement Based    |          0.000  |          0.000  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Rewire             |          0.000  |          0.000  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Critical Cell      |          0.000  |          0.000  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  DSP Register       |          0.000  |          0.000  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  BRAM Register      |          0.000  |          0.000  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  URAM Register      |          0.000  |          0.000  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Shift Register     |          0.000  |          0.000  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Critical Pin       |          0.000  |          0.000  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Very High Fanout   |          0.000  |          0.000  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  BRAM Enable        |          0.000  |          0.000  |            0  |              0  |                     0  |           0  |           1  |  00:00:00  |
|  Total              |          0.000  |          0.000  |            0  |              0  |                     0  |           0  |          11  |  00:00:01  |
-----------------------------------------------------------------------------------------------------------------------------------------------------------------
*commonh px? 


*commonh px? 


*commonh px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0172default:default2
2095.8242default:default2
0.0002default:defaultZ17-268h px? 
J
5Ending Physical Synthesis Task | Checksum: 1a933b005
*commonh px? 
?

%s
*constraints2o
[Time (s): cpu = 00:00:10 ; elapsed = 00:00:07 . Memory (MB): peak = 2095.824 ; gain = 0.0002default:defaulth px? 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px? 
?
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
1242default:default2
502default:default2
02default:default2
02default:defaultZ4-41h px? 
a
%s completed successfully
29*	vivadotcl2#
phys_opt_design2default:defaultZ4-42h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2%
phys_opt_design: 2default:default2
00:00:212default:default2
00:00:132default:default2
2095.8242default:default2
0.0002default:defaultZ17-268h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2.
Netlist sorting complete. 2default:default2
00:00:002default:default2 
00:00:00.0152default:default2
2095.8242default:default2
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
00:00:112default:default2
00:00:042default:default2
2095.8242default:default2
0.0002default:defaultZ17-268h px? 
?
 The %s '%s' has been generated.
621*common2

checkpoint2default:default2{
gV:/hardware/m3_for_arty_a7/m3_for_arty_a7/m3_for_arty_a7.runs/impl_1/m3_for_arty_a7_wrapper_physopt.dcp2default:defaultZ17-1381h px? 
?
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2&
write_checkpoint: 2default:default2
00:00:172default:default2
00:00:102default:default2
2095.8242default:default2
0.0002default:defaultZ17-268h px? 


End Record