From: hch@lst.de (Christoph Hellwig)
Date: Sat,  3 Oct 2015 15:51:12 +0200
Subject: [PATCH 3/3] nvme.h: add missing nvme_id_ctrl endianess annotations
In-Reply-To: <1443880272-25801-1-git-send-email-hch@lst.de>
References: <1443880272-25801-1-git-send-email-hch@lst.de>
Message-ID: <1443880272-25801-4-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
Acked-by: Keith Busch <keith.busch at intel.com>
---
 include/linux/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 91a8054..9668d35 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -104,8 +104,8 @@ struct nvme_id_ctrl {
 	__u8			ieee[3];
 	__u8			mic;
 	__u8			mdts;
-	__u16			cntlid;
-	__u32			ver;
+	__le16			cntlid;
+	__le32			ver;
 	__u8			rsvd84[172];
 	__le16			oacs;
 	__u8			acl;
-- 
1.9.1
