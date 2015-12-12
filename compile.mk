# Compile third party libraries

# exclude blossom for now
#TARGETS = QPBO blossom csapp JustinsGraphicalModelsToolboxPublic l1graph l1_logreg
TARGETS = QPBO pmtk3

all: $(TARGETS)
.PHONY: $(TARGETS)

# Recursive Make
QPBO:
	$(MAKE) -C thirdparty/QPBO-v1.32.src

pmtk3:
	matlab -nojvm -r "startup; cd thirdparty/pmtk3-master; initPmtk3; exit"

