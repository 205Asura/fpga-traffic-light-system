

## Clock Signal
set_property -dict { PACKAGE_PIN H16    IOSTANDARD LVCMOS33 } [get_ports { clk }]; #IO_L13P_T2_MRCC_35 Sch=SYSCLK
create_clock -add -name sys_clk_pin -period 8.00 -waveform {0 4} [get_ports { clk }];#set

## Switches
#set_property -dict { PACKAGE_PIN M20    IOSTANDARD LVCMOS33 } [get_ports { rst }]; #IO_L7N_T1_AD2N_35 Sch=SW0
#set_property -dict { PACKAGE_PIN M19    IOSTANDARD LVCMOS33 } [get_ports { sw[1] }]; #IO_L7P_T1_AD2P_35 Sch=SW1

## RGB LEDs
set_property -dict { PACKAGE_PIN L15    IOSTANDARD LVCMOS33 } [get_ports { yellow }]; #IO_L22N_T3_AD7P_35 Sch=LED4_B
set_property -dict { PACKAGE_PIN G17    IOSTANDARD LVCMOS33 } [get_ports { green }]; #IO_L16P_T2_35 Sch=LED4_G
set_property -dict { PACKAGE_PIN N15    IOSTANDARD LVCMOS33 } [get_ports { red }]; #IO_L21P_T3_DQS_AD14P_35 Sch=LED4_R
set_property -dict { PACKAGE_PIN G14    IOSTANDARD LVCMOS33 } [get_ports { yellow2 }]; #IO_0_35 Sch=LED5_B
set_property -dict { PACKAGE_PIN L14    IOSTANDARD LVCMOS33 } [get_ports { green2 }]; #IO_L22P_T3_AD7P_35 Sch=LED5_G
set_property -dict { PACKAGE_PIN M15    IOSTANDARD LVCMOS33 } [get_ports { red2 }]; #IO_L23N_T3_35 Sch=LED5_R

## LEDs
#set_property -dict { PACKAGE_PIN R14    IOSTANDARD LVCMOS33 } [get_ports { led[0] }]; #IO_L6N_T0_VREF_34 Sch=LED0
#set_property -dict { PACKAGE_PIN P14    IOSTANDARD LVCMOS33 } [get_ports { led[1] }]; #IO_L6P_T0_34 Sch=LED1
#set_property -dict { PACKAGE_PIN N16    IOSTANDARD LVCMOS33 } [get_ports { led[2] }]; #IO_L21N_T3_DQS_AD14N_35 Sch=LED2
#set_property -dict { PACKAGE_PIN M14    IOSTANDARD LVCMOS33 } [get_ports { led[3] }]; #IO_L23P_T3_35 Sch=LED3

## Buttons
set_property -dict { PACKAGE_PIN D19    IOSTANDARD LVCMOS33 } [get_ports { rst }]; #IO_L4P_T0_35 Sch=BTN0
set_property -dict { PACKAGE_PIN D20    IOSTANDARD LVCMOS33 } [get_ports { btnC }]; #IO_L4N_T0_35 Sch=BTN1
set_property -dict { PACKAGE_PIN L20    IOSTANDARD LVCMOS33 } [get_ports { btnR }]; #IO_L9N_T1_DQS_AD3N_35 Sch=BTN2
set_property -dict { PACKAGE_PIN L19    IOSTANDARD LVCMOS33 } [get_ports { btnL }]; #IO_L9P_T1_DQS_AD3P_35 Sch=BTN3




