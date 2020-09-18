#!/bin/bash
mkdir vbcc_tools
mkdir -p amiga_sdk/vbcc
cd vbcc_tools

wget http://sun.hasenbraten.de/vasm/release/vasm.tar.gz
wget http://sun.hasenbraten.de/vlink/release/vlink.tar.gz
wget http://www.ibaug.de/vbcc/vbcc.tar.gz
wget http://phoenix.owl.de/vbcc/current/vbcc_target_m68k-amigaos.lha
wget https://server.owl.de/~frank/vbcc/2019-10-04/vbcc_unix_config.tar.gz

tar zxvf vbcc.tar.gz
cd vbcc
mkdir bin
make TARGET=m68k
cp -r bin ../../amiga_sdk/vbcc/

cd ..
lha x vbcc_target_m68k-amigaos.lha
cp -r vbcc_target_m68k-amigaos/* ../amiga_sdk/vbcc/

cd ../amiga_sdk/vbcc
tar zxvf ../../vbcc_tools/vbcc_unix_config.tar.gz

export VBCC=~/Amiga-cc/amiga_sdk/vbcc/
export PATH=$VBCC/bin:$PATH

cd ../../vbcc_tools
tar zxvf vasm.tar.gz
cd vasm
make CPU=m68k SYNTAX=mot
cp vasmm68k_mot vobjdump $VBCC/bin

cd ..
tar zxvf vlink.tar.gz
cd vlink
make
cp vlink $VBCC/bin

cd ../../amiga_sdk
wget http://www.haage-partner.de/download/AmigaOS/NDK39.lha
lha x NDK39.lha
export NDK_INC=~/Amiga-cc/amiga_sdk/NDK_3.9/Include/include_h/
