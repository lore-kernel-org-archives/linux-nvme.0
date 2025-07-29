Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 265C1C87FCA
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QAf4+6gSs+ovPFjIpB5VlLCU1STmf4cOPo4gg2gw9AA=; b=wGcZAxf0G/49RO4xTEHwvxcG4x
	5lOVl0HnVujPszYQOGl/1ZnJSbrQAVTBB7Sdvxeq3Hs8aZ2xszFp/F0oRrQVHvpIv/EzaYaOZKwo4
	b2MFe188aD5e6xXNb/6BJ8zVTMjVZIv0iNipgvss64+H+B+vOtU7lQcDJpVk9BhWHPWY69/m88Wbb
	Ua/7iBKn7oAtoblUrQnNJYvppn1SNAm+/inVljBXJ4aogqsDtpKK1uM0pnTFEsii6VVResFbotvRk
	149nAn03oCHPHbah+KkDqRRLDdqELL56Y0W0KZAmW3sl4Cqk5VtribbbY0tqYaxB9DZVwt9EBKoaN
	bWfW6zOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeQg-0000000G5TR-1nHY;
	Tue, 29 Jul 2025 07:07:18 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeQc-0000000G5RM-0mK8
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 07:07:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 6902AA528FA;
	Tue, 29 Jul 2025 07:07:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC8BC4CEEF;
	Tue, 29 Jul 2025 07:07:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753772833;
	bh=Idlwr4yl3q05RCLTbZ/7xbNEOeJM6YQtv93m55Gowpo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YIA5oejOOGZMyO2vqSg08EkdcCPQTcBYy0yPnTRY0rDzkZkee20HNE+LqmdLiWH00
	 TRgCA7Y6GAPzGgfHd7SS8zSFXOabv8Vszqx/c8qOsHw1XKEGDS09AcIcAISF7lNEcU
	 d+etWVwTBcGfmePtmEHw7sTPmlVIIWRd0G17/MAUJBb7JVApsMvLooSTAn12pY0w+D
	 +gwBP8fpVkRCZUaDA6YMAojxd3aFDw3P2HVqtVTT2hhwTdCn0kkO9Omsm2pce03e+M
	 kQ9o5DWBNfcN1f+Nvw4cCnpmg+2AEWZxuPX1Iqs6pSJGbDQhsFdu76LyamvB3D/t74
	 s6bsb9gQwRvzw==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 4/6] nvme: add 'sector' parameter to nvme_find_path()
Date: Tue, 29 Jul 2025 09:06:51 +0200
Message-ID: <20250729070653.125258-5-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729070653.125258-1-hare@kernel.org>
References: <20250729070653.125258-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_000714_385679_51233A6B 
X-CRM114-Status: GOOD (  15.45  )
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

From: Hannes Reinecke <hare@kernel.org>

An nvme multipath iopolicy might need to make scheduling decisions based
on the starting sector of the I/O, so add an argument 'sector' to
nvme_find_path().

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/ioctl.c     | 7 ++++---
 drivers/nvme/host/multipath.c | 8 ++++----
 drivers/nvme/host/nvme.h      | 2 +-
 drivers/nvme/host/pr.c        | 2 +-
 drivers/nvme/host/sysfs.c     | 2 +-
 5 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 6b3ac8ae3f34..e210908ad78b 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -716,7 +716,8 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 		flags |= NVME_IOCTL_PARTITION;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	/* TBD: extract LBA and size to get the routing right */
+	ns = nvme_find_path(head, 0);
 	if (!ns)
 		goto out_unlock;
 
@@ -747,7 +748,7 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, 0);
 	if (!ns)
 		goto out_unlock;
 
@@ -767,7 +768,7 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
 	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
 	int srcu_idx = srcu_read_lock(&head->srcu);
-	struct nvme_ns *ns = nvme_find_path(head);
+	struct nvme_ns *ns = nvme_find_path(head, 0);
 	int ret = -EINVAL;
 
 	if (ns)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 696c2f817bed..dee40bd73449 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -466,7 +466,7 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 	return ns;
 }
 
-inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head, sector_t sector)
 {
 	switch (READ_ONCE(head->subsys->iopolicy)) {
 	case NVME_IOPOLICY_QD:
@@ -528,7 +528,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		return;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, bio->bi_iter.bi_sector);
 	if (likely(ns)) {
 		bio_set_dev(bio, ns->disk->part0);
 		bio->bi_opf |= REQ_NVME_MPATH;
@@ -570,7 +570,7 @@ static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, 0);
 	if (ns)
 		ret = nvme_ns_get_unique_id(ns, id, type);
 	srcu_read_unlock(&head->srcu, srcu_idx);
@@ -586,7 +586,7 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, sector);
 	if (ns)
 		ret = nvme_ns_report_zones(ns, sector, nr_zones, cb, data);
 	srcu_read_unlock(&head->srcu, srcu_idx);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2aff8df55d1c..73b966a6653a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -951,7 +951,7 @@ extern const struct block_device_operations nvme_bdev_ops;
 struct nvme_subsystem *nvme_find_get_subsystem(const char *subsysnqn);
 void nvme_put_subsystem(struct nvme_subsystem *subsys);
 void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
-struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
+struct nvme_ns *nvme_find_path(struct nvme_ns_head *head, sector_t sector);
 #ifdef CONFIG_NVME_MULTIPATH
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index ca6a74607b13..ba8cee2d6001 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -54,7 +54,7 @@ static int nvme_send_ns_head_pr_command(struct block_device *bdev,
 {
 	struct nvme_ns_head *head = bdev->bd_disk->private_data;
 	int srcu_idx = srcu_read_lock(&head->srcu);
-	struct nvme_ns *ns = nvme_find_path(head);
+	struct nvme_ns *ns = nvme_find_path(head, 0);
 	int ret = -EWOULDBLOCK;
 
 	if (ns) {
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 378107cf7a21..ebbdf512a31d 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -194,7 +194,7 @@ static int ns_head_update_nuse(struct nvme_ns_head *head)
 		return 0;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, 0);
 	if (!ns)
 		goto out_unlock;
 
-- 
2.43.0


