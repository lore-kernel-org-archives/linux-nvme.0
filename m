Return-Path: <SRS0=WFi/=JF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBB2C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:22:16 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F34161159
	for <linux-nvme@archiver.kernel.org>; Thu,  8 Apr 2021 12:22:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F34161159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=f/Tod+XAOgju4MmAU2xmc9c8z3aBcU4HFMwxtel5YsA=; b=EBHmDjFMWHBWveoZHbh/mZQi4
	RB2osEpoQsvCbinUedLxRWblK/rpoB+yM64Vvgnx38rJTrSh/BbbseWI1PoJFwmgxvGBtNcXBgVoo
	rlNOYO9+IptDdvKKDGnJZDMRkAIBAspPZkp8OgqJGv0KQ7qlAmm+LJW5jfVXvpDPXkqmHSjKmVn8p
	YzD5JhDSzyKyP6QIeeN8jE8iISVjSOnJYxEaO1EGBxHKgW06e9gB2VRTscJPH8AlTNgVCxnc7CEqo
	hGbsMmH3piuhstmMMxmW6EfkgmZgMnK5D9TmE9oJ3g5Chk9JAmk+2efx9QgB9EHK6h7lF0Myc+7Qx
	gSMVcL5sw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lUTfo-007xsG-63; Thu, 08 Apr 2021 12:22:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdn-007xNh-29
 for linux-nvme@lists.infradead.org; Thu, 08 Apr 2021 12:20:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=H0JzaUwTUMWBivFN9pCtdWyvldYlXmoQglbkP0ysPl0=; b=MJhNuhMxjg7Z2BY/HbKPsFvCWq
 bdCiCrGH0ytDMEhQwCklNjBUuEAM0Kt+3Ax+y36awpIF5elM9WwHi7u9GCX9ek0yj1vr0NzTxzJMU
 E9ylPplmisI7zN5k57pXhufAkp/DkQ329woUR6oiXfTvE4sB+hcTus86qYAh1g2uKKvQm/I3VQ4HY
 LvkNTaDlq9N35f1uiZ4Ls3sjisdxEPnfaIsigVf3JV07HWL3qta9sYmwo0TeXaCGvR6f72UHrMYuX
 4kk0N+X1KUCkhLC0mwhP3HeX7t+SILwKMTdcKkWAOZVgCsvPOxaevdMB1AiupvDiRlknYBo9eFLoB
 cbkltKOA==;
Received: from [2001:4bb8:188:4907:196e:5227:9015:fba2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1lUTdj-00HAUD-4A; Thu, 08 Apr 2021 12:20:03 +0000
From: Christoph Hellwig <hch@lst.de>
To: Minwoo Im <minwoo.im.dev@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Sagi Grimberg <sagi@grimberg.me>
Cc: Kanchan Joshi <joshiiitr@gmail.com>,
 Javier Gonz??lez <javier.gonz@samsung.com>, linux-nvme@lists.infradead.org
Subject: [PATCH 10/13] nvme: move nvme_ns_head_ops to multipath.c
Date: Thu,  8 Apr 2021 14:08:39 +0200
Message-Id: <20210408120842.1450092-11-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210408120842.1450092-1-hch@lst.de>
References: <20210408120842.1450092-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Move the multipath block_device_operations to multipath.c, where they
belong.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      | 31 ++++---------------------------
 drivers/nvme/host/multipath.c | 25 ++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  5 ++++-
 3 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9637f2e5e9232c..0072df1dfd54c7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -549,12 +549,12 @@ static void nvme_free_ns_head(struct kref *ref)
 	kfree(head);
 }
 
-static bool nvme_tryget_ns_head(struct nvme_ns_head *head)
+bool nvme_tryget_ns_head(struct nvme_ns_head *head)
 {
 	return kref_get_unless_zero(&head->ref);
 }
 
-static void nvme_put_ns_head(struct nvme_ns_head *head)
+void nvme_put_ns_head(struct nvme_ns_head *head)
 {
 	kref_put(&head->ref, nvme_free_ns_head);
 }
@@ -1511,7 +1511,7 @@ static void nvme_release(struct gendisk *disk, fmode_t mode)
 	nvme_put_ns(ns);
 }
 
-static int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
+int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
 	/* some standard values */
 	geo->heads = 1 << 6;
