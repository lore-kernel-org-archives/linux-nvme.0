From: Jeff.Lien@wdc.com (Jeffrey Lien)
Date: Tue, 25 Sep 2018 14:58:34 +0000
Subject: [PATCH] Add PCI device id checking for the WDC plugin commands.
Message-ID: <1537887494-14977-1-git-send-email-jeff.lien@wdc.com>

Signed-off-by: Jeff Lien <jeff.lien at wdc.com>
---
 nvme.c     |   2 +-
 nvme.h     |   1 +
 wdc-nvme.c | 145 +++++++++++++++++++++++++++++++++++++++++++++----------------
 3 files changed, 109 insertions(+), 39 deletions(-)

diff --git a/nvme.c b/nvme.c
index 253bc9e..1e9359a 100644
--- a/nvme.c
+++ b/nvme.c
@@ -1205,7 +1205,7 @@ static int create_ns(int argc, char **argv, struct command *cmd, struct plugin *
 	return err;
 }
 
-static char *nvme_char_from_block(char *block)
+char *nvme_char_from_block(char *block)
 {
 	char slen[16];
 	unsigned len;
diff --git a/nvme.h b/nvme.h
index e509e9c..431809d 100644
--- a/nvme.h
+++ b/nvme.h
@@ -157,4 +157,5 @@ int	validate_output_format(char *format);
 
 struct subsys_list_item *get_subsys_list(int *subcnt);
 void free_subsys_list(struct subsys_list_item *slist, int n);
+char *nvme_char_from_block(char *block);
 #endif /* _NVME_H */
diff --git a/wdc-nvme.c b/wdc-nvme.c
index dd6d34a..cc36c9d 100644
--- a/wdc-nvme.c
+++ b/wdc-nvme.c
@@ -52,10 +52,17 @@
 
 /* Device Config */
 #define WDC_NVME_VID  					0x1c58
-#define WDC_NVME_SN100_CNTL_ID			0x0003
-#define WDC_NVME_SN200_CNTL_ID			0x0023
+#define WDC_NVME_SN100_DEV_ID			0x0003
+#define WDC_NVME_SN200_DEV_ID			0x0023
+#define WDC_NVME_VID_2        			0x1b96
+#define WDC_NVME_SN310_DEV_ID			0x2200
+#define WDC_NVME_SN510_DEV_ID			0x2300
+
 #define WDC_NVME_SNDK_VID		        0x15b7
-#define WDC_NVME_SXSLCL_CNTRL_ID		0x0000
+#define WDC_NVME_SXSLCL_DEV_ID  		0x2001
+#define WDC_NVME_SN520_DEV_ID_1  		0x5003
+#define WDC_NVME_SN520_DEV_ID_2  		0x5005
+#define WDC_NVME_SN720_DEV_ID   		0x5002
 
 /* Capture Diagnostics */
 #define WDC_NVME_CAP_DIAG_HEADER_TOC_SIZE	WDC_NVME_LOG_SIZE_DATA_LEN
@@ -408,59 +415,117 @@ static double calc_percent(uint64_t numerator, uint64_t denominator)
 		(uint64_t)(((double)numerator / (double)denominator) * 100) : 0;
 }
 
-static int wdc_check_device(int fd)
+static int wdc_get_pci_dev_id(int *device_id)
+{
+	int fd, ret = -1;
+	char *base, path[512], *id;
+
+	base = nvme_char_from_block((char *)devicename);
+	sprintf(path, "/sys/class/nvme/%s/device/device", base);
+
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
+		sprintf(path, "/sys/class/misc/%s/device/device", base);
+		fd = open(path, O_RDONLY);
+	}
+	if (fd < 0) {
+		fprintf(stderr, "%s: did not find a pci device\n", __func__);
+		return -1;
+	}
+
+	id = calloc(1, 32);
+	if (!id)
+		goto close_fd;
+
+	ret = read(fd, id, 32);
+	if (ret < 0) {
+		fprintf(stderr, "%s: Read of pci device id failed\n", __func__);
+	} else {
+		if (id[strlen(id) - 1] == '\n')
+			id[strlen(id) - 1] = '\0';
+
+		/* convert the device id string to an int  */
+		*device_id = (int)strtol(&id[2], NULL, 16);
+		ret = 0;
+	}
+
+	free(id);
+
+close_fd:
+	close(fd);
+	return ret;
+}
+
+static bool wdc_check_device(int fd)
 {
 	int ret;
+	bool supported;
 	struct nvme_id_ctrl ctrl;
+	int device_id;
 
 	memset(&ctrl, 0, sizeof (struct nvme_id_ctrl));
 	ret = nvme_identify_ctrl(fd, &ctrl);
 	if (ret) {
 		fprintf(stderr, "ERROR : WDC : nvme_identify_ctrl() failed "
 				"0x%x\n", ret);
-		return -1;
+		return false;
 	}
-	ret = -1;
-	/* WDC : ctrl->cntlid == PCI Device ID, use that with VID to identify WDC Devices */
+
+	ret = wdc_get_pci_dev_id((int *)&device_id);
+	if (ret < 0)
+		return false;
+
+	supported = false;
+
+	/* WDC : Use PCI Vendor and Device ID's to identify WDC Devices */
 	if ((le32_to_cpu(ctrl.vid) == WDC_NVME_VID) &&
-		((le32_to_cpu(ctrl.cntlid) == WDC_NVME_SN100_CNTL_ID) ||
-		(le32_to_cpu(ctrl.cntlid) == WDC_NVME_SN200_CNTL_ID)))
-		ret = 0;
+		((device_id == WDC_NVME_SN100_DEV_ID) ||
+		(device_id == WDC_NVME_SN200_DEV_ID)))
+		supported = true;
 	else if ((le32_to_cpu(ctrl.vid) == WDC_NVME_SNDK_VID) &&
-			(le32_to_cpu(ctrl.cntlid) == WDC_NVME_SXSLCL_CNTRL_ID))
-		ret = 0;
+		(device_id == WDC_NVME_SXSLCL_DEV_ID))
+		supported = true;
+	else if ((le32_to_cpu(ctrl.vid) == WDC_NVME_VID_2) &&
+		((device_id == WDC_NVME_SN310_DEV_ID) ||
+		 (device_id == WDC_NVME_SN510_DEV_ID)))
+		supported = true;
 	else
