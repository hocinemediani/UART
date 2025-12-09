## This file is a general .xdc for the Nexys4_DDR
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]

# Clock signal
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { mclk }]; #IO_L12P_T1_MRCC_35 Sch=clk100mhz
# syc_clk will be constrained by the MIG IP; commenting it avoids double clock definition and overridden clock definition warnings
# create_clock -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports {mclk}];

## lignes serie micro usb
set_property -dict { PACKAGE_PIN C4    IOSTANDARD LVCMOS33 } [get_ports { RxD }]; #IO_L7P_T1_AD6P_35 Sch=uart_txd_in
set_property -dict { PACKAGE_PIN D4    IOSTANDARD LVCMOS33 } [get_ports { TxD }]; #IO_L11N_T1_SRCC_35 Sch=uart_rxd_out

##Button
set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { btnC }]; #IO_L9P_T1_DQS_14 Sch=btnc
