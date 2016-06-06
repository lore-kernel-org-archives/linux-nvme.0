From: hch@lst.de (Christoph Hellwig)
Date: Mon,  6 Jun 2016 23:20:46 +0200
Subject: [PATCH 04/10] nvme.h: add AER constants
In-Reply-To: <1465248052-17811-1-git-send-email-hch@lst.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
Message-ID: <1465248052-17811-5-git-send-email-hch@lst.de>

Reviewed-by: Jay Freyensee <james.p.freyensee at intel.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Ming Lin <ming.l at ssi.samsung.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/nvme.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9807d98..a9b8c7b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -284,6 +284,12 @@ struct nvme_reservation_status {
 	} regctl_ds[];
 };
 
+enum nvme_async_event_type {
+	NVME_AER_TYPE_ERROR	= 0,
+	NVME_AER_TYPE_SMART	= 1,
+	NVME_AER_TYPE_NOTICE	= 2,
+};
+
 /* I/O commands */
 
 enum nvme_opcode {
-- 
2.1.4
