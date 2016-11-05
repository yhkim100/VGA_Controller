transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Young-hoon\ Kim/Desktop/ECE550/HW2/vgacontroller_restored/db {C:/Users/Young-hoon Kim/Desktop/ECE550/HW2/vgacontroller_restored/db/pll_altpll.v}
vcom -93 -work work {C:/Users/Young-hoon Kim/Desktop/ECE550/HW2/vgacontroller_restored/myvga.vhdl}
vcom -93 -work work {C:/Users/Young-hoon Kim/Desktop/ECE550/HW2/vgacontroller_restored/vmem.vhd}
vcom -93 -work work {C:/Users/Young-hoon Kim/Desktop/ECE550/HW2/vgacontroller_restored/counter_single_dff.vhd}
vcom -93 -work work {C:/Users/Young-hoon Kim/Desktop/ECE550/HW2/vgacontroller_restored/HFSM.vhd}
vcom -93 -work work {C:/Users/Young-hoon Kim/Desktop/ECE550/HW2/vgacontroller_restored/HFSM_next_state_logic.vhd}
vcom -93 -work work {C:/Users/Young-hoon Kim/Desktop/ECE550/HW2/vgacontroller_restored/VFSM.vhd}
vcom -93 -work work {C:/Users/Young-hoon Kim/Desktop/ECE550/HW2/vgacontroller_restored/VFSM_next_state_logic.vhd}
vcom -93 -work work {C:/Users/Young-hoon Kim/Desktop/ECE550/HW2/vgacontroller_restored/sync_HC_VC.vhd}
vcom -93 -work work {C:/Users/Young-hoon Kim/Desktop/ECE550/HW2/vgacontroller_restored/counter_10_bit.vhd}
vcom -93 -work work {C:/Users/Young-hoon Kim/Desktop/ECE550/HW2/vgacontroller_restored/counter_19_bit.vhd}

