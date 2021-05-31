vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/xpm
vlib questa_lib/msim/lib_cdc_v1_0_2
vlib questa_lib/msim/proc_sys_reset_v5_0_13
vlib questa_lib/msim/util_vector_logic_v2_0_1
vlib questa_lib/msim/xlconstant_v1_1_6
vlib questa_lib/msim/axi_bram_ctrl_v4_1_1
vlib questa_lib/msim/axi_lite_ipif_v3_0_4
vlib questa_lib/msim/interrupt_control_v3_1_4
vlib questa_lib/msim/axi_gpio_v2_0_21
vlib questa_lib/msim/generic_baseblocks_v2_1_0
vlib questa_lib/msim/axi_infrastructure_v1_1_0
vlib questa_lib/msim/axi_register_slice_v2_1_19
vlib questa_lib/msim/fifo_generator_v13_2_4
vlib questa_lib/msim/axi_data_fifo_v2_1_18
vlib questa_lib/msim/axi_crossbar_v2_1_20
vlib questa_lib/msim/dist_mem_gen_v8_0_13
vlib questa_lib/msim/lib_pkg_v1_0_2
vlib questa_lib/msim/lib_srl_fifo_v1_0_2
vlib questa_lib/msim/lib_fifo_v1_0_13
vlib questa_lib/msim/axi_quad_spi_v3_2_18
vlib questa_lib/msim/axi_uartlite_v2_0_23
vlib questa_lib/msim/blk_mem_gen_v8_4_3
vlib questa_lib/msim/axi_protocol_converter_v2_1_19
vlib questa_lib/msim/xlconcat_v2_1_3

vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap xpm questa_lib/msim/xpm
vmap lib_cdc_v1_0_2 questa_lib/msim/lib_cdc_v1_0_2
vmap proc_sys_reset_v5_0_13 questa_lib/msim/proc_sys_reset_v5_0_13
vmap util_vector_logic_v2_0_1 questa_lib/msim/util_vector_logic_v2_0_1
vmap xlconstant_v1_1_6 questa_lib/msim/xlconstant_v1_1_6
vmap axi_bram_ctrl_v4_1_1 questa_lib/msim/axi_bram_ctrl_v4_1_1
vmap axi_lite_ipif_v3_0_4 questa_lib/msim/axi_lite_ipif_v3_0_4
vmap interrupt_control_v3_1_4 questa_lib/msim/interrupt_control_v3_1_4
vmap axi_gpio_v2_0_21 questa_lib/msim/axi_gpio_v2_0_21
vmap generic_baseblocks_v2_1_0 questa_lib/msim/generic_baseblocks_v2_1_0
vmap axi_infrastructure_v1_1_0 questa_lib/msim/axi_infrastructure_v1_1_0
vmap axi_register_slice_v2_1_19 questa_lib/msim/axi_register_slice_v2_1_19
vmap fifo_generator_v13_2_4 questa_lib/msim/fifo_generator_v13_2_4
vmap axi_data_fifo_v2_1_18 questa_lib/msim/axi_data_fifo_v2_1_18
vmap axi_crossbar_v2_1_20 questa_lib/msim/axi_crossbar_v2_1_20
vmap dist_mem_gen_v8_0_13 questa_lib/msim/dist_mem_gen_v8_0_13
vmap lib_pkg_v1_0_2 questa_lib/msim/lib_pkg_v1_0_2
vmap lib_srl_fifo_v1_0_2 questa_lib/msim/lib_srl_fifo_v1_0_2
vmap lib_fifo_v1_0_13 questa_lib/msim/lib_fifo_v1_0_13
vmap axi_quad_spi_v3_2_18 questa_lib/msim/axi_quad_spi_v3_2_18
vmap axi_uartlite_v2_0_23 questa_lib/msim/axi_uartlite_v2_0_23
vmap blk_mem_gen_v8_4_3 questa_lib/msim/blk_mem_gen_v8_4_3
vmap axi_protocol_converter_v2_1_19 questa_lib/msim/axi_protocol_converter_v2_1_19
vmap xlconcat_v2_1_3 questa_lib/msim/xlconcat_v2_1_3

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"D:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
"D:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Xilinx/Vivado/2019.1/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work lib_cdc_v1_0_2 -64 -93 \
"../../../../../block_diagram/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work proc_sys_reset_v5_0_13 -64 -93 \
"../../../../../block_diagram/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../../block_diagram/ip/m3_for_arty_a7_proc_sys_reset_DAPLink_0/sim/m3_for_arty_a7_proc_sys_reset_DAPLink_0.vhd" \
"../../../../../block_diagram/ip/m3_for_arty_a7_proc_sys_reset_base_0/sim/m3_for_arty_a7_proc_sys_reset_base_0.vhd" \

