From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 16 Nov 2015 15:34:39 +0100
Subject: [PATCH 05/13] lightnvm: expose mccap in identify command
In-Reply-To: <1447684487-25539-1-git-send-email-m@bjorling.me>
References: <1447684487-25539-1-git-send-email-m@bjorling.me>
Message-ID: <1447684487-25539-6-git-send-email-m@bjorling.me>

The mccap field is required for I/O command option support. It defines the
following flash access modes:

 * SLC mode
 * Erase/Program Suspension
 * Scramble On/Off
 * Encryption

It is slotted in between mpos and cpar, changing the offset for
cpar as well.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/nvme/host/lightnvm.c | 4 +++-
 include/linux/lightnvm.h     | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 60687ed..52b311c 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -169,8 +169,9 @@ struct nvme_nvm_id_group {
 	__le32			tbet;
 	__le32			tbem;
 	__le32			mpos;
+	__le32			mccap;
 	__le16			cpar;
-	__u8			reserved[910];
+	__u8			reserved[906];
 } __packed;
 
 struct nvme_nvm_addr_format {
@@ -265,6 +266,7 @@ static int init_grps(struct nvm_id *nvm_id, struct nvme_nvm_id *nvme_nvm_id)
 		dst->tbet = le32_to_cpu(src->tbet);
 		dst->tbem = le32_to_cpu(src->tbem);
 		dst->mpos = le32_to_cpu(src->mpos);
+		dst->mccap = le32_to_cpu(src->mccap);
 
 		dst->cpar = le16_to_cpu(src->cpar);
 	}
diff --git a/include/linux/lightnvm.h b/include/linux/lightnvm.h
index 9b3dc1b..2572856 100644
--- a/include/linux/lightnvm.h
+++ b/include/linux/lightnvm.h
@@ -74,6 +74,7 @@ struct nvm_id_group {
 	u32	tbet;
 	u32	tbem;
 	u32	mpos;
+	u32	mccap;
 	u16	cpar;
 	u8	res[913];
 } __packed;
-- 
2.1.4
