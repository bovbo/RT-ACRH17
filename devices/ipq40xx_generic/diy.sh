#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))
rm -rf feeds/routing/batman-adv

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ipq40xx target/linux/ipq40xx

sed -i "s/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=5.10/" target/linux/ipq40xx/Makefile
sed -i "s/KERNEL_TESTING_PATCHVER:=*.*/KERNEL_TESTING_PATCHVER:=5.10/g" target/linux/ipq40xx/Makefile

#sh -c "curl -sfL https://patch-diff.githubusercontent.com/raw/openwrt/openwrt/pull/10778.patch | git apply -p1"

sed -i 's/192.168.1.1/192.168.1.1/g' package/base-files/files/bin/config_generate