vlog -work util_vector_logic_v2_0_1 -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/2137/hdl/util_vector_logic_v2_0_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ip/m3_for_arty_a7_i_interconnect_aresetn_0/sim/m3_for_arty_a7_i_interconnect_aresetn_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_i_peripheral_aresetn1_0/sim/m3_for_arty_a7_i_peripheral_aresetn1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_i_sysresetn_or_0/sim/m3_for_arty_a7_i_sysresetn_or_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_i_inv_dbgresetn_0/sim/m3_for_arty_a7_i_inv_dbgresetn_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_i_inv_sysresetn1_0/sim/m3_for_arty_a7_i_inv_sysresetn1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_clk_wiz_0_0/m3_for_arty_a7_clk_wiz_0_0_clk_wiz.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_clk_wiz_0_0/m3_for_arty_a7_clk_wiz_0_0.v" \

vlog -work xlconstant_v1_1_6 -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/66e7/hdl/xlconstant_v1_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ip/m3_for_arty_a7_xlconstant_1_0/sim/m3_for_arty_a7_xlconstant_1_0.v" \

vcom -work axi_bram_ctrl_v4_1_1 -64 -93 \
"../../../../../block_diagram/ipshared/70bf/hdl/axi_bram_ctrl_v4_1_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../../block_diagram/ip/m3_for_arty_a7_axi_bram_ctrl_0_0/sim/m3_for_arty_a7_axi_bram_ctrl_0_0.vhd" \

vcom -work axi_lite_ipif_v3_0_4 -64 -93 \
"../../../../../block_diagram/ipshared/66ea/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work interrupt_control_v3_1_4 -64 -93 \
"../../../../../block_diagram/ipshared/a040/hdl/interrupt_control_v3_1_vh_rfs.vhd" \

vcom -work axi_gpio_v2_0_21 -64 -93 \
"../../../../../block_diagram/ipshared/9c6e/hdl/axi_gpio_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../../block_diagram/ip/m3_for_arty_a7_axi_gpio_0_0/sim/m3_for_arty_a7_axi_gpio_0_0.vhd" \
"../../../../../block_diagram/ip/m3_for_arty_a7_axi_gpio_1_0/sim/m3_for_arty_a7_axi_gpio_1_0.vhd" \

vlog -work generic_baseblocks_v2_1_0 -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \

vlog -work axi_infrastructure_v1_1_0 -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \

vlog -work axi_register_slice_v2_1_19 -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/4d88/hdl/axi_register_slice_v2_1_vl_rfs.v" \

vlog -work fifo_generator_v13_2_4 -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/1f5a/simulation/fifo_generator_vlog_beh.v" \

vcom -work fifo_generator_v13_2_4 -64 -93 \
"../../../../../block_diagram/ipshared/1f5a/hdl/fifo_generator_v13_2_rfs.vhd" \

vlog -work fifo_generator_v13_2_4 -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/1f5a/hdl/fifo_generator_v13_2_rfs.v" \

vlog -work axi_data_fifo_v2_1_18 -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/5b9c/hdl/axi_data_fifo_v2_1_vl_rfs.v" \

vlog -work axi_crossbar_v2_1_20 -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/ace7/hdl/axi_crossbar_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ip/m3_for_arty_a7_xbar_0/sim/m3_for_arty_a7_xbar_0.v" \

vlog -work dist_mem_gen_v8_0_13 -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/0bf5/simulation/dist_mem_gen_v8_0.v" \

vcom -work lib_pkg_v1_0_2 -64 -93 \
"../../../../../block_diagram/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -64 -93 \
"../../../../../block_diagram/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work lib_fifo_v1_0_13 -64 -93 \
"../../../../../block_diagram/ipshared/4dac/hdl/lib_fifo_v1_0_rfs.vhd" \

vcom -work axi_quad_spi_v3_2_18 -64 -93 \
"../../../../../block_diagram/ipshared/488f/hdl/axi_quad_spi_v3_2_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../../block_diagram/ip/m3_for_arty_a7_axi_quad_spi_0_0/sim/m3_for_arty_a7_axi_quad_spi_0_0.vhd" \

vcom -work axi_uartlite_v2_0_23 -64 -93 \
"../../../../../block_diagram/ipshared/0315/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../../block_diagram/ip/m3_for_arty_a7_axi_uartlite_0_0/sim/m3_for_arty_a7_axi_uartlite_0_0.vhd" \

