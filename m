From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Tue, 9 Oct 2018 18:10:51 +0000
Subject: [PATCH] NVMe-CLI WDC Plugin - Simplify the device id checking
 routines.
Message-ID: <1539108633-3610-1-git-send-email-jeff.lien@wdc.com>

This change will make one common function that will retrieve the pci
vendor and device id's and check them for a match of the passed in
id's.

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 wdc-nvme.c | 178 ++++++++++++++++++++++++++-----------------------------------
 1 file changed, 76 insertions(+), 102 deletions(-)

diff --git a/wdc-nvme.c b/wdc-nvme.c
index cc36c9d..33d38fc 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -415,31 +415,65 @@ static double calc_percent(uint64_t numerator, uint64_t denominator)
 		(uint64_t)(((double)numerator / (double)denominator) * 100) : 0;
 }
 
-static int wdc_get_pci_dev_id(int *device_id)
+static int wdc_get_pci_ids(int *device_id, int *vendor_id)
 {
 	int fd, ret = -1;
-	char *base, path[512], *id;
+	char *block, path[512], *id;
 
-	base = nvme_char_from_block((char *)devicename);
-	sprintf(path, "/sys/class/nvme/%s/device/device", base);
+	id = calloc(1, 32);
+	if (!id) {
+		fprintf(stderr, "ERROR : WDC : %s : calloc failed\n", __func__);
+		return -1;
+	}
+
+	block = nvme_char_from_block((char *)devicename);
+
+	/* read the vendor ID from sys fs  */
+	sprintf(path, "/sys/class/nvme/%s/device/vendor", block);
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0) {
-		sprintf(path, "/sys/class/misc/%s/device/device", base);
+		sprintf(path, "/sys/class/misc/%s/device/vendor", block);
 		fd = open(path, O_RDONLY);
 	}
 	if (fd < 0) {
-		fprintf(stderr, "%s: did not find a pci device\n", __func__);
-		return -1;
+		fprintf(stderr, "ERROR : WDC : %s : Open vendor file failed\n", __func__);
+		ret = -1;
+		goto free_id;
 	}
 
-	id = calloc(1, 32);
-	if (!id)
+	ret = read(fd, id, 32);
+	if (ret < 0) {
+		fprintf(stderr, "%s: Read of pci vendor id failed\n", __func__);
+		ret = -1;
 		goto close_fd;
+	} else {
+		if (id[strlen(id) - 1] == '\n')
+			id[strlen(id) - 1] = '\0';
+
+		/* convert the device id string to an int  */
+		*vendor_id = (int)strtol(&id[2], NULL, 16);
+		ret = 0;
+	}
+
+	/* read the device ID from sys fs */
+	sprintf(path, "/sys/class/nvme/%s/device/device", block);
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		sprintf(path, "/sys/class/misc/%s/device/device", block);
+		fd = open(path, O_RDONLY);
+	}
+	if (fd < 0) {
+		fprintf(stderr, "ERROR : WDC : %s : Open device file failed\n", __func__);
+		ret = -1;
+		goto close_fd;
+	}
 
 	ret = read(fd, id, 32);
 	if (ret < 0) {
 		fprintf(stderr, "%s: Read of pci device id failed\n", __func__);
+		ret = -1;
 	} else {
 		if (id[strlen(id) - 1] == '\n')
 			id[strlen(id) - 1] = '\0';
@@ -449,10 +483,10 @@ static int wdc_get_pci_dev_id(int *device_id)
 		ret = 0;
 	}
 
-	free(id);
-
 close_fd:
 	close(fd);
+free_id:
+	free(id);
 	return ret;
 }
 
