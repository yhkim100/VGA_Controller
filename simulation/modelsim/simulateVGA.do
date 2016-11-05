# Specify the VGA file you want to simulate
vsim work.myvga

# Restart the simulation, erase everything from previous simulation
restart -force -nowave

# Show number as Hex
radix unsigned

# Add all the signals in this entity
add wave *

# Add waves for specific component.
# If your VMEM is instantiated as vm0:
# add wave sim:/myvga/vm0/*

# Create a clock signal
force clk 1 0, 0 10 -repeat 20
# this statement says that you want to force the "clk" signal to 0 (at 0 time unit)
# then to 1 (at 10 time unit) and you want repeat this every 20 time units

# Force the reset signal to 0 at 100 time units
force rst 0 100

# Force the reset signal to 1 at time unit 10
force rst 1 150

# Force the reset signal back to 0 at time unit 20
force rst 0 200

# Run the simulation for 1e6 time units
run 1000000