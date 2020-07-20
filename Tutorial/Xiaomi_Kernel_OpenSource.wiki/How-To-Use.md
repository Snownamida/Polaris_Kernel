## Contents

1. <a href="#env">Setup Build Environment</a>
1. <a href="#jdk">Download JDK</a>
1. <a href="#merge">Merge Linux Kernel Into QAEP</a>
1. <a href="#build">Build Kernel</a>
1. <a href="#flash">Flash and Test</a>

<a name='env'/>
## Setup Build Environment

####Clone repository 
You can clone this repository to your local computer by typing command:

```bash
~/Mi_Kernel$ git clone git@github.com:MiCode/Xiaomi_Kernel_OpenSource.git
```

####Check your branch and tag
This repository have branches for different Xiaomi Phone platform. For example, Mi4's branch is `cancro-kk-oss`, then check this branch out.

```bash
~/Mi_Kernel$ git checkout cancro-kk-oss
```

And then get release tag in git log. Normally it should be in the lastest log.

```bash
~/Mi_Kernel$ git log
```

For `cancro-kk-oss`, the tag is `LNX.LA.3.5.2.2.1-04310-8x74.0`

#### Download Qualcomm Android Enablement Project
Acutally, this step is optional. But this project integrates many tools such as cross compiler which are required for building our kernel. Of course you can use your own tools to compile kernel, but it may be a tough work to configure.

You can download the whole QAEP on [Codeaurora](https://www.codeaurora.org/xwiki/bin/QAEP/)

```bash
$ repo init -u git://codeaurora.org/platform/manifest.git -b [branch] -m [manifest] --repo-url=git://codeaurora.org/tools/repo.git --repo-branch=caf-stable
```

Where branch is list in the Codeaurora web page, usually it should be `release`. And manifest is usually `$tag.xml`, On `cancro-kk-oss` branch, the command should be 

```bash
~/Qualcomm_Android$ repo init -u git://codeaurora.org/platform/manifest.git -b release -m LNX.LA.3.5.2.2.1-04310-8x74.0.xml --repo-url=git://codeaurora.org/tools/repo.git --repo-branch=caf-stable
```

And then execute this command to start syncronization.

```bash
~/Qualcomm_Android$ repo sync -j8
```

__FYI: This repository is relatively big. You may need hours to download it__.

<a name='jdk'/>
## Download JDK
Java Develop Kit is required for building Android project. You can refer to this [link](https://source.android.com/source/initializing.html#installing-the-jdk).

__FYI: Qualcomm Android Enablement Project(QAEP) only supports Sun/Oracle JDK, you can only download it from this [link](http://www.oracle.com/technetwork/java/javasebusiness/downloads/java-archive-downloads-javase6-419409.html#jdk-6u45-oth-JPR) rather than using `apt-get`__

<a name='merge'/>
## Merge Linux kernel into QAEP

#### Merge kernel by replacing the whole kernel folder

```bash
~/Qualcomm_Android$ rm -rf kernel/*
~/Qualcomm_Android$ cp -rf ~/Mi_Kernel/Xiaomi_Kernel_OpenSource/* kernel/
```

#### Change KERNEL_DEFCONFIG
You need change KERNEL_DEFCONFIG variable to our production defconfig file:

You could do this by editing `device/qcom/msm8974/AndroidBoard.mk`, in line 21 change
```bash
#----------------------------------------------------------------------
# Compile Linux Kernel
#----------------------------------------------------------------------
ifeq ($(KERNEL_DEFCONFIG),)
    KERNEL_DEFCONFIG := msm8974_defconfig
endif
```

into

```bash
#----------------------------------------------------------------------
# Compile Linux Kernel
#----------------------------------------------------------------------
ifeq ($(KERNEL_DEFCONFIG),)
    ifeq ($(TARGET_BUILD_VARIANT),eng)
        KERNEL_DEFCONFIG := cancro_debug_defconfig
    else
        KERNEL_DEFCONFIG := cancro_user_defconfig
    endif
endif
```

<a name='build'/>
## Build Kernel

After all steps above is done, you can finally build the kernel. For Mi4 cancro in this example you can do this:
```bash
#generate git patch
~/Qualcomm_Android$ source build/envsetup.sh
~/Qualcomm_Android$ lunch msm8974-userdebug
~/Qualcomm_Android$ make bootimage -j4
```

<a name='flash'/>
## Flash and Test

Now if everything goes well, you will have a `boot.img` file in `out/target/product/msm8974`.

You can flash this image into Mi4. Now you can connect Mi4 to usb and press power key and volumn_down key to enter fastboot mode. And then execute this command

```bash
#generate git patch
~/Qualcomm_Android$ fastboot flash boot out/target/product/msm8974/boot.img
~/Qualcomm_Android$ fastboot reboot
```

Now here we go! You can then use `adb` to debug linux now.