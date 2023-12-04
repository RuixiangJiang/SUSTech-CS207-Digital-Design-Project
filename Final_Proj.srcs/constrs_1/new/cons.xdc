set_property IOSTANDARD LVCMOS33 [get_ports rx]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports sys_clk]
set_property IOSTANDARD LVCMOS33 [get_ports tx]



set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets clk_out]

set_property PACKAGE_PIN N5 [get_ports rx]
set_property PACKAGE_PIN P17 [get_ports sys_clk]
set_property PACKAGE_PIN U3 [get_ports rst]
set_property PACKAGE_PIN T4 [get_ports tx]

set_property PACKAGE_PIN H4 [get_ports front_detector]
set_property PACKAGE_PIN J3 [get_ports back_detector]
set_property PACKAGE_PIN J2 [get_ports left_detector]
set_property PACKAGE_PIN K2 [get_ports right_detector]
set_property PACKAGE_PIN P3 [get_ports move_backward_signal]
set_property PACKAGE_PIN P4 [get_ports move_forward_signal]
set_property PACKAGE_PIN V1 [get_ports turn_left_signal]
set_property PACKAGE_PIN R11 [get_ports turn_right_signal]
set_property PACKAGE_PIN P2 [get_ports brake_signal]
set_property PACKAGE_PIN R1 [get_ports throttle_signal]
set_property PACKAGE_PIN N4 [get_ports clutch_signal]
set_property PACKAGE_PIN V5 [get_ports manual_driving]
set_property PACKAGE_PIN V4 [get_ports semi_auto_driving]
set_property PACKAGE_PIN R3 [get_ports auto_driving]

set_property PACKAGE_PIN U4 [get_ports  Poweron_signal]
set_property PACKAGE_PIN K3 [get_ports  Led_power]
set_property PACKAGE_PIN R17 [get_ports  Poweroff_signal]
set_property PACKAGE_PIN R15 [get_ports  go_straight_signal]

set_property IOSTANDARD LVCMOS33 [get_ports go_straight_signal]
set_property IOSTANDARD LVCMOS33 [get_ports Led_power]
set_property IOSTANDARD LVCMOS33 [get_ports Poweroff_signal]
set_property IOSTANDARD LVCMOS33 [get_ports Poweron_signal]
set_property IOSTANDARD LVCMOS33 [get_ports manual_driving]
set_property IOSTANDARD LVCMOS33 [get_ports semi_auto_driving]
set_property IOSTANDARD LVCMOS33 [get_ports auto_driving]

set_property IOSTANDARD LVCMOS33 [get_ports clutch_signal]
set_property IOSTANDARD LVCMOS33 [get_ports brake_signal]
set_property IOSTANDARD LVCMOS33 [get_ports throttle_signal]

set_property IOSTANDARD LVCMOS33 [get_ports turn_left_signal]
set_property IOSTANDARD LVCMOS33 [get_ports turn_right_signal]
set_property IOSTANDARD LVCMOS33 [get_ports back_detector]
set_property IOSTANDARD LVCMOS33 [get_ports front_detector]
set_property IOSTANDARD LVCMOS33 [get_ports left_detector]
set_property IOSTANDARD LVCMOS33 [get_ports move_backward_signal]
set_property IOSTANDARD LVCMOS33 [get_ports move_forward_signal]
set_property IOSTANDARD LVCMOS33 [get_ports right_detector]

set_property PACKAGE_PIN R2 [get_ports place_barrier_signal]
set_property IOSTANDARD LVCMOS33 [get_ports place_barrier_signal]

set_property PACKAGE_PIN M4 [get_ports destroy_barrier_signal]
set_property IOSTANDARD LVCMOS33 [get_ports destroy_barrier_signal]

set_property PACKAGE_PIN H5 [get_ports ledL]
set_property IOSTANDARD LVCMOS33 [get_ports ledL]
set_property PACKAGE_PIN K1 [get_ports ledR]
set_property IOSTANDARD LVCMOS33 [get_ports ledR]


set_property PACKAGE_PIN M1 [get_ports led_testflash]
set_property IOSTANDARD LVCMOS33 [get_ports led_testflash]


set_property PACKAGE_PIN G2 [get_ports an[7]]
set_property IOSTANDARD LVCMOS33 [get_ports an[7]]
set_property PACKAGE_PIN C2 [get_ports an[6]]
set_property IOSTANDARD LVCMOS33 [get_ports an[6]]
set_property PACKAGE_PIN C1 [get_ports an[5]]
set_property IOSTANDARD LVCMOS33 [get_ports an[5]]
set_property PACKAGE_PIN H1 [get_ports an[4]]
set_property IOSTANDARD LVCMOS33 [get_ports an[4]]
set_property PACKAGE_PIN G1 [get_ports an[3]]
set_property IOSTANDARD LVCMOS33 [get_ports an[3]]
set_property PACKAGE_PIN F1 [get_ports an[2]]
set_property IOSTANDARD LVCMOS33 [get_ports an[2]]
set_property PACKAGE_PIN E1 [get_ports an[1]]
set_property IOSTANDARD LVCMOS33 [get_ports an[1]]
set_property PACKAGE_PIN G6 [get_ports an[0]]
set_property IOSTANDARD LVCMOS33 [get_ports an[0]]

set_property PACKAGE_PIN B4 [get_ports {seg[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[7]}]
set_property PACKAGE_PIN A4 [get_ports {seg[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[6]}]
set_property PACKAGE_PIN A3 [get_ports {seg[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[5]}]
set_property PACKAGE_PIN B1 [get_ports {seg[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[4]}]
set_property PACKAGE_PIN A1 [get_ports {seg[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[3]}]
set_property PACKAGE_PIN B3 [get_ports {seg[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[2]}]
set_property PACKAGE_PIN B2 [get_ports {seg[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[1]}]
set_property PACKAGE_PIN D5 [get_ports {seg[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg[0]}]

set_property PACKAGE_PIN D4 [get_ports {seg1[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[7]}]
set_property PACKAGE_PIN E3 [get_ports {seg1[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[6]}]
set_property PACKAGE_PIN D3 [get_ports {seg1[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[5]}]
set_property PACKAGE_PIN F4 [get_ports {seg1[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[4]}]
set_property PACKAGE_PIN F3 [get_ports {seg1[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[3]}]
set_property PACKAGE_PIN E2 [get_ports {seg1[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[2]}]
set_property PACKAGE_PIN D2 [get_ports {seg1[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[1]}]
set_property PACKAGE_PIN H2 [get_ports {seg1[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {seg1[0]}]

set_property PACKAGE_PIN T1 [get_ports beep]
set_property IOSTANDARD LVCMOS33 [get_ports beep]