## ChipKit Outer Digital Header
set_property -dict { PACKAGE_PIN T14   IOSTANDARD LVCMOS33 } [get_ports { sw[0]  }]; #IO_L5P_T0_34            Sch=CK_IO0
set_property -dict { PACKAGE_PIN U12   IOSTANDARD LVCMOS33 } [get_ports { sw[1]  }]; #IO_L2N_T0_34            Sch=CK_IO1
set_property -dict { PACKAGE_PIN U13   IOSTANDARD LVCMOS33 } [get_ports { sw[2]  }]; #IO_L3P_T0_DQS_PUDC_B_34 Sch=CK_IO2
set_property -dict { PACKAGE_PIN V13   IOSTANDARD LVCMOS33 } [get_ports { sw[3]  }]; #IO_L3N_T0_DQS_34        Sch=CK_IO3
#set_property -dict { PACKAGE_PIN V15   IOSTANDARD LVCMOS33 } [get_ports { ck_io4  }]; #IO_L10P_T1_34           Sch=CK_IO4
#set_property -dict { PACKAGE_PIN T15   IOSTANDARD LVCMOS33 } [get_ports { ck_io5  }]; #IO_L5N_T0_34            Sch=CK_IO5
#set_property -dict { PACKAGE_PIN R16   IOSTANDARD LVCMOS33 } [get_ports { ck_io6  }]; #IO_L19P_T3_34           Sch=CK_IO6
#set_property -dict { PACKAGE_PIN U17   IOSTANDARD LVCMOS33 } [get_ports { ck_io7  }]; #IO_L9N_T1_DQS_34        Sch=CK_IO7
#set_property -dict { PACKAGE_PIN V17   IOSTANDARD LVCMOS33 } [get_ports { ck_io8  }]; #IO_L21P_T3_DQS_34       Sch=CK_IO8
#set_property -dict { PACKAGE_PIN V18   IOSTANDARD LVCMOS33 } [get_ports { ck_io9  }]; #IO_L21N_T3_DQS_34       Sch=CK_IO9
#set_property -dict { PACKAGE_PIN T16   IOSTANDARD LVCMOS33 } [get_ports { ck_io10 }]; #IO_L9P_T1_DQS_34        Sch=CK_IO10
#set_property -dict { PACKAGE_PIN R17   IOSTANDARD LVCMOS33 } [get_ports { ck_io11 }]; #IO_L19N_T3_VREF_34      Sch=CK_IO11
#set_property -dict { PACKAGE_PIN P18   IOSTANDARD LVCMOS33 } [get_ports { ck_io12 }]; #IO_L23N_T3_34           Sch=CK_IO12
#set_property -dict { PACKAGE_PIN N17   IOSTANDARD LVCMOS33 } [get_ports { ck_io13 }]; #IO_L23P_T3_34           Sch=CK_IO13

## ChipKit Inner Digital Header
set_property -dict { PACKAGE_PIN U5    IOSTANDARD LVCMOS33 } [get_ports { bcd1[0] }]; #IO_L19N_T3_VREF_13  Sch=CK_IO26
set_property -dict { PACKAGE_PIN V5    IOSTANDARD LVCMOS33 } [get_ports { bcd1[1] }]; #IO_L6N_T0_VREF_13   Sch=CK_IO27
set_property -dict { PACKAGE_PIN V6    IOSTANDARD LVCMOS33 } [get_ports { bcd1[2] }]; #IO_L22P_T3_13       Sch=CK_IO28
set_property -dict { PACKAGE_PIN U7    IOSTANDARD LVCMOS33 } [get_ports { bcd1[3] }]; #IO_L11P_T1_SRCC_13  Sch=CK_IO29
set_property -dict { PACKAGE_PIN V7    IOSTANDARD LVCMOS33 } [get_ports { bcd2[0] }]; #IO_L11N_T1_SRCC_13  Sch=CK_IO30 
set_property -dict { PACKAGE_PIN U8    IOSTANDARD LVCMOS33 } [get_ports { bcd2[1] }]; #IO_L17N_T2_13       Sch=CK_IO31
set_property -dict { PACKAGE_PIN V8    IOSTANDARD LVCMOS33 } [get_ports { bcd2[2] }]; #IO_L15P_T2_DQS_13   Sch=CK_IO32
set_property -dict { PACKAGE_PIN V10   IOSTANDARD LVCMOS33 } [get_ports { bcd2[3] }]; #IO_L21N_T3_DQS_13   Sch=CK_IO33
#set_property -dict { PACKAGE_PIN W10   IOSTANDARD LVCMOS33 } [get_ports { ck_io34 }]; #IO_L16P_T2_13       Sch=CK_IO34
#set_property -dict { PACKAGE_PIN W6    IOSTANDARD LVCMOS33 } [get_ports { ck_io35 }]; #IO_L22N_T3_13       Sch=CK_IO35
#set_property -dict { PACKAGE_PIN Y6    IOSTANDARD LVCMOS33 } [get_ports { ck_io36 }]; #IO_L13N_T2_MRCC_13  Sch=CK_IO36
#set_property -dict { PACKAGE_PIN Y7    IOSTANDARD LVCMOS33 } [get_ports { ck_io37 }]; #IO_L13P_T2_MRCC_13  Sch=cCK_IO37
#set_property -dict { PACKAGE_PIN W8    IOSTANDARD LVCMOS33 } [get_ports { ck_io38 }]; #IO_L15N_T2_DQS_13   Sch=CK_IO38
#set_property -dict { PACKAGE_PIN Y8    IOSTANDARD LVCMOS33 } [get_ports { ck_io39 }]; #IO_L14N_T2_SRCC_13  Sch=CK_IO39
#set_property -dict { PACKAGE_PIN W9    IOSTANDARD LVCMOS33 } [get_ports { ck_io40 }]; #IO_L16N_T2_13       Sch=CK_IO40
#set_property -dict { PACKAGE_PIN Y9    IOSTANDARD LVCMOS33 } [get_ports { ck_io41 }]; #IO_L14P_T2_SRCC_13  Sch=CK_IO41
