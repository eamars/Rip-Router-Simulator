# Author: 		Ran Bao
# Date:			1/March/2015
# Description:	Makefile config

# Define compilers and other flags
CC = cc
CFLAGS = -Os -Wall -Wstrict-prototypes -Wextra -Wno-unneeded-internal-declaration -g -std=c99 -D_BSD_SOURCE
LIBS =
DEL = rm


all: router.out

# Compile
router.o: router.c config.h list.h pidlock.h route_table.h
	$(CC) -c $(CFLAGS) $(LIBS) $< -o $@

config.o: config.c config.h
	$(CC) -c $(CFLAGS) $(LIBS) $< -o $@

list.o: list.c list.h
	$(CC) -c $(CFLAGS) $(LIBS) $< -o $@

pidlock.o: pidlock.c pidlock.h
	$(CC) -c $(CFLAGS) $(LIBS) $< -o $@

router_demon.o: router_demon.c route_table.h rip_message.h
	$(CC) -c $(CFLAGS) $(LIBS) $< -o $@

route_table.o: route_table.c route_table.h
	$(CC) -c $(CFLAGS) $(LIBS) $< -o $@

rip_message.o: rip_message.c rip_message.h
	$(CC) -c $(CFLAGS) $(LIBS) $< -o $@


# Link
router.out: router.o config.o list.o pidlock.o router_demon.o \
		rip_message.o route_table.o
	$(CC) $(CFLAGS) $(LIBS) $^ -o $@

.PHONY: clean
clean:
	-$(DEL) *.o *.out
