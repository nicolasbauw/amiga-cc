#!/bin/sh

if ! command -v wget &> /dev/null
then
    echo "Please install wget !"
    exit
fi

if ! command -v lha &> /dev/null
then
    echo "Please install an lha decompressor !"
    exit
fi

mkdir vbcc_tools
mkdir vbcc
cd vbcc_tools

wget http://sun.hasenbraten.de/vasm/release/vasm.tar.gz
wget http://sun.hasenbraten.de/vlink/release/vlink.tar.gz
wget http://www.ibaug.de/vbcc/vbcc.tar.gz
wget http://phoenix.owl.de/vbcc/current/vbcc_target_m68k-amigaos.lha
wget http://phoenix.owl.de/vbcc/current/vbcc_unix_config.tar.gz

tar zxvf vbcc.tar.gz
cd vbcc
if [ ! -d bin ]; then
    mkdir bin
fi
make TARGET=m68k
cp -r bin ../../vbcc/

cd ..
lha x vbcc_target_m68k-amigaos.lha
cp -r vbcc_target_m68k-amigaos/* ../vbcc/

cd ../vbcc
tar zxvf ../vbcc_tools/vbcc_unix_config.tar.gz

export VBCC=~/amiga-cc/vbcc/
export PATH=$VBCC/bin:$PATH

cd ../vbcc_tools
tar zxvf vasm.tar.gz
cd vasm
make CPU=m68k SYNTAX=mot
cp vasmm68k_mot vobjdump $VBCC/bin

cd ..
tar zxvf vlink.tar.gz
cd vlink
make
cp vlink $VBCC/bin

cd $VBCC
if [ ! -d NDK_3.2 ]; then
    mkdir NDK_3.2
fi
cd NDK_3.2
wget http://aminet.net/dev/misc/NDK3.2.lha
lha x NDK3.2.lha
cd ..
cp -r $VBCC/NDK_3.2/Include_h/* $VBCC/targets/m68k-amigaos/include
rm -rf $VBCC/NDK_3.2/
rm -rf ~/amiga-cc/vbcc_tools/
