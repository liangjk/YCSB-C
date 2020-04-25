CC=g++
CFLAGS=-std=c++11 -g -Wall -pthread -I./ -L../rocksdb
LDFLAGS= -lpthread -ltbb -lhiredis -lrocksdb -ldl
SUBDIRS=core db redis
SUBSRCS=$(wildcard core/*.cc) $(wildcard db/*.cc)
OBJECTS=$(SUBSRCS:.cc=.o)
EXEC=ycsbc

all: $(SUBDIRS) $(EXEC)

$(SUBDIRS):
	$(MAKE) -C $@

$(EXEC): $(wildcard *.cc) $(OBJECTS)
	$(CC) $(CFLAGS) $^ $(LDFLAGS) -o $@

clean:
	for dir in $(SUBDIRS); do \
		$(MAKE) -C $$dir $@; \
	done
	$(RM) $(EXEC)
	-rm -rf rocksdb_test

.PHONY: $(SUBDIRS) $(EXEC)
