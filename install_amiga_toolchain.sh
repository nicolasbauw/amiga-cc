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
wget http://www.haage-partner.de/download/AmigaOS/NDK39.lha
lha x NDK39.lha
cp -r $VBCC/NDK_3.9/Include/include_h/* $VBCC/targets/m68k-amigaos/include
rm -rf $VBCC/NDK_3.9/
rm -rf $VBCC/ndk_3.9/
rm $VBCC/Install
rm $VBCC/Install.info
rm NDK_3.9.info NDK39.lha
cd ..
rm -rf vbcc_tools