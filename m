From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 13 Jun 2017 09:26:15 +0800
Subject: [PATCH v2] nvme: add fields into identify controller data structure
Message-ID: <1497317175-6932-1-git-send-email-guanjunxiong@huawei.com>

NVMe 1.3 inctrodues new fields such as EDSTT, DSTO, FWUG, HCTMA, MNTMT,
MXTMT, SANICAP into the idenfity controller data structure. So we add
them for later use.

Signed-off-by: Guan Junxiong <guanjunxiong at huawei.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

---
 include/linux/nvme.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b625bac..e5f09f8 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -207,9 +207,15 @@ struct nvme_id_ctrl {
 	__u8			tnvmcap[16];
 	__u8			unvmcap[16];
 	__le32			rpmbs;
-	__u8			rsvd316[4];
+	__le16			edstt;
+	__u8			dsto;
+	__u8			fwug;
 	__le16			kas;
-	__u8			rsvd322[190];
+	__le16			hctma;
+	__le16			mntmt;
+	__le16			mxtmt;
+	__le32			sanicap;
+	__u8			rsvd332[180];
 	__u8			sqes;
 	__u8			cqes;
 	__le16			maxcmd;
-- 
2.6.4.windows.1

changes from v1:
1.send in a formal patch (Christoph)
2.add signed-off-by tag (Christoph)
2.add reviewed-by tag (Sagi)
