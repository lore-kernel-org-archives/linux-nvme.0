Return-Path: <SRS0=D26X=KB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04211C433ED
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 13:49:00 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FC1061059
	for <linux-nvme@archiver.kernel.org>; Thu,  6 May 2021 13:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FC1061059
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zHFHXmbHPAD+PikYqjK3VkMMzd5pJgXA+5tkkYPT1Gs=; b=SNDa96C+e07fut4nx8e2YAqXON
	l35drHFVr3dZz6wu4X5BoBK3k5sbfnVcwqUs87/im/bbkk9Wm8m+A2SDScRVHwrgVEYT/6C/wNIYl
	+odQ/5lycUvxqhD7STpq3k3/OmTjSKUPvCzKYk2i2Ikn8tTWKFOMOUVty5eZ/x995gnA2vk05NXyY
	WwFNGc/JhD1PqDN9e4p7VoHlDkf+oLmzg51cEQxV85o5NIco5PeC04yAY3VLWvQTOh9CVZ7lKQKlL
	zMvBumz9Zs9KznuexfspKdMTVrJw6oN6J2BKZW49h1lHJ5mUo+5DXjrvevhiL2BY/JrS74Xedkb4q
	3ouNwvFQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1leeMf-004NGF-5A; Thu, 06 May 2021 13:48:29 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1leeMd-004NFz-Lz
 for linux-nvme@desiato.infradead.org; Thu, 06 May 2021 13:48:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:In-Reply-To:References;
 bh=JMtf+1UpVbLCgMA8fvUvT+85ao3RfNQL4xbrbWe5/F8=; b=1SmU5r4QGSrgRaxPx0ohQN19gs
 HtJX4V/eLhcAQCM+sfaQpTBvmA+okHy13OEHHM8XGF5gyTvediMIceIetAGpnXS2TDwyCsvOwarzV
 59ilybUy2drdnFQ1KeZLjMDKHcDvTFkQQ+h8jCAZzaDXCaDJhG7XjMAROwGte/Dh8orM7HeBhragU
 U6GprS1jviBRBmrL3IGYGWZGhamBaO4pfhX/oBp20Ozb/Z3RqmU8jY0sP7+brQydkPazNyStO14Sy
 2sz2otujhlchxEfqiLnfV53yvWG76SsD/ZKFaU3pWEcYIjoMciZjibUrx75LsnBqGUuKOdW6K3R1A
 ek5PtrQw==;
Received: from [2001:4bb8:180:9479:d707:6043:6d00:4efb] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1leeMb-0064Oi-Fg; Thu, 06 May 2021 13:48:25 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	Martin Wilck <mwilck@suse.com>
Subject: [PATCH] nvme-multipath: fix double initialization of ANA state
Date: Thu,  6 May 2021 15:48:23 +0200
Message-Id: <20210506134823.2566853-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

nvme_init_identify and thus nvme_mpath_init can be called multiple
times and thus must not overwrite potentially initialized or in-use
fields.  Split out a helper for the basic initialization when the
controller is initialized and make sure the init_identify path does
not blindly change in-use data structures.

Fixes: 0d0b660f214d ("nvme: add ANA support")
Reported-by: Martin Wilck <mwilck@suse.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      |  3 +-
 drivers/nvme/host/multipath.c | 53 ++++++++++++++++++-----------------
 drivers/nvme/host/nvme.h      |  8 ++++--
 3 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e6612971f4eb..d896b3d170ec 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2911,7 +2911,7 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		ctrl->hmmaxd = le16_to_cpu(id->hmmaxd);
 	}
 
-	ret = nvme_mpath_init(ctrl, id);
+	ret = nvme_mpath_init_identify(ctrl, id);
 	if (ret < 0)
 		goto out_free;
 
@@ -4373,6 +4373,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
 
 	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
+	nvme_mpath_init_ctrl(ctrl);
 
 	return 0;
 out_free_name:
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0d0de3433f37..b831e80bbb76 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -778,8 +778,17 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	put_disk(head->disk);
 }
 
-int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
+void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl)
 {
+	mutex_init(&ctrl->ana_lock);
+	timer_setup(&ctrl->anatt_timer, nvme_anatt_timeout, 0);
+	INIT_WORK(&ctrl->ana_work, nvme_ana_work);
+}
+
+int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
+{
+	size_t max_transfer_size = ctrl->max_hw_sectors << SECTOR_SHIFT;
+	size_t ana_log_size;
 	int error;
 
 	/* check if multipath is enabled and we have the capability */
@@ -792,37 +801,31 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	ctrl->nanagrpid = le32_to_cpu(id->nanagrpid);
 	ctrl->anagrpmax = le32_to_cpu(id->anagrpmax);
 
-	mutex_init(&ctrl->ana_lock);
-	timer_setup(&ctrl->anatt_timer, nvme_anatt_timeout, 0);
-	ctrl->ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
-		ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc);
-	ctrl->ana_log_size += ctrl->max_namespaces * sizeof(__le32);
-
-	if (ctrl->ana_log_size > ctrl->max_hw_sectors << SECTOR_SHIFT) {
+	ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
+		ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc) +
+		ctrl->max_namespaces * sizeof(__le32);
+	if (ana_log_size > max_transfer_size) {
 		dev_err(ctrl->device,
-			"ANA log page size (%zd) larger than MDTS (%d).\n",
-			ctrl->ana_log_size,
-			ctrl->max_hw_sectors << SECTOR_SHIFT);
+			"ANA log page size (%zd) larger than MDTS (%zd).\n",
+			ana_log_size, max_transfer_size);
 		dev_err(ctrl->device, "disabling ANA support.\n");
-		return 0;
+		goto out_uninit;
 	}
-
-	INIT_WORK(&ctrl->ana_work, nvme_ana_work);
-	kfree(ctrl->ana_log_buf);
-	ctrl->ana_log_buf = kmalloc(ctrl->ana_log_size, GFP_KERNEL);
-	if (!ctrl->ana_log_buf) {
-		error = -ENOMEM;
-		goto out;
+	if (ana_log_size > ctrl->ana_log_size) {
+		nvme_mpath_stop(ctrl);
+		kfree(ctrl->ana_log_buf);
+		ctrl->ana_log_buf = kmalloc(ctrl->ana_log_size, GFP_KERNEL);
+		if (!ctrl->ana_log_buf)
+			return -ENOMEM;
 	}
-
+	ctrl->ana_log_size = ana_log_size;
 	error = nvme_read_ana_log(ctrl);
 	if (error)
-		goto out_free_ana_log_buf;
+		goto out_uninit;
 	return 0;
-out_free_ana_log_buf:
-	kfree(ctrl->ana_log_buf);
-	ctrl->ana_log_buf = NULL;
-out:
+
+out_uninit:
+	nvme_mpath_uninit(ctrl);
 	return error;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 05f31a2c64bb..0015860ec12b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -712,7 +712,8 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
-int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
+int nvme_mpath_init_identify(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
+void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
@@ -780,7 +781,10 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 static inline void nvme_trace_bio_complete(struct request *req)
 {
 }
-static inline int nvme_mpath_init(struct nvme_ctrl *ctrl,
+static inline void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl)
+{
+}
+static inline int nvme_mpath_init_identify(struct nvme_ctrl *ctrl,
 		struct nvme_id_ctrl *id)
 {
 	if (ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA)
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
