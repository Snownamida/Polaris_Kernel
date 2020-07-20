cmd_arch/arm64/boot/dts/qcom/sdm845-v2-cdp.dtb := mkdir -p arch/arm64/boot/dts/qcom/ ; ../scripts/gcc-wrapper.py /home/snowtear/kernel/toolchain/bin/aarch64-linux-android-gcc -E -Wp,-MD,arch/arm64/boot/dts/qcom/.sdm845-v2-cdp.dtb.d.pre.tmp -nostdinc -I../arch/arm64/boot/dts -I../arch/arm64/boot/dts/include -I../drivers/of/testcase-data -undef -D__DTS__ -x assembler-with-cpp -o arch/arm64/boot/dts/qcom/.sdm845-v2-cdp.dtb.dts.tmp ../arch/arm64/boot/dts/qcom/sdm845-v2-cdp.dts ; ./scripts/dtc/dtc -O dtb -o arch/arm64/boot/dts/qcom/sdm845-v2-cdp.dtb -b 0 -i ../arch/arm64/boot/dts/qcom/ -Wno-unit_address_vs_reg -d arch/arm64/boot/dts/qcom/.sdm845-v2-cdp.dtb.d.dtc.tmp arch/arm64/boot/dts/qcom/.sdm845-v2-cdp.dtb.dts.tmp ; cat arch/arm64/boot/dts/qcom/.sdm845-v2-cdp.dtb.d.pre.tmp arch/arm64/boot/dts/qcom/.sdm845-v2-cdp.dtb.d.dtc.tmp > arch/arm64/boot/dts/qcom/.sdm845-v2-cdp.dtb.d

source_arch/arm64/boot/dts/qcom/sdm845-v2-cdp.dtb := ../arch/arm64/boot/dts/qcom/sdm845-v2-cdp.dts

deps_arch/arm64/boot/dts/qcom/sdm845-v2-cdp.dtb := \
  ../arch/arm64/boot/dts/qcom/sdm845-v2.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845.dtsi \
  ../arch/arm64/boot/dts/qcom/skeleton64.dtsi \
  ../arch/arm64/boot/dts/include/dt-bindings/clock/qcom,gcc-sdm845.h \
  ../arch/arm64/boot/dts/include/dt-bindings/clock/qcom,camcc-sdm845.h \
  ../arch/arm64/boot/dts/include/dt-bindings/clock/qcom,dispcc-sdm845.h \
  ../arch/arm64/boot/dts/include/dt-bindings/clock/qcom,gpucc-sdm845.h \
  ../arch/arm64/boot/dts/include/dt-bindings/clock/qcom,videocc-sdm845.h \
  ../arch/arm64/boot/dts/include/dt-bindings/clock/qcom,cpucc-sdm845.h \
  ../arch/arm64/boot/dts/include/dt-bindings/clock/qcom,rpmh.h \
  ../arch/arm64/boot/dts/include/dt-bindings/clock/qcom,aop-qmp.h \
  ../arch/arm64/boot/dts/include/dt-bindings/regulator/qcom,rpmh-regulator.h \
  ../arch/arm64/boot/dts/include/dt-bindings/interrupt-controller/arm-gic.h \
  ../arch/arm64/boot/dts/include/dt-bindings/interrupt-controller/irq.h \
  ../arch/arm64/boot/dts/include/dt-bindings/soc/qcom,tcs-mbox.h \
  ../arch/arm64/boot/dts/include/dt-bindings/spmi/spmi.h \
  ../arch/arm64/boot/dts/include/dt-bindings/thermal/thermal.h \
  ../arch/arm64/boot/dts/include/dt-bindings/msm/msm-bus-ids.h \
    $(wildcard include/config/noc.h) \
  ../arch/arm64/boot/dts/include/dt-bindings/soc/qcom,dcc_v2.h \
  ../arch/arm64/boot/dts/qcom/msm-gdsc-sdm845.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-sde-pll.dtsi \
  ../arch/arm64/boot/dts/qcom/msm-rdbg.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-sde.dtsi \
  ../arch/arm64/boot/dts/include/dt-bindings/clock/mdss-10nm-pll-clk.h \
  ../arch/arm64/boot/dts/qcom/sdm845-qupv3.dtsi \
  ../arch/arm64/boot/dts/qcom/pm8998.dtsi \
  ../arch/arm64/boot/dts/include/dt-bindings/msm/power-on.h \
  ../arch/arm64/boot/dts/qcom/pm8005.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-regulator.dtsi \
  ../arch/arm64/boot/dts/include/dt-bindings/gpio/gpio.h \
  ../arch/arm64/boot/dts/qcom/sdm845-coresight.dtsi \
  ../arch/arm64/boot/dts/qcom/msm-arm-smmu-sdm845.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-ion.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-smp2p.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-camera.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-bus.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-vidc.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-pm.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-pinctrl.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-pcie.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-audio.dtsi \
  ../arch/arm64/boot/dts/qcom/msm-audio-lpass.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-gpu.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-670-usb-common.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-v2-camera.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-sde-display.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-sim-video.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-sim-cmd.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-sim-dsc375-cmd.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-sim-dualmipi-video.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-sim-dualmipi-cmd.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-sim-dualmipi-dsc375-cmd.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-sharp-dsc-4k-video.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-sharp-dsc-4k-cmd.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-nt35597-truly-dualmipi-wqxga-video.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-nt35597-truly-dualmipi-wqxga-cmd.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-nt35597-truly-dsc-wqxga-cmd.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-nt35597-truly-dsc-wqxga-video.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-sharp-1080p-cmd.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-sharp-dualmipi-1080p-120hz.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-s6e3ha3-amoled-dualmipi-wqhd-cmd.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-nt35597-dualmipi-wqxga-video.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-nt35597-dualmipi-wqxga-cmd.dtsi \
  ../arch/arm64/boot/dts/qcom/dsi-panel-nt36850-truly-dualmipi-wqhd-cmd.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-cdp.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-pmic-overlay.dtsi \
  ../arch/arm64/boot/dts/qcom/pmi8998.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-pinctrl-overlay.dtsi \
  ../arch/arm64/boot/dts/qcom/sdm845-camera-sensor-cdp.dtsi \

arch/arm64/boot/dts/qcom/sdm845-v2-cdp.dtb: $(deps_arch/arm64/boot/dts/qcom/sdm845-v2-cdp.dtb)

$(deps_arch/arm64/boot/dts/qcom/sdm845-v2-cdp.dtb):
