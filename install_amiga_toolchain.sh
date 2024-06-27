#!/bin/sh

# Set the project path to the current working directory
PROJECT_PATH="$PWD"

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

mkdir -p "$PROJECT_PATH/vbcc_tools"
mkdir -p "$PROJECT_PATH/vbcc"

cd "$PROJECT_PATH/vbcc_tools"

if ! wget -c http://sun.hasenbraten.de/vasm/release/vasm.tar.gz; then
  echo "Failed to download vasm.tar.gz"
  exit 1
fi

if ! wget -c http://sun.hasenbraten.de/vlink/release/vlink.tar.gz; then
  echo "Failed to download vlink.tar.gz"
  exit 1
fi

if ! wget -c http://www.ibaug.de/vbcc/vbcc.tar.gz; then
  echo "Failed to download vbcc.tar.gz"
  exit 1
fi

if ! wget -c http://phoenix.owl.de/vbcc/current/vbcc_target_m68k-amigaos.lha; then
  echo "Failed to download vbcc_target_m68k-amigaos.lha"
  exit 1
fi

if ! wget -c http://phoenix.owl.de/vbcc/current/vbcc_unix_config.tar.gz; then
  echo "Failed to download vbcc_unix_config.tar.gz"
  exit 1
fi

tar zxvf vbcc.tar.gz
cd vbcc

if [ ! -d bin ]; then
  mkdir bin
fi

make TARGET=m68k
cp -r bin "$PROJECT_PATH/vbcc/"

cd ..

lha x vbcc_target_m68k-amigaos.lha
cp -r vbcc_target_m68k-amigaos/* "$PROJECT_PATH/vbcc/"

cd "$PROJECT_PATH/vbcc"
tar zxvf "$PROJECT_PATH/vbcc_tools/vbcc_unix_config.tar.gz"

export VBCC="$PROJECT_PATH/vbcc"
export PATH="$VBCC/bin:$PATH"

cd "$PROJECT_PATH/vbcc_tools"

tar zxvf vasm.tar.gz
cd vasm
make CPU=m68k SYNTAX=mot
cp vasmm68k_mot vobjdump "$VBCC/bin"

cd ..

tar zxvf vlink.tar.gz
cd vlink
make
cp vlink "$VBCC/bin"

cd "$VBCC"

if [ ! -d NDK_3.2 ]; then
  mkdir NDK_3.2
fi

cd NDK_3.2

if ! wget -c http://aminet.net/dev/misc/NDK3.2.lha; then
  echo "Failed to download NDK3.2.lha"
  exit 1
fi

lha x NDK3.2.lha

cd ..
cp -r $VBCC/NDK_3.2/Include_[Hh]/* "$VBCC/targets/m68k-amigaos/include"

rm -rf "$PROJECT_PATH/vbcc_tools/"
