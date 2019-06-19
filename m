From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 19 Jun 2019 10:36:58 -0700
Subject: [PATCH nvme-cli 10/13] nvme-cli: Rework the code for getting and
 setting NVMf properties
In-Reply-To: <20190619173701.8263-1-bvanassche@acm.org>
References: <20190619173701.8263-1-bvanassche@acm.org>
Message-ID: <20190619173701.8263-11-bvanassche@acm.org>

The current nvme_property() implementation is much harder to read
because it uses an nvme_admin_cmd structure to represent the
nvmf_property_get_command and nvmf_property_set_command data structures.
Verifying the implementation of nvme_property() requires to compare the
offsets of members of nvme_admin_cmd with the offsets of members of
nvmf_property_[gs]et_command. Make the code easier to read by using the
nvmf_property_get_command and nvmf_property_set data structures directly.

This patch fixes the sparse complaints about endianness mismatches in the
nvme_property(), nvme_get_property() and nvme_set_property() functions.

Cc: Eyal Ben David <eyalbe at il.ibm.com>
Signed-off-by: Bart Van Assche <bvanassche at acm.org>
---
 nvme-ioctl.c | 121 ++++++++++++++++++++++++++-------------------------
 nvme-ioctl.h |   2 +-
 2 files changed, 63 insertions(+), 60 deletions(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index f3a56dc51086..0c8de0748c18 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -1,3 +1,4 @@
+#include <assert.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
 #include <string.h>
@@ -547,60 +548,60 @@ int nvme_set_feature(int fd, __u32 nsid, __u8 fid, __u32 value, __u32 cdw12,
 			    cdw12, data_len, data, result);
 }
 
