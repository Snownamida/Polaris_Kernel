cmd_arch/arm64/boot/Image.gz-dtb := (cat arch/arm64/boot/Image.gz arch/arm64/boot/dts/qcom/polaris-mp-v2.1.dtb arch/arm64/boot/dts/qcom/polaris-mp-v2.dtb arch/arm64/boot/dts/qcom/polaris-mp.dtb arch/arm64/boot/dts/qcom/polaris-p0-v2.dtb arch/arm64/boot/dts/qcom/polaris-p0.dtb arch/arm64/boot/dts/qcom/polaris-p1-v2.1.dtb arch/arm64/boot/dts/qcom/polaris-p1-v2.dtb arch/arm64/boot/dts/qcom/polaris-p1.dtb arch/arm64/boot/dts/qcom/polaris-p2-v2.1.dtb arch/arm64/boot/dts/qcom/polaris-p2-v2.dtb arch/arm64/boot/dts/qcom/polaris-p2.dtb arch/arm64/boot/dts/qcom/polaris-p3-v2.1.dtb arch/arm64/boot/dts/qcom/polaris-p3-v2.dtb arch/arm64/boot/dts/qcom/polaris-p3.dtb arch/arm64/boot/dts/qcom/sdm845-4k-panel-cdp.dtb arch/arm64/boot/dts/qcom/sdm845-4k-panel-mtp.dtb arch/arm64/boot/dts/qcom/sdm845-4k-panel-qrd.dtb arch/arm64/boot/dts/qcom/sdm845-cdp.dtb arch/arm64/boot/dts/qcom/sdm845-mtp.dtb arch/arm64/boot/dts/qcom/sdm845-qrd.dtb arch/arm64/boot/dts/qcom/sdm845-rumi.dtb arch/arm64/boot/dts/qcom/sdm845-sim.dtb arch/arm64/boot/dts/qcom/sdm845-v2-cdp.dtb arch/arm64/boot/dts/qcom/sdm845-v2-mtp.dtb arch/arm64/boot/dts/qcom/sdm845-v2-qrd.dtb arch/arm64/boot/dts/qcom/sdm845-v2-qvr.dtb arch/arm64/boot/dts/qcom/sdm845-v2-rumi.dtb > arch/arm64/boot/Image.gz-dtb) || (rm -f arch/arm64/boot/Image.gz-dtb; false)