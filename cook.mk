# Makefile to cook raw data into algorithm inputs (cooked data).
#
# Important: All targets should list the SOURCE FILE of any programs run in
# addition to the input data files. This will cause any update of the program
# source to regenerate any working files that depend on the program.
#
# Also add configuration files!
#
# A useful idiom is
#
# target: script input
# 	interpreter $^ $@
#
# Will invoke interpreter with the command line `interpreter script input target`
# which is often exactly what you want.
#
# TODO: Add a downloader/checker step to enable an empty start.

# Handy variable reference (to implement Don't Repeat Yourself)
# $@ -- name of the target
# $< -- name of the first prerequisite
# $^ -- name of all prerequisites, separated by spaces

# Presently, all data processing is done in one step in a single MATLAB command, so
# a Makefile to cook data is not necessary.

dummy:
	sleep 0

# if somehow you need java, then switch to -nodesktop -nosplash
# 

