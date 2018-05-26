From: hch@lst.de (Christoph Hellwig)
Date: Sat, 26 May 2018 12:27:25 +0200
Subject: [PATCH 04/14] nvme.h: add the changed namespace list log
In-Reply-To: <20180526102735.31404-1-hch@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
Message-ID: <20180526102735.31404-5-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/nvme.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c37103a4ad38..7ce0f3cf4409 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -751,6 +751,7 @@ enum {
 	NVME_LOG_ERROR		= 0x01,
 	NVME_LOG_SMART		= 0x02,
 	NVME_LOG_FW_SLOT	= 0x03,
+	NVME_LOG_CHANGED_NS	= 0x04,
 	NVME_LOG_CMD_EFFECTS	= 0x05,
 	NVME_LOG_DISC		= 0x70,
 	NVME_LOG_RESERVATION	= 0x80,
@@ -759,6 +760,8 @@ enum {
 	NVME_FWACT_ACTV		= (2 << 3),
 };
 
+#define NVME_MAX_CHANGED_NAMESPACES	1024
+
 struct nvme_identify {
 	__u8			opcode;
 	__u8			flags;
-- 
2.17.0
