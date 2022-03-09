$("#micropost_image").bind("change", function () {
    const image_size_mb = this.files[0].size / 1024 / 1024;
    if (image_size_mb > 5) {
        alert(I18n.t("file_size_exceed"));
        this.value = "";
    }
});
