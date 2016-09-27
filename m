From: hch@infradead.org (Christoph Hellwig)
Date: Tue, 27 Sep 2016 07:50:13 -0700
Subject: nvme-cli won't build
In-Reply-To: <20160926221544.GA6978@infradead.org>
References: <026701d21843$3f68bd70$be3a3850$@opengridcomputing.com>
 <20160926221544.GA6978@infradead.org>
Message-ID: <20160927145013.GA5310@infradead.org>

The patch below will fix it for you:

diff --git a/linux/nvme.h b/linux/nvme.h
index c3ed1df..30a4c00 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
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
