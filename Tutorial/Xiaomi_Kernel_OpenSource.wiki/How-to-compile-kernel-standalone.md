> Host: ubuntu 18.04

> Phone: Xiaomi Max 3

> Toolchain used: aarch64-linux-android-4.9 from google

Setup Build Environment
My environment for build aosp and debug, not only for kernel

```
sudo apt-get install git ccache automake flex lzop bison \
gperf build-essential zip curl zlib1g-dev zlib1g-dev:i386 \
g++-multilib python-networkx libxml2-utils bzip2 libbz2-dev \
libbz2-1.0 libghc-bzlib-dev squashfs-tools pngcrush \
schedtool dpkg-dev liblz4-tool make optipng maven libssl-dev \
pwgen libswitch-perl policycoreutils minicom libxml-sax-base-perl \
libxml-simple-perl bc libc6-dev-i386 lib32ncurses5-dev \
x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev xsltproc unzip
```


Next , let us compile kernel

For non-dtbo such as Max3
```
$ git clone --depth=1 https://github.com/MiCode/Xiaomi_Kernel_OpenSource.git -b nitrogen-o-oss nitrogen-o-oss
$ cd nitrogen-o-oss
$ git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 toolchain
$ mkdir out
$ export ARCH=arm64
$ export SUBARCH=arm64
$ export CROSS_COMPILE=${PWD}/toolchain/bin/aarch64-linux-android-
```
```
make O=out nitrogen_user_defconfig
make -j$(nproc) O=out 2>&1 | tee kernel.log
```

For include-dtbo, such as Mix 3

dtc must be from aosp source code（pie-release）


```
$ git clone --depth=1 https://github.com/MiCode/Xiaomi_Kernel_OpenSource.git -b perseus-p-oss perseus-p-oss
$ cd perseus-p-oss
$ git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 toolchain
$ mkdir out
$ export ARCH=arm64
$ export SUBARCH=arm64
$ export DTC_EXT=dtc
$ export CROSS_COMPILE=${PWD}/toolchain/bin/aarch64-linux-android-
```

Set [CONFIG_BUILD_ARM64_DT_OVERLAY=y](https://github.com/MiCode/Xiaomi_Kernel_OpenSource/blob/perseus-p-oss/arch/arm64/configs/perseus_user_defconfig#L718)

```
make O=out perseus_user_defconfig
make -j$(nproc) O=out 2>&1 | tee kernel.log
```

For msm-4.14  like Mi 9

dtc must be from aosp source code（pie-release）
Clang from qcom

```
$ git clone --depth=1 https://github.com/MiCode/Xiaomi_Kernel_OpenSource.git -b cepheus-p-oss cepheus-p-oss
$ cd cepheus-p-oss
$ git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 toolchain
```
You must get llvm clang from qcom.
link: https://developer.qualcomm.com/download/sdllvm/snapdragon-llvm-compiler-android-linux64-609.tar.gz

```
$ tar vxzf snapdragon-llvm-compiler-android-linux64-609.tar.gz
$ mkdir out
$ export ARCH=arm64
$ export SUBARCH=arm64
$ export DTC_EXT=dtc
$ export CROSS_COMPILE=${PWD}/toolchain/bin/aarch64-linux-android-
Set CONFIG_BUILD_ARM64_DT_OVERLAY=y
```
```
make O=out REAL_CC=${PWD}/toolchains/llvm-Snapdragon_LLVM_for_Android_6.0/prebuilt/linux-x86_64/bin/clang CLANG_TRIPLE=aarch64-linux-gnu- cepheus_user_defconfig
make -j$(nproc) O=out REAL_CC=${PWD}/toolchains/llvm-Snapdragon_LLVM_for_Android_6.0/prebuilt/linux-x86_64/bin/clang CLANG_TRIPLE=aarch64-linux-gnu- 2>&1 | tee kernel.log
```

_**For violet-p-oss, make vendor/violet-perf_defconfig instead of make violet-perf_defconfig**_

After that, you can find many compiled files in the out directory.
You can find the kernel in this directory.
`out/arch/arm64/boot`

If you want to flash this,you must unpack boot.img,replace kernel, repack boot.img.
Some device need dtbo.img, so you must repack dtbo.img.

###  NOTE:If your compiled kernel cannot boot, pls use clang >= 6.0.9

Here we focus only on compiling the kernel.
Please go to xda or Google search how to repack boot.img and repack dtbo.img

Sometimes, you need compile wlan and audio(sdm845) modules if you find wifi and audio not work after flashing boot.img

maybe some of you face compile error like this
` error: msm_isp.h: No such file or directory`

In android source code (caf), It is already setup environment. like O=out/target/product/{TARGET_PRODUCT}/obj/kernel/,  toolchain=   ARCH=arm64/arm/x86/mips

it's not a problem with kernel at all!
This can be fixed by redirecting output to a out folder as done in steps above

# About LLVM tools
Android Q, Qcom platform , We use snapdragon-llvm-compiler-android 8.0 or later that get it from the link.
https://developer.qualcomm.com/software/snapdragon-llvm-compiler-android/tools

# How to Get Help ?

If you follow this guide and still got some errors and you know that this is the problem with kernel than make a issue with link to your kernel.log file ( you'll find it in your kernel directory ), you can use any paste services to upload it like
https://pastebin.com