From: hch@lst.de (Christoph Hellwig)
Date: Mon, 17 Aug 2015 21:09:40 +0200
Subject: [PATCH 2/2] nvme.h: add missing endianess annotations
In-Reply-To: <1439838580-29647-1-git-send-email-hch@lst.de>
References: <1439838580-29647-1-git-send-email-hch@lst.de>
Message-ID: <1439838580-29647-3-git-send-email-hch@lst.de>

Doesn't matter for the current NVMe driver, but we might as well get it in
order for future software controller implementations.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/uapi/linux/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 732b32e..d1b644b 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -50,8 +50,8 @@ struct nvme_id_ctrl {
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
