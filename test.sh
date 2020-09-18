#!/bin/bash
vc -c99 +aos68k -I$NDK_INC -o window window.c -lamiga -lauto
