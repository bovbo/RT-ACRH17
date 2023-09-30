#!/bin/bash

shopt -s extglob

SHELL_FOLDER=$(dirname $(readlink -f "$0"))
rm -rf feeds/routing/batman-adv

svn co https://github.com/coolsnowwolf/lede/trunk/target/linux/ipq40xx target/linux/ipq40xx

sed -i "s/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=5.10/" target/linux/ipq40xx/Makefile
sed -i "s/KERNEL_TESTING_PATCHVER:=*.*/KERNEL_TESTING_PATCHVER:=5.10/g" target/linux/ipq40xx/Makefile

#sh -c "curl -sfL https://patch-diff.githubusercontent.com/raw/openwrt/openwrt/pull/10778.patch | git apply -p1"
svn co https://github.com/jerrykuku/luci-app-vssr/trunk package/luci-app-vssr
sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate
sed -i "s/192.168.1/192.168.8.1/" package/feeds/kiddin9/base-files/files/bin/config_generate
# 取消bootstrap为默认主题
sed -i '/set luci.main.mediaurlbase=\/luci-static\/bootstrap/d' feeds/luci/themes/luci-theme-bootstrap/root/etc/uci-defaults/30_luci-theme-bootstrap
#5.更换lede源码中自带argon主题
rm -rf feeds/luci/themes/luci-theme-argon && git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git feeds/luci/themes/luci-theme-argon
#2. web登陆密码从password修改为空
sed -i 's/$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.//g' openwrt/package/lean/default-settings/files/zzz-default-settings
#7.修改主机名
sed -i "s/hostname='OpenWrt'/hostname='asus_rt-acrh17'/g" package/base-files/files/bin/config_generate
git clone https://github.com/sbwml/luci-app-mosdns -b v5 package/mosdns
git clone https://github.com/sbwml/v2ray-geodata package/v2ray-geodata
