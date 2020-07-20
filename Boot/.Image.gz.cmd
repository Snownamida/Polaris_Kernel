cmd_arch/arm64/boot/Image.gz := (cat arch/arm64/boot/Image | gzip -n -f -9 > arch/arm64/boot/Image.gz) || (rm -f arch/arm64/boot/Image.gz ; false)
