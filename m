From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Mon, 4 Dec 2017 22:06:43 +0800
Subject: [PATCH 1/2] nvme-cli: add support to get properties for NVMe over
 Fabric
In-Reply-To: <1512396404-18872-1-git-send-email-guanjunxiong@huawei.com>
References: <1512396404-18872-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <1512396404-18872-2-git-send-email-guanjunxiong@huawei.com>

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
---
 Documentation/nvme-show-regs.1   |  13 +++--
 Documentation/nvme-show-regs.txt |  23 +++++---
 nvme-builtin.h                   |   2 +-
 nvme-ioctl.c                     |  74 +++++++++++++++++++++++++
 nvme-ioctl.h                     |   1 +
 nvme-print.c                     | 115 ++++++++++++++++++++++-----------------
 nvme-print.h                     |   2 +-
 nvme.c                           |  25 ++++++---
 8 files changed, 180 insertions(+), 75 deletions(-)

diff --git a/Documentation/nvme-show-regs.1 b/Documentation/nvme-show-regs.1
index 7250035..8f05a1d 100644
--- a/Documentation/nvme-show-regs.1
+++ b/Documentation/nvme-show-regs.1
@@ -28,7 +28,7 @@
 .\" * MAIN CONTENT STARTS HERE *
 .\" -----------------------------------------------------------------
 .SH "NAME"
-nvme-show-regs \- Reads and shows the defined NVMe controller registers\&.
+nvme-show-regs \- Reads and shows the defined NVMe controller registers for NVMe over PCIe or the controller properties for NVMe over Fabrics\&.
 .SH "SYNOPSIS"
 .sp
 .nf
@@ -36,14 +36,15 @@ nvme-show-regs \- Reads and shows the defined NVMe controller registers\&.
 .fi
 .SH "DESCRIPTION"
 .sp
-For the NVMe device given, sends an identify namespace command and provides the result and returned structure\&.
+For the NVMe over PCIe device given, sends an identify namespace command and provides the result and returned structure\&. For the NVMe over Fabrics device given, sends a fabric command and provides the result and returned structure\&.
 .sp
-The <device> parameter is mandatory and must be the nvme admin character device (ex: /dev/nvme0)\&. The program uses knowledge of the sysfs layout to map the device to the pci resource stored there and mmaps the memory to get access to the registers\&.
+The <device> parameter is mandatory and must be the nvme admin character device (ex: /dev/nvme0)\&.For the NVMe over PCIe, the program uses knowledge of the sysfs layout to map the device to the pci resource stored there and mmaps the memory to get access to the registers\&. For NVMe over Fabrics, the programs sends a fabric command to get the properties of the target NVMe controller\&. Only the supported properties are displayed\&.
+
 .SH "OPTIONS"
 .PP
 \-H, \-\-human\-readable
 .RS 4
-Display registers in human readable format\&.
+Display registers or supported properties in human readable format\&.
 .RE
 .SH "EXAMPLES"
 .sp
@@ -55,7 +56,7 @@ Display registers in human readable format\&.
 .sp -1
 .IP \(bu 2.3
 .\}
