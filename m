From: hch@lst.de (Christoph Hellwig)
Date: Tue,  7 Jun 2016 17:19:21 +0200
Subject: [PATCH 05/11] Adds nvme_discovery_log()
In-Reply-To: <1465312767-10070-1-git-send-email-hch@lst.de>
References: <1465312767-10070-1-git-send-email-hch@lst.de>
Message-ID: <1465312767-10070-6-git-send-email-hch@lst.de>

From: Ming Lin <ming.l@ssi.samsung.com>

Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-and-tested-by: Sagi Grimberg <sagi at grimberg.me>
Tested-by: Armen Baloyan <armenx.baloyan at intel.com>
---
 nvme-ioctl.c | 5 +++++
 nvme-ioctl.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 0510837..2a26ca2 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -396,6 +396,11 @@ int nvme_intel_smart_log(int fd, __u32 nsid,
 			intel_smart_log);
 }
 
+int nvme_discovery_log(int fd, struct nvmf_disc_rsp_page_hdr *log, __u32 size)
+{
+	return nvme_get_log(fd, 0, NVME_LOG_DISC, size, log);
+}
+
 int nvme_feature(int fd, __u8 opcode, __u32 nsid, __u32 cdw10, __u32 cdw11,
 		 __u32 data_len, void *data, __u32 *result)
 {
diff --git a/nvme-ioctl.h b/nvme-ioctl.h
index 77c0bc8..5485b64 100644
--- a/nvme-ioctl.h
+++ b/nvme-ioctl.h
@@ -83,6 +83,7 @@ int nvme_error_log(int fd, __u32 nsid, int entries,
 int nvme_smart_log(int fd, __u32 nsid, struct nvme_smart_log *smart_log);
 int nvme_intel_smart_log(int fd, __u32 nsid,
 			 struct nvme_additional_smart_log *intel_smart_log);
+int nvme_discovery_log(int fd, struct nvmf_disc_rsp_page_hdr *log, __u32 size);
 
 int nvme_feature(int fd, __u8 opcode, __u32 nsid, __u32 cdw10,
 		 __u32 cdw11, __u32 data_len, void *data, __u32 *result);
-- 
2.1.4
