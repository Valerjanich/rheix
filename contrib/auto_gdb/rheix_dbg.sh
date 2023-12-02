#!/bin/bash
# use testnet settings,  if you need mainnet,  use ~/.rheixcore/rheixd.pid file instead
rheix_pid=$(<~/.rheixcore/testnet3/rheixd.pid)
sudo gdb -batch -ex "source debug.gdb" rheixd ${rheix_pid}
