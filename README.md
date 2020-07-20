为了尝试编译安卓内核, 我先后看了数篇教程, 全部存在Tutorial文件夹中.它们依次为

+ XDA 2017年的[「How to compile an Android kernel」](https://forum.xda-developers.com/android/software-hacking/reference-how-to-compile-android-kernel-t3627297#:~:text=%20%20%20%5BREFERENCE%5D%20How%20to%20compile%20an,will%20essentially%20turn%20on%20-Werror%2C%20causing...%20More%20)
  这是极客湾在打造最强掌机里贴出的帖子 

+ Makira咸鱼小站的[「迅速入门Android内核编译 & 一加5 DC调光」](https://makiras.org/archives/173)
  这是从酷安发现的. 中文, 非常棒

+ XDA 2018年的[「A Noob Guide On Building Your Own Custom Kernel on WIN10」](https://forum.xda-developers.com/android/software/guide-noob-guide-building-custom-kernel-t3775494)
  这篇文章让我确信了我编译失败和用win10的子系统没有关系

+ XDA 针对小米的[「How To Compile Kernel & DTBO For Redmi K20 Pro」](https://forum.xda-developers.com/k20-pro/how-to/guide-how-to-compile-kernel-redmi-k20-t3971443)
  就是看了它的reference, 我才发现了小米的官方教程

+ 小米官方的[「How to compile kernel standalone」](https://github.com/MiCode/Xiaomi_Kernel_OpenSource), 于[Xiaomi_Kernel_OpenSource.wiki](Tutorial/Xiaomi_Kernel_OpenSource.wiki)文件夹中
我很早就发现了小米官方的内核GitHub, 但找了一圈教程以后才发现再GitHub的Wiki里就有官方教程.

以下, 我已小米官方的教程为基础, 贴一遍代码, 并加上我的注释理解. 我编译的是mix2s(Polaris)的内核

编译内核需要在Linux系统中进行. 实体机虚拟机或者WSL( Windows Subsystem Linux)都是可以的.我一开始用的WSL Ubuntu编译, 失败了. 我以为是系统问题就换成了WSL Debian. [TODO]后来发现不是系统的问题, 下次试试再在WSL Ubuntu上编译一次.

用WSL的时候, **最好先切换成root身份!!** 这似乎是我一直编译失败的最主要的两个原因之一. [TODO]至少我还没有在非root身份下尝试过, 下次试试 似乎用实体机的Linux就不需要. 

首先, 安装环境.
```shell
sudo apt-get install git ccache automake flex lzop bison \
gperf build-essential zip curl zlib1g-dev zlib1g-dev:i386 \
g++-multilib python-networkx libxml2-utils bzip2 libbz2-dev \
libbz2-1.0 libghc-bzlib-dev squashfs-tools pngcrush \
schedtool dpkg-dev liblz4-tool make optipng maven libssl-dev \
pwgen libswitch-perl policycoreutils minicom libxml-sax-base-perl \
libxml-simple-perl bc libc6-dev-i386 lib32ncurses5-dev \
x11proto-core-dev libx11-dev lib32z-dev libgl1-mesa-dev xsltproc unzip
```
可能有几个包安装不了, 去掉就好.
其次, 获取内核文件. 我是直接在[小米GitHub开源内核网址](https://github.com/MiCode/Xiaomi_Kernel_OpenSource)上下载的zip包后解压, 当然也可以git clone.
文件中[Xiaomi_Kernel_OpenSource-polaris-o-oss.zip](https://github.com/MiCode/Xiaomi_Kernel_OpenSource/archive/polaris-o-oss.zip) 是小米官方的mix2s内核. polaris-o-oss中的O代表的是安卓O! 现在已经是2020年了! 但不知道为什么小米就是没有放出最新的内核.

接下来要获取GCC的交叉编译器. 我看了各个教程, 试了一堆编译器. 有arm的, 有Google的, 有民间开发的, 但是都没用. 其中, [谷歌官方最新的交叉编译器](Cross_Compile/aarch64-linux-android-4.9-refs_heads_master.tar.gz) 编译的时候报错没有文件"aarch64-linux-android-gcc". 再找到[有该文件的版本](Cross_Compile/aarch64-linux-android-4.9-refs_heads_android10-c2f2-release.tar.gz), 也没用. 又找到了[ARM官方最新的交叉编译器](https://developer.arm.com/-/media/Files/downloads/gnu-a/9.2-2019.12/binrel/gcc-arm-9.2-2019.12-x86_64-aarch64-none-linux-gnu.tar.xz?revision=61c3be5d-5175-4db6-9030-b565aae9f766&la=en&hash=0A37024B42028A9616F56A51C2D20755C5EBBCD7), 仍然没用.

事实证明, 没找到合适的编译器导致我一直编译失败的两个原因之二. 正确的做法是**下载老版本的编译器**. 使用了 [16年安卓O的编译器](Cross_Compile/aarch64-linux-android-4.9-d7d824eaa0690179c4b504209dbb017dfc730cf3.tar.gz)之后成功编译.

所以, 不能像小米教程中的一样, 直接
```shell
git clone https://android.googlesource.com/platform/prebuilts/gcc/linux-x86/aarch64/aarch64-linux-android-4.9 toolchain
```
但是这其中给的网址是正确的, 只不过要科学上网. 以上的文件都是在这里找到的.

新版编译器不能使用的原因似乎是Google从2020年1月开始不推荐使用gcc进行内核编译(似乎与gcc的GPL 2.0协定有关?).[TODO]接下来要试试使用Clang和LLVM编译了, 跟着小米的教程试试吧. [TODO]以及小米教程里提到的dtc和dts是个什么东西? 要研究研究.

内核和交叉编译器都下载, 解压好后, 进入内核的文件夹. 首先在环境变量中设定架构和交叉编译器的位置. export指令是一次性的, 就连重开窗口都会失效. mix2s是arm64架构的. 顺便一提, aarch64是armv8架构中64位的部分. 用来兼容armv7以及之前的32位的部分是aarch32.
```shell
export ARCH=arm64
export SUBARCH=arm64
export CROSS_COMPILE=<交叉编译器的位置>/bin/aarch64-linux-android-
```
注意, 交叉编译器的bin目录下有一堆以aarch64-linux-android-开头的文件(如之前提到的aarch64-linux-android-gcc), **所以指令中最后的小横杠不能省**.

为了将输出文件分开, 推荐``mkdir out``; 在编译之前如果不是第一次编译, 推荐 ``make clean && make mrproper``或者``make O=out clean && make O=out mrproper``. 当然, 删除out文件夹也是一个不错的选择. make这个指令可坑了, 不是-O而是O=, 用-O就会出错. 这个mrproper非常有意思，是英国的一个清洁剂品牌 Mr.Proper，美国是Mr.Clean.

正式开始编译:

```shell
make O=out <你的defconfig文件>
make -j$(nproc) O=out 2>&1 | tee kernel.log
```

defconfig文件是每个厂商对内核做出调整的配置文件. 其中, mix2s的defconfig文件在arch/arm64/configs/下, 名为polaris_user_defconfig. 所以刚才的指令为``make O=out polaris_user_defconfig``. 注意这里不用填写路径. 该文件夹下还有一个sdm845_defconfig和sdm845-perf_defconfig, 这应该是高通做的配置文件吧.
第二行的``-j$(nproc)``是指使用本机电脑最多的核心数, 我的电脑是4核的, 如果``echo $(nproc)``的话会显示4. 所以对我来说直接-j4也是可以的. 
如果不报错, 生成的内核会出现在out/arch/arm64/boot里, Makira咸鱼小站的教程里写用anykernel3做成zip包就好了.

[Boot文件夹](Boot)是编译成功后拷贝出来的包