vlog -work blk_mem_gen_v8_4_3 -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/c001/simulation/blk_mem_gen_v8_4.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ip/m3_for_arty_a7_blk_mem_gen_0_0/sim/m3_for_arty_a7_blk_mem_gen_0_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_xbar_1/sim/m3_for_arty_a7_xbar_1.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../../../block_diagram/ip/m3_for_arty_a7_axi_single_spi_0_0/sim/m3_for_arty_a7_axi_single_spi_0_0.vhd" \
"../../../../../block_diagram/ip/m3_for_arty_a7_axi_quad_spi_0_1/sim/m3_for_arty_a7_axi_quad_spi_0_1.vhd" \
"../../../../../block_diagram/ip/m3_for_arty_a7_axi_xip_quad_spi_0_0/sim/m3_for_arty_a7_axi_xip_quad_spi_0_0.vhd" \
"../../../../../block_diagram/ip/m3_for_arty_a7_axi_gpio_0_1/sim/m3_for_arty_a7_axi_gpio_0_1.vhd" \

vlog -work axi_protocol_converter_v2_1_19 -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/c83a/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ip/m3_for_arty_a7_axi_protocol_convert_0_0/sim/m3_for_arty_a7_axi_protocol_convert_0_0.v" \
"../../../../../block_diagram/ipshared/5fe9/DAPLink_to_Arty_shield.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_DAPLink_to_Arty_shield_0_0/sim/m3_for_arty_a7_DAPLink_to_Arty_shield_0_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_tri_io_buf_0_0/sim/m3_for_arty_a7_tri_io_buf_0_0.v" \

vlog -work xlconcat_v2_1_3 -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/442e/hdl/xlconcat_v2_1_vl_rfs.v" \

vlog -work xil_defaultlib -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ip/m3_for_arty_a7_xlconcat_0_0/sim/m3_for_arty_a7_xlconcat_0_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_xlconcat_1_0/sim/m3_for_arty_a7_xlconcat_1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_xlconstant_1_1/sim/m3_for_arty_a7_xlconstant_1_1.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/cm3_dap_ahb_ap.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/cm3_wic.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/cm3_nvic.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/cm3_dwt.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/AhbToAxi.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/cm3_mpu.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/cm3_bus_matrix.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/models.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/cmsdk.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/cm3_tpiu.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/dapswjdp.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/cm3_fpb.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/cm3_dpu.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/cm3_itm.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/cm3_etm.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/cortexm3.v" \
"../../../../../block_diagram/ipshared/ea75/rtl/cortexm3_integration.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_Cortex_M3_0_0/sim/m3_for_arty_a7_Cortex_M3_0_0.v" \
"../../../../../block_diagram/ipshared/c6d8/src/Exin_ADC0832.v" \
"../../../../../block_diagram/ipshared/c6d8/hdl/Exin_ADC0832_v1_0_S0_AXI.v" \
"../../../../../block_diagram/ipshared/c6d8/hdl/Exin_ADC0832_v1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_Exin_ADC0832_0_0/sim/m3_for_arty_a7_Exin_ADC0832_0_0.v" \
"../../../../../block_diagram/ipshared/493d/hdl/Exin_HeartFre2_v1_0_S0_AXI.v" \
"../../../../../block_diagram/ipshared/493d/src/Exin_Heart_Fre.v" \
"../../../../../block_diagram/ipshared/493d/hdl/Exin_HeartFre2_v1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_Exin_HeartFre2_0_0/sim/m3_for_arty_a7_Exin_HeartFre2_0_0.v" \
"../../../../../block_diagram/ipshared/2d8a/src/Exin_MAXMIN2.v" \
"../../../../../block_diagram/ipshared/2d8a/hdl/Exin_MAXMIN2_v1_0_S0_AXI.v" \
"../../../../../block_diagram/ipshared/2d8a/hdl/Exin_MAXMIN2_v1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_Exin_MAXMIN2_0_0/sim/m3_for_arty_a7_Exin_MAXMIN2_0_0.v" \
"../../../../../block_diagram/ipshared/a61e/src/Exin_dht11.v" \
"../../../../../block_diagram/ipshared/a61e/hdl/Exin_dht11_v1_0_S0_AXI.v" \
"../../../../../block_diagram/ipshared/a61e/hdl/Exin_dht11_v1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_Exin_dht11_0_0/sim/m3_for_arty_a7_Exin_dht11_0_0.v" \
"../../../../../block_diagram/ipshared/ca24/src/Exin_MPU6050.v" \
"../../../../../block_diagram/ipshared/ca24/hdl/Exin_MPU6050_GYXX_v1_0_S00_AXI.v" \
"../../../../../block_diagram/ipshared/ca24/hdl/Exin_MPU6050_GYXX_v1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_Exin_MPU6050_GYXX_0_0/sim/m3_for_arty_a7_Exin_MPU6050_GYXX_0_0.v" \
"../../../../../block_diagram/ipshared/1b2a/hdl/Exin_StepCounter_debug_v1_0_S00_AXI.v" \
"../../../../../block_diagram/ipshared/1b2a/src/Exin_Step_debug.v" \
"../../../../../block_diagram/ipshared/1b2a/hdl/Exin_StepCounter_debug_v1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_Exin_StepCounter_deb_0_0/sim/m3_for_arty_a7_Exin_StepCounter_deb_0_0.v" \
"../../../../../block_diagram/ipshared/be52/src/breath_led.v" \
"../../../../../block_diagram/ipshared/be52/hdl/breath_led_v1_0_S0_AXI.v" \
"../../../../../block_diagram/ipshared/be52/hdl/breath_led_v1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_breath_led_0_0/sim/m3_for_arty_a7_breath_led_0_0.v" \
"../../../../../block_diagram/ipshared/97d3/src/Exin_Timer.v" \
"../../../../../block_diagram/ipshared/97d3/hdl/Exin_Timer_v1_0_S0_AXI.v" \
"../../../../../block_diagram/ipshared/97d3/hdl/Exin_Timer_v1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_Exin_Timer_0_0/sim/m3_for_arty_a7_Exin_Timer_0_0.v" \
"../../../../../block_diagram/ipshared/d29f/src/Exin_beep.v" \
"../../../../../block_diagram/ipshared/d29f/hdl/Exin_beep_v1_0_S0_AXI.v" \
"../../../../../block_diagram/ipshared/d29f/hdl/Exin_beep_v1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_Exin_beep_0_0/sim/m3_for_arty_a7_Exin_beep_0_0.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../../../block_diagram/ip/m3_for_arty_a7_axi_uartlite_1_0/sim/m3_for_arty_a7_axi_uartlite_1_0.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/1745/src/Exin_IO_printer.v" \
"../../../../../block_diagram/ipshared/1745/hdl/Exin_IO_printer_v1_0_S0_AXI.v" \
"../../../../../block_diagram/ipshared/1745/hdl/Exin_IO_printer_v1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_Exin_IO_printer_0_0/sim/m3_for_arty_a7_Exin_IO_printer_0_0.v" \

