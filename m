From: hare@suse.de (Hannes Reinecke)
Date: Thu, 20 Sep 2018 11:09:35 +0200
Subject: [PATCH 2/6] nvme-ioctl: retrieve log pages in 4k chunks
In-Reply-To: <20180920090939.6348-1-hare@suse.de>
References: <20180920090939.6348-1-hare@suse.de>
Message-ID: <20180920090939.6348-3-hare@suse.de>

Some log pages increase with the scale of the subsystem, so the
overall size might be larger than the MDTS value for that controller.
In order to avoid having to pass in the MDTS value we should restrict
the transfer size to 4k and retrieve the log page in 4k chunks.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 nvme-ioctl.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/nvme-ioctl.c b/nvme-ioctl.c
index 03842d2..b168699 100644
--- a/nvme-ioctl.c
+++ b/nvme-ioctl.c
@@ -421,8 +421,30 @@ int nvme_get_log13(int fd, __u32 nsid, __u8 log_id, __u8 lsp, __u64 lpo,
 
 int nvme_get_log(int fd, __u32 nsid, __u8 log_id, __u32 data_len, void *data)
 {
-	return nvme_get_log13(fd, nsid, log_id, NVME_NO_LOG_LSP, NVME_NO_LOG_LPO,
-			      0, 0, data_len, data);
+	void *ptr = data;
+	__u32 offset = 0, xfer_len = data_len;
+	int ret;
+
+	/*
+	 * 4k is the smallest possible transfer unit, so by
+	 * restricting ourselves for 4k transfers we avoid having
+	 * to check the MDTS value of the controller.
+	 */
+	do {
+		xfer_len = data_len - offset;
+		if (xfer_len > 4096)
+			xfer_len = 4096;
+
+		ret = nvme_get_log13(fd, nsid, log_id, NVME_NO_LOG_LSP,
+				     offset, 0, false, xfer_len, ptr);
+		if (ret)
+			return ret;
+
+		offset += xfer_len;
+		ptr += xfer_len;
+	} while (offset < data_len);
+
+	return 0;
 }
 
 int nvme_get_telemetry_log(int fd, void *lp, int generate_report,
-- 
2.13.7
