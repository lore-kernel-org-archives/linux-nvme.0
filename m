From: kenneth.heitke@intel.com (Kenneth Heitke)
Date: Fri, 10 May 2019 18:04:06 -0600
Subject: [PATCH] nvme: add support for Verify command opcode
Message-ID: <20190511000406.5458-1-kenneth.heitke@intel.com>

This allows the Verify command to be sent using the
NVME_IOCTL_SUBMIT_IO ioctl.

Signed-off-by: Kenneth Heitke <kenneth.heitke at intel.com>
---
 drivers/nvme/host/core.c  | 1 +
 drivers/nvme/host/trace.c | 1 +
 drivers/nvme/host/trace.h | 1 +
 include/linux/nvme.h      | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index eebaeadaa800..8bbcae22fd22 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1193,6 +1193,7 @@ static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 	switch (io.opcode) {
 	case nvme_cmd_write:
 	case nvme_cmd_read:
+	case nvme_cmd_verify:
 	case nvme_cmd_compare:
 		break;
 	default:
diff --git a/drivers/nvme/host/trace.c b/drivers/nvme/host/trace.c
index 5f24ea7a28eb..07a963f5be96 100644
--- a/drivers/nvme/host/trace.c
+++ b/drivers/nvme/host/trace.c
@@ -127,6 +127,7 @@ const char *nvme_trace_parse_nvm_cmd(struct trace_seq *p,
 	case nvme_cmd_read:
 	case nvme_cmd_write:
 	case nvme_cmd_write_zeroes:
+	case nvme_cmd_verify:
 		return nvme_trace_read_write(p, cdw10);
 	case nvme_cmd_dsm:
 		return nvme_trace_dsm(p, cdw10);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 97d3c77365b8..38636062435c 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -52,6 +52,7 @@
 		nvme_opcode_name(nvme_cmd_compare),		\
 		nvme_opcode_name(nvme_cmd_write_zeroes),	\
 		nvme_opcode_name(nvme_cmd_dsm),			\
+		nvme_opcode_name(nvme_cmd_verify),		\
 		nvme_opcode_name(nvme_cmd_resv_register),	\
 		nvme_opcode_name(nvme_cmd_resv_report),		\
 		nvme_opcode_name(nvme_cmd_resv_acquire),	\
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c40720cb59ac..73520060bf7c 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -556,6 +556,7 @@ enum nvme_opcode {
 	nvme_cmd_compare	= 0x05,
 	nvme_cmd_write_zeroes	= 0x08,
 	nvme_cmd_dsm		= 0x09,
+	nvme_cmd_verify		= 0x0c,
 	nvme_cmd_resv_register	= 0x0d,
 	nvme_cmd_resv_report	= 0x0e,
 	nvme_cmd_resv_acquire	= 0x11,
-- 
2.17.1