vcom -work xil_defaultlib -64 -93 \
"../../../../../block_diagram/ip/m3_for_arty_a7_axi_gpio_2_0/sim/m3_for_arty_a7_axi_gpio_2_0.vhd" \

vlog -work xil_defaultlib -64 "+incdir+../../../../../block_diagram/ipshared/c923" "+incdir+../../../../../block_diagram/ipshared/ec67/hdl" "+incdir+../../../../../block_diagram/ipshared/ea75/rtl" \
"../../../../../block_diagram/ipshared/3367/src/Exin_clk_wizard.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_Exin_clk_wizard_0_0/sim/m3_for_arty_a7_Exin_clk_wizard_0_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_Exin_clk_wizard_1_0/sim/m3_for_arty_a7_Exin_clk_wizard_1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_xlconstant_0_0/sim/m3_for_arty_a7_xlconstant_0_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_xlconstant_2_0/sim/m3_for_arty_a7_xlconstant_2_0.v" \
"../../../../../block_diagram/ipshared/652b/src/Exin_noliner2.v" \
"../../../../../block_diagram/ipshared/652b/hdl/Exin_noliner2_v1_0_S0_AXI.v" \
"../../../../../block_diagram/ipshared/652b/hdl/Exin_noliner2_v1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_Exin_noliner2_0_0/sim/m3_for_arty_a7_Exin_noliner2_0_0.v" \
"../../../../../block_diagram/ipshared/eb0f/src/Exin_HMITX.v" \
"../../../../../block_diagram/ipshared/eb0f/hdl/Exin_HMITX_v1_0_S0_AXI.v" \
"../../../../../block_diagram/ipshared/eb0f/hdl/Exin_HMITX_v1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_Exin_HMITX_0_0/sim/m3_for_arty_a7_Exin_HMITX_0_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_tier2_xbar_0_0/sim/m3_for_arty_a7_tier2_xbar_0_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_tier2_xbar_1_0/sim/m3_for_arty_a7_tier2_xbar_1_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_tier2_xbar_2_0/sim/m3_for_arty_a7_tier2_xbar_2_0.v" \
"../../../../../block_diagram/ip/m3_for_arty_a7_auto_pc_0/sim/m3_for_arty_a7_auto_pc_0.v" \
"../../../../../block_diagram/sim/m3_for_arty_a7.v" \

vlog -work xil_defaultlib \
"glbl.v"