@@ -460,114 +494,45 @@ static bool wdc_check_device(int fd)
 {
 	int ret;
 	bool supported;
-	struct nvme_id_ctrl ctrl;
-	int device_id;
-
-	memset(&ctrl, 0, sizeof (struct nvme_id_ctrl));
-	ret = nvme_identify_ctrl(fd, &ctrl);
-	if (ret) {
-		fprintf(stderr, "ERROR : WDC : nvme_identify_ctrl() failed "
-				"0x%x\n", ret);
-		return false;
-	}
+	int read_device_id, read_vendor_id;
 
-	ret = wdc_get_pci_dev_id((int *)&device_id);
+	ret = wdc_get_pci_ids((int *)&read_device_id, (int *)&read_vendor_id);
 	if (ret < 0)
 		return false;
 
 	supported = false;
 
 	/* WDC : Use PCI Vendor and Device ID's to identify WDC Devices */
-	if ((le32_to_cpu(ctrl.vid) == WDC_NVME_VID) &&
-		((device_id == WDC_NVME_SN100_DEV_ID) ||
-		(device_id == WDC_NVME_SN200_DEV_ID)))
+	if ((le32_to_cpu(read_vendor_id) == WDC_NVME_VID) &&
+		((le32_to_cpu(read_device_id) == WDC_NVME_SN100_DEV_ID) ||
+		(le32_to_cpu(read_device_id) == WDC_NVME_SN200_DEV_ID)))
 		supported = true;
-	else if ((le32_to_cpu(ctrl.vid) == WDC_NVME_SNDK_VID) &&
-		(device_id == WDC_NVME_SXSLCL_DEV_ID))
+	else if ((le32_to_cpu(read_vendor_id) == WDC_NVME_SNDK_VID) &&
+			(le32_to_cpu(read_device_id) == WDC_NVME_SXSLCL_DEV_ID))
 		supported = true;
-	else if ((le32_to_cpu(ctrl.vid) == WDC_NVME_VID_2) &&
-		((device_id == WDC_NVME_SN310_DEV_ID) ||
-		 (device_id == WDC_NVME_SN510_DEV_ID)))
+	else if ((le32_to_cpu(read_vendor_id) == WDC_NVME_VID_2) &&
+			((le32_to_cpu(read_device_id) == WDC_NVME_SN310_DEV_ID) ||
+			 (le32_to_cpu(read_device_id) == WDC_NVME_SN510_DEV_ID)))
 		supported = true;
 	else
-		fprintf(stderr, "WARNING : WDC not supported, Vendor ID = 0x%x, Device ID = 0x%x\n", le32_to_cpu(ctrl.vid), device_id);
+		fprintf(stderr, "WARNING : WDC not supported, Vendor ID = 0x%x, Device ID = 0x%x\n",
+				le32_to_cpu(read_vendor_id), le32_to_cpu(read_device_id));
 
 	return supported;
 }
 
