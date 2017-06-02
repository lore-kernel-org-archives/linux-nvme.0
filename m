From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Fri, 2 Jun 2017 15:18:18 +0800
Subject: [PATCH 1/2] nvme-cli: add fields into identify controller data
 structure
In-Reply-To: <1496387899-26012-1-git-send-email-guanjunxiong@huawei.com>
References: <1496387899-26012-1-git-send-email-guanjunxiong@huawei.com>
Message-ID: <1496387899-26012-2-git-send-email-guanjunxiong@huawei.com>

NVMe 1.3 inctrodues new fields such as EDSTT, DSTO, FWUG, HCTMA, MNTMT, MXTMT, SANICAP
into the idenfity controller data structure. So we add them. Note that KAS field is
included in the previous NVMe 1.2.1 spec, but not itemized in the nvme-cli.
---
 linux/nvme.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/linux/nvme.h b/linux/nvme.h
index 397c0f1..b2c8dbb 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
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
2.11.1
