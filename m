From: hch@lst.de (Christoph Hellwig)
Date: Mon,  6 Jun 2016 23:20:43 +0200
Subject: [PATCH 01/10] nvme.h: add RTD3R, RTD3E and OAES fields
In-Reply-To: <1465248052-17811-1-git-send-email-hch@lst.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
Message-ID: <1465248052-17811-2-git-send-email-hch@lst.de>

These have been added in NVMe 1.2 and we'll need at least oaes for the
NVMe target driver.

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Jay Freyensee <james.p.freyensee at intel.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/nvme.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 7d51b29..ff5ebc3 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -107,7 +107,10 @@ struct nvme_id_ctrl {
 	__u8			mdts;
 	__le16			cntlid;
 	__le32			ver;
-	__u8			rsvd84[172];
+	__le32			rtd3r;
+	__le32			rtd3e;
+	__le32			oaes;
+	__u8			rsvd96[160];
 	__le16			oacs;
 	__u8			acl;
 	__u8			aerl;
-- 
2.1.4
