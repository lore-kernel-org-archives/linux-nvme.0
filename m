Return-Path: <SRS0=7pRJ=KP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F71AC433ED
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:46:21 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1750F610A2
	for <linux-nvme@archiver.kernel.org>; Thu, 20 May 2021 05:46:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1750F610A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=8D1jFHHWK6hu3iFd6VERIUuZEzf25n8ed35CcFkBdmk=; b=Ty6U7eoqVl0vHBnA2Fb5bJQHk
	K4qkXXRJHlo25YKF1rHv81wzH0o+P1DVCvWTEC+uLy9AOfvO+KXWsU5zEj5dRmsfDqXbq9IXSQVE0
	qfh0ZtSxKgxSSPJsTIBwK8sQK4j3xwyZx78PSb69oe6KNv9W2LtgmONd8UvLfA9r83DI2r3tA1Izk
	5TzyOoV1v8Nbwas6Z8AXz4Nc/aRPu3S8BldbliXuEnyROkK9cpgMnHEPEITiOnn4QQIVconMdUcw6
	i9d6A2kGgba2SS/PFRFwQISG2pgp3Kr3lAcLAJmyjdY8LUCzh3GlQVZPVSPLKccpZYMe9pkdRz1Qe
	OFqtVFe1g==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1ljbVc-005yue-48; Thu, 20 May 2021 05:46:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbUI-005yfi-1c
 for linux-nvme@desiato.infradead.org; Thu, 20 May 2021 05:44:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=ZseQMumsS0tvOSbCmdBUlquF82sIpxFF2mhzBssISRU=; b=nuiNu//FzGMTgumdkv9u3He8bK
 iXNpiNApfyJrpJInfmzOVD7/qS0mdCzkT0cwaO41zRN9aHmbMGLPIPZuP7k5Wj8S3PGYLisjasz4R
 4A7doAfVj6NgeTvhlYBq3mpe9M2hGeaIio4knn5FRYGOuffESMEAR9wouOtyvd5aU5QcZ7EvK2HOl
 D+LLiDsb0qlOifHVUSr27a6yHZ9BY0ot9b4NtSbyG5un8EyVaHwKCiHOaXZ2f2shIA/JvfiQdXMhz
 4q+sx/t0YWWZHHkjYC0WLnLKvwxX4EXo/MnnXAxF1eMlnMUFU6axiajAHuyY3XET4ISGHNE7Ew4SY
 9ek8w3lA==;
Received: from [2001:4bb8:180:5add:a633:7cce:5450:3d63] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1ljbUG-00FxMr-8y; Thu, 20 May 2021 05:44:48 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 7/7] nvme: remove nvme_{get,put}_ns_from_disk
Date: Thu, 20 May 2021 07:44:26 +0200
Message-Id: <20210520054426.567241-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210520054426.567241-1-hch@lst.de>
References: <20210520054426.567241-1-hch@lst.de>
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

Now that only one caller is left remove the helpers by restructuring
nvme_pr_command so that it has two helpers for sending a command of to a
given nsid using either the ns_head for multipath, or the namespace
stored in the gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 68 ++++++++++++++++------------------------
 drivers/nvme/host/nvme.h |  5 +--
 2 files changed, 28 insertions(+), 45 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 309b7b3635f0..6c36bf426c3e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1542,36 +1542,6 @@ static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 
-/*
- * Issue ioctl requests on the first available path.  Note that unlike normal
- * block layer requests we will not retry failed request on another controller.
- */
-struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
-		struct nvme_ns_head **head, int *srcu_idx)
-{
-#ifdef CONFIG_NVME_MULTIPATH
-	if (disk->fops == &nvme_ns_head_ops) {
-		struct nvme_ns *ns;
-
-		*head = disk->private_data;
-		*srcu_idx = srcu_read_lock(&(*head)->srcu);
-		ns = nvme_find_path(*head);
-		if (!ns)
-			srcu_read_unlock(&(*head)->srcu, *srcu_idx);
-		return ns;
-	}
-#endif
-	*head = NULL;
-	*srcu_idx = -1;
-	return disk->private_data;
-}
-
-void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx)
-{
-	if (head)
-		srcu_read_unlock(&head->srcu, idx);
-}
-
 static int nvme_ns_open(struct nvme_ns *ns)
 {
 
@@ -1968,30 +1938,46 @@ static char nvme_pr_type(enum pr_type type)
 	}
 };
 
+static int nvme_send_ns_head_pr_command(struct block_device *bdev,
+		struct nvme_command *c, u8 data[16])
+{
+	struct nvme_ns_head *head = bdev->bd_disk->private_data;
+	int srcu_idx = srcu_read_lock(&head->srcu);
+	struct nvme_ns *ns = nvme_find_path(head);
+	int ret = -EWOULDBLOCK;
+
+	if (ns) {
+		c->common.nsid = cpu_to_le32(ns->head->ns_id);
+		ret = nvme_submit_sync_cmd(ns->queue, c, data, 16);
+	}
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return ret;
+}
+	
+static int nvme_send_ns_pr_command(struct nvme_ns *ns, struct nvme_command *c,
+		u8 data[16])
+{
+	c->common.nsid = cpu_to_le32(ns->head->ns_id);
+	return nvme_submit_sync_cmd(ns->queue, c, data, 16);
+}
+
 static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 				u64 key, u64 sa_key, u8 op)
 {
-	struct nvme_ns_head *head = NULL;
-	struct nvme_ns *ns;
 	struct nvme_command c;
-	int srcu_idx, ret;
 	u8 data[16] = { 0, };
 
-	ns = nvme_get_ns_from_disk(bdev->bd_disk, &head, &srcu_idx);
-	if (unlikely(!ns))
-		return -EWOULDBLOCK;
-
 	put_unaligned_le64(key, &data[0]);
 	put_unaligned_le64(sa_key, &data[8]);
 
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = op;
-	c.common.nsid = cpu_to_le32(ns->head->ns_id);
 	c.common.cdw10 = cpu_to_le32(cdw10);
 
-	ret = nvme_submit_sync_cmd(ns->queue, &c, data, 16);
-	nvme_put_ns_from_disk(head, srcu_idx);
-	return ret;
+	if (IS_ENABLED(CONFIG_NVME_MULTIPATH) &&
+	    bdev->bd_disk->fops == &nvme_ns_head_ops)
+		return nvme_send_ns_head_pr_command(bdev, &c, data);
+	return nvme_send_ns_pr_command(bdev->bd_disk->private_data, &c, data);
 }
 
 static int nvme_pr_register(struct block_device *bdev, u64 old,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 01f41b2bf915..1f397ecba16c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -674,9 +674,6 @@ int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp, u8 csi,
 		void *log, size_t size, u64 offset);
-struct nvme_ns *nvme_get_ns_from_disk(struct gendisk *disk,
-		struct nvme_ns_head **head, int *srcu_idx);
-void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx);
 bool nvme_tryget_ns_head(struct nvme_ns_head *head);
 void nvme_put_ns_head(struct nvme_ns_head *head);
 int nvme_cdev_add(struct cdev *cdev, struct device *cdev_device,
@@ -697,6 +694,7 @@ extern const struct attribute_group *nvme_ns_id_attr_groups[];
 extern const struct pr_ops nvme_pr_ops;
 extern const struct block_device_operations nvme_ns_head_ops;
 
+struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
 #ifdef CONFIG_NVME_MULTIPATH
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
@@ -718,7 +716,6 @@ void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
-struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
 
 static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 {
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
