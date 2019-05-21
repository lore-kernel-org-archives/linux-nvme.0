From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Wed, 22 May 2019 01:36:57 +0900
Subject: [PATCH V4 1/3] nvme-status: Introduce nvme status module to map errno
In-Reply-To: <20190521163659.24577-1-minwoo.im.dev@gmail.com>
References: <20190521163659.24577-1-minwoo.im.dev@gmail.com>
Message-ID: <20190521163659.24577-2-minwoo.im.dev@gmail.com>

Background:
  It's not enough to return the nvme status value in main() because it's
allowed to be in 8bits, but nvme status is indicated in 16bits.  So we
has not been able to figure out what kind of nvme status has been
returned by return value.

  This patch introduces nvme-status module that manages mapping between
nvme status and errno.  It's not possible to make 1:1 mapping relations,
but we can map it as a groups.

All the internal errors which has been returned in a negative value will
be returned with ECOMM that indicates communication errors.  In this
case, we can see what happened via stderr.

Cc: Keith Busch <keith.busch at intel.com>
Cc: Chaitanya Kulkarni <chaitanya.Kulkarni at wdc.com>
Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 Makefile      |   3 +-
 linux/nvme.h  |   6 ++
 nvme-status.c | 155 ++++++++++++++++++++++++++++++++++++++++++++++++++
 nvme-status.h |  14 +++++
 4 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 nvme-status.c
 create mode 100644 nvme-status.h

diff --git a/Makefile b/Makefile
index 4bfbebb..1e50a65 100644
--- a/Makefile
+++ b/Makefile
@@ -32,7 +32,8 @@ override CFLAGS += -DNVME_VERSION='"$(NVME_VERSION)"'
 NVME_DPKG_VERSION=1~`lsb_release -sc`
 
 OBJS := argconfig.o suffix.o parser.o nvme-print.o nvme-ioctl.o \
-	nvme-lightnvm.o fabrics.o json.o nvme-models.o plugin.o
+	nvme-lightnvm.o fabrics.o json.o nvme-models.o plugin.o \
+	nvme-status.o
 
 PLUGIN_OBJS :=					\
 	plugins/intel/intel-nvme.o		\
diff --git a/linux/nvme.h b/linux/nvme.h
index 69f287e..9963e90 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -1319,6 +1319,12 @@ static inline bool nvme_is_write(struct nvme_command *cmd)
 	return cmd->common.opcode & 1;
 }
 