-Show the nvme pci controller registers in a binary format:
+Show the NVMe over PCIe controller registers or the NVMe over Fabric controller properties in a binary format:
 .sp
 .if n \{\
 .RS 4
@@ -76,7 +77,7 @@ Show the nvme pci controller registers in a binary format:
 .sp -1
 .IP \(bu 2.3
 .\}
-Show the nvme pci controller registers in a human readable format:
+Show the NVMe over PCIe controller registers or the NVMe over Fabric controller properties in a human readable format:
 .sp
 .if n \{\
 .RS 4
diff --git a/Documentation/nvme-show-regs.txt b/Documentation/nvme-show-regs.txt
index 8b8b000..bf6c44c 100644
--- a/Documentation/nvme-show-regs.txt
+++ b/Documentation/nvme-show-regs.txt
@@ -3,7 +3,8 @@ nvme-id-ns(1)
 
 NAME
 ----
-nvme-show-regs - Reads and shows the defined NVMe controller registers.
+nvme-show-regs - Reads and shows the defined NVMe controller registers for
+NVMe over PCIe or the controller properties for NVMe over Fabrics.
 
 SYNOPSIS
 --------
@@ -12,29 +13,35 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-For the NVMe device given, sends an identify namespace command and
+For the NVMe over PCIe device given, sends an identify namespace command and
 provides the result and returned structure.
+For the NVMe over Fabrics device given, sends a fabric command and provides
+the result and returned structure.
 
 The <device> parameter is mandatory and must be the nvme admin character
-device (ex: /dev/nvme0). The program uses knowledge of the sysfs layout
-to map the device to the pci resource stored there and mmaps the memory
-to get access to the registers.
+device (ex: /dev/nvme0). For NVMe over PCIe, the program uses knowledge of the
+sysfs layout to map the device to the pci resource stored there and mmaps the
+memory to get access to the registers. For NVMe over Fabrics, the programs
+sends a fabric command to get the properties of the target NVMe controller.
+Only the supported properties are displayed.
 
 OPTIONS
 -------
 -H::
 --human-readable::
-       Display registers in human readable format. 
+       Display registers or supported properties in human readable format.
 
 
 EXAMPLES
 --------
-* Show the nvme pci controller registers in a binary format:
+* Show the NVMe over PCIe controller registers or the NVMe over Fabric controller
+properties in a binary format:
 +
 ------------
 # nvme show-regs /dev/nvme0
 ------------
-* Show the nvme pci controller registers in a human readable format:
+* Show the NVMe over PCIe controller registers or the NVMe over Fabric controller
+properties in a human readable format:
 +
 ------------
 # nvme show-regs /dev/nvme0 -H
diff --git a/nvme-builtin.h b/nvme-builtin.h
index 1a5ab36..2676dfc 100644
--- a/nvme-builtin.h
+++ b/nvme-builtin.h
@@ -48,7 +48,7 @@ COMMAND_LIST(
 	ENTRY("reset", "Resets the controller", reset)
 	ENTRY("subsystem-reset", "Resets the controller", subsystem_reset)
 	ENTRY("ns-rescan", "Rescans the NVME namespaces", ns_rescan)
-	ENTRY("show-regs", "Shows the controller registers. Requires admin character device", show_registers)
+	ENTRY("show-regs", "Shows the controller registers or properties. Requires character device", show_registers)
 	ENTRY("discover", "Discover NVMeoF subsystems", discover_cmd)
 	ENTRY("connect-all", "Discover and Connect to NVMeoF subsystems", connect_all_cmd)
 	ENTRY("connect", "Connect to NVMeoF subsystem", connect_cmd)
diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 4948c87..fcb8be7 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -447,6 +447,80 @@ int nvme_set_feature(int fd, __u32 nsid, __u8 fid, __u32 value, bool save,
 			    data_len, data, result);
 }
 
+int nvme_property(int fd, __u8 fctype, __le32 off, __le64 *value, __u8 attrib)
+{
+	int err;
+	struct nvmf_property_get_command *prop_get_cmd;
+	struct nvmf_property_set_command *prop_set_cmd;
+	struct nvme_admin_cmd cmd = {
+		.opcode		= nvme_fabrics_command,
+	};
+
+	if (!value)
+		return EINVAL;
+	if (fctype == nvme_fabrics_type_property_get){
+		prop_get_cmd = (struct nvmf_property_get_command *)&cmd;
+		prop_get_cmd->fctype = nvme_fabrics_type_property_get;
+		prop_get_cmd->offset = off;
+		prop_get_cmd->attrib = attrib;
+	}
+	else if(fctype == nvme_fabrics_type_property_set) {
+		prop_set_cmd = (struct nvmf_property_set_command *)&cmd;
+		prop_set_cmd->fctype = nvme_fabrics_type_property_set;
+		prop_set_cmd->offset = off;
+		prop_set_cmd->attrib = attrib;
+		prop_set_cmd->value = *value;
+	}
+	else return EINVAL;
+
+	err = nvme_submit_admin_passthru(fd, &cmd);
+	if (!err && fctype == nvme_fabrics_type_property_get) {
+		*value = cpu_to_le64(cmd.result);
+	}
+
+	return err;
+}
+
+int nvme_get_properties(int fd, void **pbar)
+{
+	__le64 value64;
+	__le32 off;
+	int err, ret = EINVAL;
+	bool is64bit = false;
+	int size = getpagesize();
+
+	*pbar = malloc(size);
+	if (!*pbar)
+		return ret;
+
+	memset(*pbar, 0xff, size);
+	for (off = NVME_REG_CAP; off <= NVME_REG_CMBSZ; off += 4) {
+		switch (off) {
+		case NVME_REG_CAP:
+		case NVME_REG_ASQ:
+		case NVME_REG_ACQ:
+			is64bit = true;
+			break;
+		default:
+			is64bit = false;
+		}
+		err = nvme_property(fd, nvme_fabrics_type_property_get,
+				off, &value64, is64bit ? 1: 0);
+		if (err) {
+			if (is64bit)
+				off += 4;
+			continue;
+		}
+		ret = 0;
+		if (is64bit)
+			*(uint64_t *)(*pbar + off) = le64_to_cpu(value64);
+		else
+			*(uint32_t *)(*pbar + off) = le32_to_cpu(value64);
+	}
+
+	return ret;
+}
+
 int nvme_get_feature(int fd, __u32 nsid, __u8 fid, __u8 sel, __u32 cdw11,
 		     __u32 data_len, void *data, __u32 *result)
 {
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 6b3e0b4..90e2e18 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -121,5 +121,6 @@ int nvme_dir_send(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
 		  __u32 data_len, __u32 dw12, void *data, __u32 *result);
 int nvme_dir_recv(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
 		  __u32 data_len, __u32 dw12, void *data, __u32 *result);
+int nvme_get_properties(int fd, void **pbar);
 
 #endif				/* _NVME_LIB_H */
diff --git a/nvme-print.c b/nvme-print.c
index d50c3b6..1c754de 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -2030,7 +2030,7 @@ static inline __u64 mmio_read64(void *addr)
 	return le32_to_cpu(*p) | ((uint64_t)le32_to_cpu(*(p + 1)) << 32);
 }
 
-void show_ctrl_registers(void *bar, unsigned int mode)
+void show_ctrl_registers(void *bar, unsigned int mode, bool fabrics)
 {
 	uint64_t cap, asq, acq;
 	uint32_t vs, intms, intmc, cc, csts, nssr, aqa, cmbsz, cmbloc;
@@ -2051,55 +2051,70 @@ void show_ctrl_registers(void *bar, unsigned int mode)
 	cmbsz = mmio_read32(bar + NVME_REG_CMBSZ);
 
 	if (human) {
-		printf("cap     : %"PRIx64"\n", cap);
-		show_registers_cap((struct nvme_bar_cap *)&cap);
-
-		printf("version : %x\n", vs);
-		show_registers_version(vs);
-
-		printf("intms   : %x\n", intms);
-		printf("\tInterrupt Vector Mask Set (IVMS): %x\n\n", intms);
-
-		printf("intmc   : %x\n", intmc);
-		printf("\tInterrupt Vector Mask Clear (IVMC): %x\n\n", intmc);
-
-		printf("cc      : %x\n", cc);
-		show_registers_cc(cc);
-
-		printf("csts    : %x\n", csts);
-		show_registers_csts(csts);
-
-		printf("nssr    : %x\n", nssr);
-		printf("\tNVM Subsystem Reset Control (NSSRC): %u\n\n", nssr);
-
-		printf("aqa     : %x\n", aqa);
-		show_registers_aqa(aqa);
-
-		printf("asq     : %"PRIx64"\n", asq);
-		printf("\tAdmin Submission Queue Base (ASQB): %"PRIx64"\n\n",
-				asq);
-
-		printf("acq     : %"PRIx64"\n", acq);
-		printf("\tAdmin Completion Queue Base (ACQB): %"PRIx64"\n\n",
-				acq);
-
-		printf("cmbloc  : %x\n", cmbloc);
-		show_registers_cmbloc(cmbloc, cmbsz);
-
-		printf("cmbsz   : %x\n", cmbsz);
-		show_registers_cmbsz(cmbsz);
+		if (cap != 0xffffffff) {
+			printf("cap     : %"PRIx64"\n", cap);
+			show_registers_cap((struct nvme_bar_cap *)&cap);
+		}
+		if (vs != 0xffffffff) {
+			printf("version : %x\n", vs);
+			show_registers_version(vs);
+		}
+		if (cc != 0xffffffff) {
+			printf("cc      : %x\n", cc);
+			show_registers_cc(cc);
+		}
+		if (csts != 0xffffffff) {
+			printf("csts    : %x\n", csts);
+			show_registers_csts(csts);
+		}
+		if (nssr != 0xffffffff) {
+			printf("nssr    : %x\n", nssr);
+			printf("\tNVM Subsystem Reset Control (NSSRC): %u\n\n", nssr);
+		}
+		if (!fabrics) {
+			printf("intms   : %x\n", intms);
+			printf("\tInterrupt Vector Mask Set (IVMS): %x\n\n",
+					intms);
+
+			printf("intmc   : %x\n", intmc);
+			printf("\tInterrupt Vector Mask Clear (IVMC): %x\n\n",
+					intmc);
+			printf("aqa     : %x\n", aqa);
+			show_registers_aqa(aqa);
+
+			printf("asq     : %"PRIx64"\n", asq);
+			printf("\tAdmin Submission Queue Base (ASQB): %"PRIx64"\n\n",
+					asq);
+
+			printf("acq     : %"PRIx64"\n", acq);
+			printf("\tAdmin Completion Queue Base (ACQB): %"PRIx64"\n\n",
+					acq);
+
+			printf("cmbloc  : %x\n", cmbloc);
+			show_registers_cmbloc(cmbloc, cmbsz);
+
+			printf("cmbsz   : %x\n", cmbsz);
+			show_registers_cmbsz(cmbsz);
+		}
 	} else {
-		printf("cap     : %"PRIx64"\n", cap);
-		printf("version : %x\n", vs);
-		printf("intms   : %x\n", intms);
-		printf("intmc   : %x\n", intmc);
-		printf("cc      : %x\n", cc);
-		printf("csts    : %x\n", csts);
-		printf("nssr    : %x\n", nssr);
-		printf("aqa     : %x\n", aqa);
-		printf("asq     : %"PRIx64"\n", asq);
-		printf("acq     : %"PRIx64"\n", acq);
-		printf("cmbloc  : %x\n", cmbloc);
-		printf("cmbsz   : %x\n", cmbsz);
+		if (cap != 0xffffffff)
+			printf("cap     : %"PRIx64"\n", cap);
+		if (vs != 0xffffffff)
+			printf("version : %x\n", vs);
+		if (cc != 0xffffffff)
+			printf("cc      : %x\n", cc);
+		if (csts != 0xffffffff)
+			printf("csts    : %x\n", csts);
+		if (nssr != 0xffffffff)
+			printf("nssr    : %x\n", nssr);
+		if (!fabrics) {
+			printf("intms   : %x\n", intms);
+			printf("intmc   : %x\n", intmc);
+			printf("aqa     : %x\n", aqa);
+			printf("asq     : %"PRIx64"\n", asq);
+			printf("acq     : %"PRIx64"\n", acq);
+			printf("cmbloc  : %x\n", cmbloc);
+			printf("cmbsz   : %x\n", cmbsz);
+		}
 	}
 }
diff --git a/nvme-print.h b/nvme-print.h
index d110b98..d61bde0 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -26,7 +26,7 @@ void show_error_log(struct nvme_error_log_page *err_log, int entries, const char
 void show_smart_log(struct nvme_smart_log *smart, unsigned int nsid, const char *devname);
 void show_fw_log(struct nvme_firmware_log_page *fw_log, const char *devname);
 void show_effects_log(struct nvme_effects_log_page *effects);
-void show_ctrl_registers(void *bar, unsigned int mode);
+void show_ctrl_registers(void *bar, unsigned int mode, bool fabrics);
 void show_nvme_id_ns_descs(void *data);
 
 void nvme_feature_show_fields(__u32 fid, unsigned int result, unsigned char *buf);
diff --git a/nvme.c b/nvme.c
index 7830ea2..8932255 100644
--- a/nvme.c
+++ b/nvme.c
@@ -802,23 +802,23 @@ static char *nvme_char_from_block(char *block)
 
 static void *get_registers(void)
 {
-	int pci_fd;
+	int fd;
 	char *base, path[512];
 	void *membase;
 
 	base = nvme_char_from_block((char *)devicename);
 	sprintf(path, "/sys/class/nvme/%s/device/resource0", base);
-	pci_fd = open(path, O_RDONLY);
-	if (pci_fd < 0) {
+	fd = open(path, O_RDONLY);
+	if (fd < 0) {
 		sprintf(path, "/sys/class/misc/%s/device/resource0", base);
-		pci_fd = open(path, O_RDONLY);
+		fd = open(path, O_RDONLY);
 	}
-	if (pci_fd < 0) {
+	if (fd < 0) {
 		fprintf(stderr, "%s did not find a pci resource\n", base);
 		return NULL;
 	}
 
-	membase = mmap(NULL, getpagesize(), PROT_READ, MAP_SHARED, pci_fd, 0);
+	membase = mmap(NULL, getpagesize(), PROT_READ, MAP_SHARED, fd, 0);
 	if (membase == MAP_FAILED) {
 		fprintf(stderr, "%s failed to map\n", base);
 		return NULL;
@@ -1663,7 +1663,8 @@ static int show_registers(int argc, char **argv, struct command *cmd, struct plu
 					"in binary or human-readable format";
 	const char *human_readable = "show info in readable format";
 	void *bar;
-	int fd;
+	int fd, err;
+	bool fabrics = true;
 
 	struct config {
 		int human_readable;
@@ -1682,11 +1683,17 @@ static int show_registers(int argc, char **argv, struct command *cmd, struct plu
 	if (fd < 0)
 		return fd;
 
-	bar = get_registers();
+	err = nvme_get_properties(fd, &bar);
+	if (err) {
+		bar = get_registers();
+		fabrics = false;
+	}
 	if (!bar)
 		return ENODEV;
+	show_ctrl_registers(bar, cfg.human_readable ? HUMAN : 0, fabrics);
 
-	show_ctrl_registers(bar, cfg.human_readable ? HUMAN : 0);
+	if (fabrics)
+		free(bar);
 	return 0;
 }
 
-- 
2.11.1
