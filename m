From: guanjx09@163.com (guanjx09)
Date: Sat, 3 Jun 2017 11:08:54 +0800
Subject: [PATCH 1/2] nvme-cli: add fields into identify controller data
 structure
In-Reply-To: <20170602074600.GA11424@infradead.org>
References: <1496387899-26012-1-git-send-email-guanjunxiong@huawei.com>
 <1496387899-26012-2-git-send-email-guanjunxiong@huawei.com>
 <20170602074600.GA11424@infradead.org>
Message-ID: <e704f915-f08f-6fe9-1132-81d7b6845c7d@163.com>

Hi,Christoph

On Friday, June 02, 2017 03:46 PM, Christoph Hellwig wrote:
> Please also add them to the kernel copy of the header so that they
> stay in sync.  Except for that his looks fine to me:
> 
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> 

Here is the patch which adds those fields into nvme_id_ctrl structure
in the kernel copy of the header. Does it looks good?

Thanks for your review.
Best ,
Guan Junxiong

---
>From 5f6fa71d885e7cb64cdf5a5ef5e03cee5a5f6f52 Mon Sep 17 00:00:00 2001
From: Guan Junxiong <guanjunxiong@huawei.com>
Date: Fri, 2 Jun 2017 23:13:28 +0800
Subject: [PATCH] nvme: add fields into identify controller data structure

NVMe 1.3 inctrodues new fields such as EDSTT, DSTO, FWUG, HCTMA, MNTMT,
MXTMT, SANICAP into the idenfity controller data structure. So we add
them for later use.
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
2.7.4