-static int nvme_property(int fd, __u8 fctype, __le32 off, __le64 *value, __u8 attrib)
-{
-	int err;
-	struct nvme_admin_cmd cmd = {
-		.opcode		= nvme_fabrics_command,
-		.cdw10		= attrib,
-		.cdw11		= off,
-	};
-
-	if (!value) {
-		errno = EINVAL;
-		return -errno;
-	}
 
-	if (fctype == nvme_fabrics_type_property_get){
-		cmd.nsid = nvme_fabrics_type_property_get;
-	} else if (fctype == nvme_fabrics_type_property_set) {
-		cmd.nsid = nvme_fabrics_type_property_set;
-		cmd.cdw12 = *value;
-	} else {
-		errno = EINVAL;
-		return -errno;
-	}
-
-	err = nvme_submit_admin_passthru(fd, &cmd);
-	if (!err && fctype == nvme_fabrics_type_property_get)
-		*value = cpu_to_le64(cmd.result);
-	return err;
+/*
+ * Perform the opposite operation of the byte-swapping code at the start of the
+ * kernel function nvme_user_cmd().
+ */
+static void nvme_to_passthru_cmd(struct nvme_passthru_cmd *pcmd,
+				 const struct nvme_command *ncmd)
+{
+	assert(sizeof(*ncmd) < sizeof(*pcmd));
+	memset(pcmd, 0, sizeof(*pcmd));
+	pcmd->opcode = ncmd->common.opcode;
+	pcmd->flags = ncmd->common.flags;
+	pcmd->rsvd1 = ncmd->common.command_id;
+	pcmd->nsid = le32_to_cpu(ncmd->common.nsid);
+	pcmd->cdw2 = le32_to_cpu(ncmd->common.cdw2[0]);
+	pcmd->cdw3 = le32_to_cpu(ncmd->common.cdw2[1]);
+	/* Skip metadata and addr */
+	pcmd->cdw10 = le32_to_cpu(ncmd->common.cdw10[0]);
+	pcmd->cdw11 = le32_to_cpu(ncmd->common.cdw10[1]);
+	pcmd->cdw12 = le32_to_cpu(ncmd->common.cdw10[2]);
+	pcmd->cdw13 = le32_to_cpu(ncmd->common.cdw10[3]);
+	pcmd->cdw14 = le32_to_cpu(ncmd->common.cdw10[4]);
+	pcmd->cdw15 = le32_to_cpu(ncmd->common.cdw10[5]);
 }
 
 int nvme_get_property(int fd, int offset, uint64_t *value)
 {
-	__le64 value64;
-	int err = -EINVAL;
-
-	if (!value)
-		return err;
-
-	err = nvme_property(fd, nvme_fabrics_type_property_get,
-			cpu_to_le32(offset), &value64, is_64bit_reg(offset));
+	struct nvme_passthru_cmd pcmd;
+	struct nvme_command gcmd = {
+		.prop_get = {
+			.opcode	= nvme_fabrics_command,
+			.fctype	= nvme_fabrics_type_property_get,
+			.offset	= cpu_to_le32(offset),
+			.attrib = is_64bit_reg(offset),
+		}
+	};
+	int err;
 
+	nvme_to_passthru_cmd(&pcmd, &gcmd);
+	err = nvme_submit_admin_passthru(fd, &pcmd);
 	if (!err) {
-		if (is_64bit_reg(offset))
-			*((uint64_t *)value) = le64_to_cpu(value64);
-		else
-			*((uint32_t *)value) = le32_to_cpu(value64);
+		/*
+		 * nvme_submit_admin_passthru() stores the lower 32 bits
+		 * of the property value in pcmd.result using CPU endianness.
+		 */
+		*value = pcmd.result;
 	}
-
 	return err;
 }
 
 int nvme_get_properties(int fd, void **pbar)
 {
 	int offset;
+	uint64_t value;
 	int err;
 	int size = getpagesize();
 
@@ -612,36 +613,38 @@ int nvme_get_properties(int fd, void **pbar)
 
 	memset(*pbar, 0xff, size);
 	for (offset = NVME_REG_CAP; offset <= NVME_REG_CMBSZ;) {
-		err = nvme_get_property(fd, offset, *pbar + offset);
+		err = nvme_get_property(fd, offset, &value);
 		if (err) {
 			free(*pbar);
 			break;
 		}
-
-		offset += is_64bit_reg(offset) ? 8 : 4;
+		if (is_64bit_reg(offset)) {
+			*(uint64_t *)(*pbar + offset) = value;
+			offset += 8;
+		} else {
+			*(uint32_t *)(*pbar + offset) = value;
+			offset += 4;
+		}
 	}
 
 	return err;
 }
 
-int nvme_set_property(int fd, int offset, int value)
+int nvme_set_property(int fd, int offset, uint64_t value)
 {
-	__le64 val = cpu_to_le64(value);
-	__le32 off = cpu_to_le32(offset);
-	bool is64bit;
-
-	switch (off) {
-	case NVME_REG_CAP:
-	case NVME_REG_ASQ:
-	case NVME_REG_ACQ:
-		is64bit = true;
-		break;
-	default:
-		is64bit = false;
-	}
+	struct nvme_command scmd = {
+		.prop_set = {
+			.opcode	= nvme_fabrics_command,
+			.fctype	= nvme_fabrics_type_property_set,
+			.offset	= cpu_to_le32(offset),
+			.value = cpu_to_le64(value),
+			.attrib = is_64bit_reg(offset),
+		}
+	};
+	struct nvme_passthru_cmd pcmd;
 
-	return nvme_property(fd, nvme_fabrics_type_property_set,
-			off, &val, is64bit ? 1: 0);
+	nvme_to_passthru_cmd(&pcmd, &scmd);
+	return nvme_submit_admin_passthru(fd, &pcmd);
 }
 
 int nvme_get_feature(int fd, __u32 nsid, __u8 fid, __u8 sel, __u32 cdw11,
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index f4553e0bd264..68f0892570b4 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -133,7 +133,7 @@ int nvme_dir_send(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
 int nvme_dir_recv(int fd, __u32 nsid, __u16 dspec, __u8 dtype, __u8 doper,
 		  __u32 data_len, __u32 dw12, void *data, __u32 *result);
 int nvme_get_properties(int fd, void **pbar);
-int nvme_set_property(int fd, int offset, int value);
+int nvme_set_property(int fd, int offset, uint64_t value);
 int nvme_get_property(int fd, int offset, uint64_t *value);
 int nvme_sanitize(int fd, __u8 sanact, __u8 ause, __u8 owpass, __u8 oipbp,
 		  __u8 no_dealloc, __u32 ovrpat);
-- 
2.22.0.rc3
