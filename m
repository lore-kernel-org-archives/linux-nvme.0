From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 16 Nov 2015 15:34:46 +0100
Subject: [PATCH 12/13] nvme: remove reserved double word
In-Reply-To: <1447684487-25539-1-git-send-email-m@bjorling.me>
References: <1447684487-25539-1-git-send-email-m@bjorling.me>
Message-ID: <1447684487-25539-13-git-send-email-m@bjorling.me>

The specification was updated the remove the double word just after
number of configuration groups and capabilities. Update the identify
structure to reflect it.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/nvme/host/lightnvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index fd37123..7e82fe3 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -194,11 +194,11 @@ struct nvme_nvm_id {
 	__u8			ver_id;
 	__u8			vmnt;
 	__u8			cgrps;
-	__u8			res[5];
+	__u8			res;
 	__le32			cap;
 	__le32			dom;
 	struct nvme_nvm_addr_format ppaf;
-	__u8			resv[224];
+	__u8			resv[228];
 	struct nvme_nvm_id_group groups[4];
 } __packed;
 
-- 
2.1.4
