#!/bin/bash

set -e

MODE="$1"
PLUGIN_PATH="./InstrumentBB.dylib"  # 你自己写的 pass 插件路径
SRC_DIR=$(pwd)
OUT_EXEC="tmux_exec"

if [[ "$MODE" == "static" ]]; then
  echo "[*] Building tmux for static analysis..."
  export CC=wllvm
  export CXX=wllvm++
  export LLVM_COMPILER=clang

  make clean
  ./configure --disable-utf8proc
  make -j$(nproc)

  echo "[*] Extracting bitcode..."
  extract-bc -l /opt/homebrew/opt/llvm@16/bin/llvm-link ./tmux
  echo "[✓] Generated: tmux.bc"

elif [[ "$MODE" == "dynamic" ]]; then
  echo "[*] Building tmux with IR instrumentation pass..."
    
  export CC=clang
  export CXX=clang++
  unset CFLAGS
  unset CXXFLAGS


  make clean
  ./configure --disable-utf8proc
  
  echo "[*] Compiling with instrumentation..."
  make CFLAGS="-O0 -g -fpass-plugin=${PLUGIN_PATH}" -j$(nproc)

  mv ./tmux ./$OUT_EXEC
  echo "[✓] Built instrumented tmux: $OUT_EXEC"

else
  echo "Usage: $0 [static|dynamic]"
  exit 1
fi
