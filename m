Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B259AC3271E
	for <linux-nvme@archiver.kernel.org>; Fri,  5 Jul 2024 16:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wHAWRficndaWpi7+X/WDJd1wtfEUvzaEcg2ki5nRRn4=; b=rIzRIauKL4YlRZGBKhvhnHeP4o
	4fEwKbBnY/D0DnHe74+U/uEct1tuXXrx1YOOWqPShw66VowKNnFDKiXjeakOMcepTkDY5bP+XYc62
	uXYaLlmndZZ8iSukTu2InNMSRGRW0xyQiKiceAQiWJcDd4DJkk4OfFfJJK7s2Ks06O9Wf7XP1e4CK
	XuYK86RjVdHxngufKIqtBeTUad/d1EiWUhOpgO8di79MHv1PrYJpPS6MdSjMaY5Ys2eC8enBd/t+P
	eTG22+KiIsJgR3Afe42L+32Lu5NBmNQgGTdTivC1ojH51f8jJztSXY7uVA5+q5E3r7RMXrtZwGdMB
	Y5SF+RSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPm59-0000000GRk3-0sVB;
	Fri, 05 Jul 2024 16:46:47 +0000
Received: from 2a02-8389-2341-5b80-e919-81a4-5d6c-0d5c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:e919:81a4:5d6c:d5c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sPm56-0000000GRjc-2jxs;
	Fri, 05 Jul 2024 16:46:45 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH] nvme: implement ->get_unique_id
Date: Fri,  5 Jul 2024 18:46:26 +0200
Message-ID: <20240705164640.2247869-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Implement the get_unique_id method to allow pNFS SCSI layout access to
NVMe namespaces.

This is the server side implementation of RFC 9561 "Using the Parallel
NFS (pNFS) SCSI Layout to Access Non-Volatile Memory Express (NVMe)
Storage Devices".

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      | 27 +++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c | 16 ++++++++++++++++
 drivers/nvme/host/nvme.h      |  3 +++
 3 files changed, 46 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 782090ce0bc10d..96e0879013b79d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2230,6 +2230,32 @@ static int nvme_update_ns_info(struct nvme_ns *ns, struct nvme_ns_info *info)
 	return ret;
 }
 
+int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],
+		enum blk_unique_id type)
+{
+	struct nvme_ns_ids *ids = &ns->head->ids;
+
+	if (type != BLK_UID_EUI64)
+		return -EINVAL;
+
+	if (memchr_inv(ids->nguid, 0, sizeof(ids->nguid))) {
+		memcpy(id, &ids->nguid, sizeof(ids->nguid));
+		return sizeof(ids->nguid);
+	}
+	if (memchr_inv(ids->eui64, 0, sizeof(ids->eui64))) {
+		memcpy(id, &ids->eui64, sizeof(ids->eui64));
+		return sizeof(ids->eui64);
+	}
+
+	return -EINVAL;
+}
+
+static int nvme_get_unique_id(struct gendisk *disk, u8 id[16],
+		enum blk_unique_id type)
+{
+	return nvme_ns_get_unique_id(disk->private_data, id, type);
+}
+
 #ifdef CONFIG_BLK_SED_OPAL
 static int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 		bool send)
@@ -2285,6 +2311,7 @@ const struct block_device_operations nvme_bdev_ops = {
 	.open		= nvme_open,
 	.release	= nvme_release,
 	.getgeo		= nvme_getgeo,
+	.get_unique_id	= nvme_get_unique_id,
 	.report_zones	= nvme_report_zones,
 	.pr_ops		= &nvme_pr_ops,
 };
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d8b6b4648eaff9..1aed93d792b610 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -427,6 +427,21 @@ static void nvme_ns_head_release(struct gendisk *disk)
 	nvme_put_ns_head(disk->private_data);
 }
 
+static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
+		enum blk_unique_id type)
+{
+	struct nvme_ns_head *head = disk->private_data;
+	struct nvme_ns *ns;
+	int srcu_idx, ret = -EWOULDBLOCK;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head);
+	if (ns)
+		ret = nvme_ns_get_unique_id(ns, id, type);
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+
 #ifdef CONFIG_BLK_DEV_ZONED
 static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
 		unsigned int nr_zones, report_zones_cb cb, void *data)
@@ -454,6 +469,7 @@ const struct block_device_operations nvme_ns_head_ops = {
 	.ioctl		= nvme_ns_head_ioctl,
 	.compat_ioctl	= blkdev_compat_ptr_ioctl,
 	.getgeo		= nvme_getgeo,
+	.get_unique_id	= nvme_ns_head_get_unique_id,
 	.report_zones	= nvme_ns_head_report_zones,
 	.pr_ops		= &nvme_pr_ops,
 };
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f3a41133ac3f97..1907fbc3f5dbb3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1062,6 +1062,9 @@ static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 }
 #endif /* CONFIG_NVME_MULTIPATH */
 
+int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],
+		enum blk_unique_id type);
+
 struct nvme_zone_info {
 	u64 zone_size;
 	unsigned int max_open_zones;
-- 
2.43.0


