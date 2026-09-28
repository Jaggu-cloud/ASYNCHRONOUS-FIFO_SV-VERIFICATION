vlib work
vlog tb.sv +acc
vsim -debugDB tb
add schematic -tb
add wave -r *
run -all
coverage report -details