-		fprintf(stderr, "WARNING : WDC : Device not supported\n");
+		fprintf(stderr, "WARNING : WDC not supported, Vendor ID = 0x%x, Device ID = 0x%x\n", le32_to_cpu(ctrl.vid), device_id);
 
-	return ret;
+	return supported;
 }
 
-static int wdc_check_device_sxslcl(int fd)
+static bool wdc_check_device_sxslcl(int fd)
 {
 	int ret;
 	struct nvme_id_ctrl ctrl;
+	int device_id;
 
 	memset(&ctrl, 0, sizeof (struct nvme_id_ctrl));
 	ret = nvme_identify_ctrl(fd, &ctrl);
 	if (ret) {
 		fprintf(stderr, "ERROR : WDC : nvme_identify_ctrl() failed "
 				"0x%x\n", ret);
-		return -1;
+		return false;
 	}
-	ret = -1;
 
-	/* WDC : ctrl->cntlid == PCI Device ID, use that with VID to identify WDC Devices */
-	if ((le32_to_cpu(ctrl.vid) == WDC_NVME_SNDK_VID) &&
-			(le32_to_cpu(ctrl.cntlid) == WDC_NVME_SXSLCL_CNTRL_ID))
-		ret = 0;
+	ret = wdc_get_pci_dev_id((int *)&device_id);
+	if (ret < 0)
+		return false;
 
-	return ret;
+	/* WDC : Use PCI Vendor and Device ID's to identify WDC Devices */
+	if ((le32_to_cpu(ctrl.vid) == WDC_NVME_SNDK_VID) &&
+			(device_id == WDC_NVME_SXSLCL_DEV_ID))
+		return true;
+	else
+		return false;
 }
 
 static bool wdc_check_device_sn100(int fd)
 {
-	bool ret;
+	int ret;
 	struct nvme_id_ctrl ctrl;
+	int device_id;
 
 	memset(&ctrl, 0, sizeof (struct nvme_id_ctrl));
 	ret = nvme_identify_ctrl(fd, &ctrl);
@@ -470,20 +535,23 @@ static bool wdc_check_device_sn100(int fd)
 		return false;
 	}
 
-	/* WDC : ctrl->cntlid == PCI Device ID, use that with VID to identify WDC Devices */
+	ret = wdc_get_pci_dev_id((int *)&device_id);
+	if (ret < 0)
+		return false;
+
+	/* WDC : Use PCI Vendor and Device ID's to identify WDC Devices */
 	if ((le32_to_cpu(ctrl.vid) == WDC_NVME_VID) &&
-		(le32_to_cpu(ctrl.cntlid) == WDC_NVME_SN100_CNTL_ID))
-		ret = true;
+		(device_id == WDC_NVME_SN100_DEV_ID))
+		return true;
 	else
-		ret = false;
-
-	return ret;
+		return false;
 }
 
 static bool wdc_check_device_sn200(int fd)
 {
-	bool ret;
+	int ret;
 	struct nvme_id_ctrl ctrl;
+	int device_id;
 
 	memset(&ctrl, 0, sizeof (struct nvme_id_ctrl));
 	ret = nvme_identify_ctrl(fd, &ctrl);
@@ -493,17 +561,18 @@ static bool wdc_check_device_sn200(int fd)
 		return false;
 	}
 
-	/* WDC : ctrl->cntlid == PCI Device ID, use that with VID to identify WDC Devices */
+	ret = wdc_get_pci_dev_id((int *)&device_id);
+	if (ret < 0)
+		return false;
+
+	/* WDC : Use PCI Vendor and Device ID's to identify WDC Devices */
 	if ((le32_to_cpu(ctrl.vid) == WDC_NVME_VID) &&
-		(le32_to_cpu(ctrl.cntlid) == WDC_NVME_SN200_CNTL_ID))
-		ret = true;
+		(device_id == WDC_NVME_SN200_DEV_ID))
+		return true;
 	else
-		ret = false;
-
-	return ret;
+		return false;
 }
 
-
 static int wdc_get_serial_name(int fd, char *file, size_t len, char *suffix)
 {
 	int i;
@@ -2257,7 +2326,7 @@ static int wdc_drive_essentials(int argc, char **argv, struct command *command,
 	if (fd < 0)
 		return fd;
 
-	if ( wdc_check_device_sxslcl(fd) < 0) {
+	if (!wdc_check_device_sxslcl(fd)) {
 		fprintf(stderr, "WARNING : WDC : Device not supported\n");
 		return -1;
 	}
-- 
1.8.3.1
