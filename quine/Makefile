# change these next two variables as needed:
CROSS = /usr/local/csl/arm-2008q3/bin/arm-none-linux-gnueabi-
REMOTE = root@128.247.79.99

##############################################

AS = $(CROSS)gcc

ALL = quine-0 quine-1 quine-1.S quine-2.S

all: $(ALL)

clean:
	rm -f $(ALL)

quine-0: quine-0.S
	$(AS) quine-0.S -o quine-0

quine-1: quine-1.S
	$(AS) quine-1.S -o quine-1

quine-1.S: quine-0
	scp quine-0 $(REMOTE):/tmp/quine-0
	ssh $(REMOTE) /tmp/quine-0 > quine-1.S

quine-2.S: quine-1
	scp quine-1 $(REMOTE):/tmp/quine-1
	ssh $(REMOTE) /tmp/quine-1 > quine-2.S