@@ -1937,7 +1937,7 @@ static int nvme_pr_release(struct block_device *bdev, u64 key, enum pr_type type
 	return nvme_pr_command(bdev, cdw10, key, 0, nvme_cmd_resv_release);
 }
 
-static const struct pr_ops nvme_pr_ops = {
+const struct pr_ops nvme_pr_ops = {
 	.pr_register	= nvme_pr_register,
 	.pr_reserve	= nvme_pr_reserve,
 	.pr_release	= nvme_pr_release,
@@ -1978,18 +1978,6 @@ static const struct block_device_operations nvme_bdev_ops = {
 };
 
 #ifdef CONFIG_NVME_MULTIPATH
-static int nvme_ns_head_open(struct block_device *bdev, fmode_t mode)
-{
-	if (!nvme_tryget_ns_head(bdev->bd_disk->private_data))
-		return -ENXIO;
-	return 0;
-}
-
-static void nvme_ns_head_release(struct gendisk *disk, fmode_t mode)
-{
-	nvme_put_ns_head(disk->private_data);
-}
-
 struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys)
 {
 	struct nvme_ctrl *ctrl;
@@ -2009,17 +1997,6 @@ struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys)
 	mutex_unlock(&nvme_subsystems_lock);
 	return ctrl;
 }
-
-const struct block_device_operations nvme_ns_head_ops = {
-	.owner		= THIS_MODULE,
-	.submit_bio	= nvme_ns_head_submit_bio,
-	.open		= nvme_ns_head_open,
-	.release	= nvme_ns_head_release,
-	.ioctl		= nvme_ns_head_ioctl,
-	.getgeo		= nvme_getgeo,
-	.report_zones	= nvme_report_zones,
-	.pr_ops		= &nvme_pr_ops,
-};
 #endif /* CONFIG_NVME_MULTIPATH */
 
 static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0f42b7e94ce3f3..2bbc1685799d44 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -294,7 +294,7 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	return false;
 }
 
-blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
+static blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 {
 	struct nvme_ns_head *head = bio->bi_bdev->bd_disk->private_data;
 	struct device *dev = disk_to_dev(head->disk);
@@ -334,6 +334,29 @@ blk_qc_t nvme_ns_head_submit_bio(struct bio *bio)
 	return ret;
 }
 
+static int nvme_ns_head_open(struct block_device *bdev, fmode_t mode)
+{
+	if (!nvme_tryget_ns_head(bdev->bd_disk->private_data))
+		return -ENXIO;
+	return 0;
+}
+
+static void nvme_ns_head_release(struct gendisk *disk, fmode_t mode)
+{
+	nvme_put_ns_head(disk->private_data);
+}
+
+const struct block_device_operations nvme_ns_head_ops = {
+	.owner		= THIS_MODULE,
+	.submit_bio	= nvme_ns_head_submit_bio,
+	.open		= nvme_ns_head_open,
+	.release	= nvme_ns_head_release,
+	.ioctl		= nvme_ns_head_ioctl,
+	.getgeo		= nvme_getgeo,
+	.report_zones	= nvme_report_zones,
+	.pr_ops		= &nvme_pr_ops,
+};
+
 static void nvme_requeue_work(struct work_struct *work)
 {
 	struct nvme_ns_head *head =
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index d41c9ceeafa1b8..c6102ce83bb405 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -656,6 +656,8 @@ int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
 		struct nvme_ns_head **head, int *srcu_idx);
 void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
+bool nvme_tryget_ns_head(struct nvme_ns_head *head);
+void nvme_put_ns_head(struct nvme_ns_head *head);
 struct nvme_ctrl *nvme_find_get_live_ctrl(struct nvme_subsystem *subsys);
 int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg);
@@ -663,8 +665,10 @@ int nvme_ns_head_ioctl(struct block_device *bdev, fmode_t mode,
 		unsigned int cmd, unsigned long arg);
 long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg);
+int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 
 extern const struct attribute_group *nvme_ns_id_attr_groups[];
+extern const struct pr_ops nvme_pr_ops;
 extern const struct block_device_operations nvme_ns_head_ops;
 
 #ifdef CONFIG_NVME_MULTIPATH
@@ -688,7 +692,6 @@ void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
-blk_qc_t nvme_ns_head_submit_bio(struct bio *bio);
 
 static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 {
-- 
2.30.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
