CC = vc
CFLAGS = -c99 +aos68k -I$(INCLUDEOS3)
LDFLAGS = -lamiga -lauto

all:
	$(CC) $(CFLAGS) -o window window.c $(LDFLAGS)

clean:
	rm window