From: hch@lst.de (Christoph Hellwig)
Date: Fri, 30 Sep 2016 13:51:07 +0200
Subject: [PATCH 2/5] nvme.h: don't use uuid_be
In-Reply-To: <1475236270-18329-1-git-send-email-hch@lst.de>
References: <1475236270-18329-1-git-send-email-hch@lst.de>
Message-ID: <1475236270-18329-3-git-send-email-hch@lst.de>

This makes life easier for nvme-cli and we don't really need the uuid
type anyway to start with.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/nvme.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c3ed1df..30a4c00 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -16,7 +16,6 @@
 #define _LINUX_NVME_H
 
 #include <linux/types.h>
-#include <linux/uuid.h>
 
 /* NQN names in commands fields specified one size */
 #define NVMF_NQN_FIELD_LEN	256
@@ -803,7 +802,7 @@ struct nvmf_connect_command {
 };
 
 struct nvmf_connect_data {
-	uuid_be		hostid;
+	__u8		hostid[16];
 	__le16		cntlid;
 	char		resv4[238];
 	char		subsysnqn[NVMF_NQN_FIELD_LEN];
-- 
2.1.4