+enum {
+	NVME_SCT_GENERIC		= 0x0,
+	NVME_SCT_CMD_SPECIFIC		= 0x1,
+	NVME_SCT_MEDIA			= 0x2,
+};
+
 enum {
 	/*
 	 * Generic Command Status:
diff --git a/nvme-status.c b/nvme-status.c
new file mode 100644
index 0000000..c69ff3f
--- /dev/null
+++ b/nvme-status.c
@@ -0,0 +1,155 @@
+#include <linux/types.h>
+#include <stdbool.h>
+#include <errno.h>
+
+#include "nvme.h"
+#include "nvme-status.h"
+
+static inline __u8 nvme_generic_status_to_errno(__u16 status)
+{
+	switch (status) {
+	case NVME_SC_INVALID_OPCODE:
+	case NVME_SC_INVALID_FIELD:
+	case NVME_SC_INVALID_NS:
+	case NVME_SC_SGL_INVALID_LAST:
+	case NVME_SC_SGL_INVALID_COUNT:
+	case NVME_SC_SGL_INVALID_DATA:
+	case NVME_SC_SGL_INVALID_METADATA:
+	case NVME_SC_SGL_INVALID_TYPE:
+	case NVME_SC_SGL_INVALID_OFFSET:
+	case NVME_SC_SGL_INVALID_SUBTYPE:
+		return EINVAL;
+	case NVME_SC_CMDID_CONFLICT:
+		return EADDRINUSE;
+	case NVME_SC_DATA_XFER_ERROR:
+	case NVME_SC_INTERNAL:
+	case NVME_SC_SANITIZE_FAILED:
+		return EIO;
+	case NVME_SC_POWER_LOSS:
+	case NVME_SC_ABORT_REQ:
+	case NVME_SC_ABORT_QUEUE:
+	case NVME_SC_FUSED_FAIL:
+	case NVME_SC_FUSED_MISSING:
+		return EWOULDBLOCK;
+	case NVME_SC_CMD_SEQ_ERROR:
+		return EILSEQ;
+	case NVME_SC_SANITIZE_IN_PROGRESS:
+		return EINPROGRESS;
+	case NVME_SC_NS_WRITE_PROTECTED:
+	case NVME_SC_NS_NOT_READY:
+	case NVME_SC_RESERVATION_CONFLICT:
+		return EACCES;
+	case NVME_SC_LBA_RANGE:
+		return EREMOTEIO;
+	case NVME_SC_CAP_EXCEEDED:
+		return ENOSPC;
+	}
+
+	return EIO;
+}
+
+static inline __u8 nvme_cmd_specific_status_to_errno(__u16 status)
+{
+	switch (status) {
+	case NVME_SC_CQ_INVALID:
+	case NVME_SC_QID_INVALID:
+	case NVME_SC_QUEUE_SIZE:
+	case NVME_SC_FIRMWARE_SLOT:
+	case NVME_SC_FIRMWARE_IMAGE:
+	case NVME_SC_INVALID_VECTOR:
+	case NVME_SC_INVALID_LOG_PAGE:
+	case NVME_SC_INVALID_FORMAT:
+	case NVME_SC_INVALID_QUEUE:
+	case NVME_SC_NS_INSUFFICIENT_CAP:
+	case NVME_SC_NS_ID_UNAVAILABLE:
+	case NVME_SC_CTRL_LIST_INVALID:
+	case NVME_SC_BAD_ATTRIBUTES:
+	case NVME_SC_INVALID_PI:
+		return EINVAL;
+	case NVME_SC_ABORT_LIMIT:
+	case NVME_SC_ASYNC_LIMIT:
+		return EDQUOT;
+	case NVME_SC_FW_NEEDS_CONV_RESET:
+	case NVME_SC_FW_NEEDS_SUBSYS_RESET:
+	case NVME_SC_FW_NEEDS_MAX_TIME:
+		return ERESTART;
+	case NVME_SC_FEATURE_NOT_SAVEABLE:
+	case NVME_SC_FEATURE_NOT_CHANGEABLE:
+	case NVME_SC_FEATURE_NOT_PER_NS:
+	case NVME_SC_FW_ACTIVATE_PROHIBITED:
+	case NVME_SC_NS_IS_PRIVATE:
+	case NVME_SC_BP_WRITE_PROHIBITED:
+	case NVME_SC_READ_ONLY:
+		return EPERM;
+	case NVME_SC_OVERLAPPING_RANGE:
+	case NVME_SC_NS_NOT_ATTACHED:
+		return ENOSPC;
+	case NVME_SC_NS_ALREADY_ATTACHED:
+		return EALREADY;
+	case NVME_SC_THIN_PROV_NOT_SUPP:
+	case NVME_SC_ONCS_NOT_SUPPORTED:
+		return EOPNOTSUPP;
+	}
+
+	return EIO;
+}
+
+static inline __u8 nvme_fabrics_status_to_errno(__u16 status)
+{
+	switch (status) {
+	case NVME_SC_CONNECT_FORMAT:
+	case NVME_SC_CONNECT_INVALID_PARAM:
+		return EINVAL;
+	case NVME_SC_CONNECT_CTRL_BUSY:
+		return EBUSY;
+	case NVME_SC_CONNECT_RESTART_DISC:
+		return ERESTART;
+	case NVME_SC_CONNECT_INVALID_HOST:
+		return ECONNREFUSED;
+	case NVME_SC_DISCOVERY_RESTART:
+		return EAGAIN;
+	case NVME_SC_AUTH_REQUIRED:
+		return EPERM;
+	}
+
+	return EIO;
+}
+
+/*
+ * nvme_status_to_errno - It converts given status to errno mapped
+ * @status: >= 0 for nvme status field in completion queue entry,
+ *          < 0 for linux internal errors
+ * @fabrics: true if given status is for fabrics
+ *
+ * Notes: This function will convert a given status to an errno mapped
+ */
+__u8 nvme_status_to_errno(int status, bool fabrics)
+{
+	__u8 sct;
+
+	if (!status)
+		return 0;
+
+	if (status < 0)
+		return ECOMM;
+
+	/*
+	 * The actual status code is enough with masking 0xff, but we need to
+	 * cover status code type which is 3bits with 0x7ff.
+	 */
+	status &= 0x7ff;
+
+	sct = nvme_status_type(status);
+	if (sct == NVME_SCT_GENERIC)
+		return nvme_generic_status_to_errno(status);
+	else if (sct == NVME_SCT_CMD_SPECIFIC && !fabrics)
+		return nvme_cmd_specific_status_to_errno(status);
+	else if (sct == NVME_SCT_CMD_SPECIFIC && fabrics)
+		return nvme_fabrics_status_to_errno(status);
+
+	/*
+	 * Media, integrity related status, and the others will be mapped to
+	 * EIO.
+	 */
+	return EIO;
+}
diff --git a/nvme-status.h b/nvme-status.h
new file mode 100644
index 0000000..92a474c
--- /dev/null
+++ b/nvme-status.h
@@ -0,0 +1,14 @@
+#include <linux/types.h>
+#include <stdbool.h>
+
+/*
+ * nvme_status_type - It gives SCT(Status Code Type) in status field in
+ *                    completion queue entry.
+ * @status: status field located at DW3 in completion queue entry
+ */
+static inline __u8 nvme_status_type(__u16 status)
+{
+	return (status & 0x700) >> 8;
+}
+
+__u8 nvme_status_to_errno(int status, bool fabrics);
-- 
2.21.0
