From: hch@lst.de (Christoph Hellwig)
Date: Fri, 30 Sep 2016 13:51:08 +0200
Subject: [PATCH 3/5] nvme.h: add an enum for cns values
In-Reply-To: <1475236270-18329-1-git-send-email-hch@lst.de>
References: <1475236270-18329-1-git-send-email-hch@lst.de>
Message-ID: <1475236270-18329-4-git-send-email-hch@lst.de>

Ported over from nvme-cli.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/nvme.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 30a4c00..f7b3e35 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -282,6 +282,16 @@ struct nvme_id_ns {
 };
 
 enum {
+	NVME_ID_CNS_NS			= 0x00,
+	NVME_ID_CNS_CTRL		= 0x01,
+	NVME_ID_CNS_NS_ACTIVE_LIST	= 0x02,
+	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
+	NVME_ID_CNS_NS_PRESENT		= 0x11,
+	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
+	NVME_ID_CNS_CTRL_LIST		= 0x13,
+};
+
+enum {
 	NVME_NS_FEAT_THIN	= 1 << 0,
 	NVME_NS_FLBAS_LBA_MASK	= 0xf,
 	NVME_NS_FLBAS_META_EXT	= 0x10,
-- 
2.1.4