-static bool wdc_check_device_sxslcl(int fd)
-{
-	int ret;
-	struct nvme_id_ctrl ctrl;
-	int device_id;
-
-	memset(&ctrl, 0, sizeof (struct nvme_id_ctrl));
-	ret = nvme_identify_ctrl(fd, &ctrl);
-	if (ret) {
-		fprintf(stderr, "ERROR : WDC : nvme_identify_ctrl() failed "
-				"0x%x\n", ret);
-		return false;
-	}
-
-	ret = wdc_get_pci_dev_id((int *)&device_id);
-	if (ret < 0)
-		return false;
-
-	/* WDC : Use PCI Vendor and Device ID's to identify WDC Devices */
-	if ((le32_to_cpu(ctrl.vid) == WDC_NVME_SNDK_VID) &&
-			(device_id == WDC_NVME_SXSLCL_DEV_ID))
-		return true;
-	else
-		return false;
-}
-
-static bool wdc_check_device_sn100(int fd)
+static bool wdc_check_device_match(int fd, int vendor_id, int device_id)
 {
 	int ret;
-	struct nvme_id_ctrl ctrl;
-	int device_id;
-
-	memset(&ctrl, 0, sizeof (struct nvme_id_ctrl));
-	ret = nvme_identify_ctrl(fd, &ctrl);
-	if (ret) {
-		fprintf(stderr, "ERROR : WDC : nvme_identify_ctrl() failed "
-				"0x%x\n", ret);
-		return false;
-	}
+	int read_device_id, read_vendor_id;
 
-	ret = wdc_get_pci_dev_id((int *)&device_id);
+	ret = wdc_get_pci_ids((int *)&read_device_id, (int *)&read_vendor_id);
 	if (ret < 0)
 		return false;
 
 	/* WDC : Use PCI Vendor and Device ID's to identify WDC Devices */
-	if ((le32_to_cpu(ctrl.vid) == WDC_NVME_VID) &&
-		(device_id == WDC_NVME_SN100_DEV_ID))
-		return true;
-	else
-		return false;
-}
-
-static bool wdc_check_device_sn200(int fd)
-{
-	int ret;
-	struct nvme_id_ctrl ctrl;
-	int device_id;
-
-	memset(&ctrl, 0, sizeof (struct nvme_id_ctrl));
-	ret = nvme_identify_ctrl(fd, &ctrl);
-	if (ret) {
-		fprintf(stderr, "ERROR : WDC : nvme_identify_ctrl() failed "
-				"0x%x\n", ret);
-		return false;
-	}
-
-	ret = wdc_get_pci_dev_id((int *)&device_id);
-	if (ret < 0)
-		return false;
-
-	/* WDC : Use PCI Vendor and Device ID's to identify WDC Devices */
-	if ((le32_to_cpu(ctrl.vid) == WDC_NVME_VID) &&
-		(device_id == WDC_NVME_SN200_DEV_ID))
+	if ((le32_to_cpu(read_vendor_id) == vendor_id) &&
+		(le32_to_cpu(read_device_id) == device_id))
 		return true;
 	else
 		return false;
@@ -850,7 +815,6 @@ static int wdc_cap_diag(int argc, char **argv, struct command *command,
 	if (fd < 0)
 		return fd;
 
-	wdc_check_device(fd);
 	if (cfg.file != NULL) {
 		strncpy(f, cfg.file, PATH_MAX - 1);
 	}
@@ -858,7 +822,17 @@ static int wdc_cap_diag(int argc, char **argv, struct command *command,
 		fprintf(stderr, "ERROR : WDC: failed to generate file name\n");
 		return -1;
 	}
-	return wdc_do_cap_diag(fd, f);
+
+	if (wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN100_DEV_ID) ||
+		wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN200_DEV_ID) ||
+		wdc_check_device_match(fd, WDC_NVME_VID_2, WDC_NVME_SN310_DEV_ID) ||
+		wdc_check_device_match(fd, WDC_NVME_VID_2, WDC_NVME_SN510_DEV_ID)) {
+		return wdc_do_cap_diag(fd, f);
+	} else {
+		fprintf(stderr, "ERROR : WDC: unsupported device for cap-diag command\n");
+	}
+
+	return 0;
 }
 
 static int wdc_do_crash_dump(int fd, char *file)
@@ -1544,7 +1518,7 @@ static int wdc_smart_add_log(int argc, char **argv, struct command *command,
 		return fd;
 
 
-	if (wdc_check_device_sn100(fd)) {
+	if (wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN100_DEV_ID)) {
 		// Get the C1 Log Page
 		ret = wdc_get_c1_log_page(fd, cfg.output_format, cfg.interval);
 
@@ -1553,7 +1527,7 @@ static int wdc_smart_add_log(int argc, char **argv, struct command *command,
 			return ret;
 		}
 	}
-	else if (wdc_check_device_sn200(fd)) {
+	else if (wdc_check_device_match(fd, WDC_NVME_VID, WDC_NVME_SN200_DEV_ID)) {
 		// Get the CA and C1 Log Page
 		ret = wdc_get_ca_log_page(fd, cfg.output_format);
 		if (ret) {
@@ -2326,7 +2300,7 @@ static int wdc_drive_essentials(int argc, char **argv, struct command *command,
 	if (fd < 0)
 		return fd;
 
-	if (!wdc_check_device_sxslcl(fd)) {
+	if (!wdc_check_device_match(fd, WDC_NVME_SNDK_VID, WDC_NVME_SXSLCL_DEV_ID)) {
 		fprintf(stderr, "WARNING : WDC : Device not supported\n");
 		return -1;
 	}
-- 
1.8.3.1
