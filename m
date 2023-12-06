Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713D2C10F07
	for <linux-nvme@archiver.kernel.org>; Wed,  6 Dec 2023 08:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=exKo8DIzZ+miKKVL+bdjhfUUSTp5ERmlwY3HNY9Kw6M=; b=GxQSgqLVpEvoC1onM8nBeWqaMM
	U4xvIa5ZVE466NkD2jLcY7NwRlw3SKy6kvd1DIa8buJvZei86wdTcqVZHaTttFY/PY4XweMpvwsGx
	CSvditpZEstWXt6Cr1wJXb/zPxoDW4BSwVwVR/AZRn0BNEpHuI2dm5Edp9BBcIhQuto5UNpiwGRnI
	eT20dpQmjYFCU9IoVfkOOM3RbR2JOLK5QtYbkOdJmlDhgbiSc3gDwDWbT37WtpfJSVIB5gCGrgUG6
	I85Pc4Qas5Y3W6j1vxcHVX/QGtQ2ArDEKacuMIDBeWWuidPGcCS0WJI/UZ+JeMDXV7Y2e3j6bPuWl
	oIk1QWtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rAn1e-009MoI-19;
	Wed, 06 Dec 2023 08:12:58 +0000
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rAn1a-009MlX-0x
	for linux-nvme@lists.infradead.org;
	Wed, 06 Dec 2023 08:12:56 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4ADB21FCFA;
	Wed,  6 Dec 2023 08:12:50 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 378F1133DD;
	Wed,  6 Dec 2023 08:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id EekhDAItcGUVHgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Wed, 06 Dec 2023 08:12:50 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v3 2/4] nvme: initialize head before namespace
Date: Wed,  6 Dec 2023 09:12:42 +0100
Message-ID: <20231206081244.32733-3-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231206081244.32733-1-dwagner@suse.de>
References: <20231206081244.32733-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: +++++++++++
Authentication-Results: smtp-out2.suse.de;
	dkim=none;
	dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.de (policy=none);
	spf=softfail (smtp-out2.suse.de: 2a07:de40:b281:104:10:150:64:98 is neither permitted nor denied by domain of dwagner@suse.de) smtp.mailfrom=dwagner@suse.de
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [11.76 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_SPAM_SHORT(2.97)[0.989];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 R_SPF_SOFTFAIL(4.60)[~all:c];
	 RCVD_COUNT_THREE(0.00)[3];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 R_DKIM_NA(2.20)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 DMARC_POLICY_SOFTFAIL(0.10)[suse.de : No valid SPF, No valid DKIM,none]
X-Rspamd-Queue-Id: 4ADB21FCFA
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231206_001254_499672_3CA4984F 
X-CRM114-Status: GOOD (  16.10  )
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

In preparation to use struct nvme_ns_head pointers instead of a struct
nvme_ns pointers, initialize the head pointer before we create the disk.
This allows us to attach the head as private data to the disk object.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c | 46 ++++++++++++++++++++++------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 900c045fcae0..1fabe1b81de0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3474,10 +3474,11 @@ static int nvme_global_check_duplicate_ids(struct nvme_subsystem *this,
 	return ret;
 }
 
-static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
+static int nvme_init_ns_head(struct nvme_ctrl *ctrl,
+			     struct nvme_ns_info *info,
+			     struct nvme_ns_head **head)
 {
-	struct nvme_ctrl *ctrl = ns->ctrl;
-	struct nvme_ns_head *head = NULL;
+	struct nvme_ns_head *h = NULL;
 	int ret;
 
 	ret = nvme_global_check_duplicate_ids(ctrl->subsys, &info->ids);
@@ -3499,8 +3500,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		 * up at any time.
 		 */
 		nvme_print_device_info(ctrl);
-		if ((ns->ctrl->ops->flags & NVME_F_FABRICS) || /* !PCIe */
-		    ((ns->ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) &&
+		if ((ctrl->ops->flags & NVME_F_FABRICS) || /* !PCIe */
+		    ((ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) &&
 		     info->is_shared)) {
 			dev_err(ctrl->device,
 				"ignoring nsid %d because of duplicate IDs\n",
@@ -3519,8 +3520,8 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 	}
 
 	mutex_lock(&ctrl->subsys->lock);
-	head = nvme_find_ns_head(ctrl, info->nsid);
-	if (!head) {
+	h = nvme_find_ns_head(ctrl, info->nsid);
+	if (!h) {
 		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, &info->ids);
 		if (ret) {
 			dev_err(ctrl->device,
@@ -3528,20 +3529,20 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 				info->nsid);
 			goto out_unlock;
 		}
-		head = nvme_alloc_ns_head(ctrl, info);
-		if (IS_ERR(head)) {
-			ret = PTR_ERR(head);
+		h = nvme_alloc_ns_head(ctrl, info);
+		if (IS_ERR(h)) {
+			ret = PTR_ERR(h);
 			goto out_unlock;
 		}
 	} else {
 		ret = -EINVAL;
-		if (!info->is_shared || !head->shared) {
+		if (!info->is_shared || !h->shared) {
 			dev_err(ctrl->device,
 				"Duplicate unshared namespace %d\n",
 				info->nsid);
 			goto out_put_ns_head;
 		}
-		if (!nvme_ns_ids_equal(&head->ids, &info->ids)) {
+		if (!nvme_ns_ids_equal(&h->ids, &info->ids)) {
 			dev_err(ctrl->device,
 				"IDs don't match for shared namespace %d\n",
 					info->nsid);
@@ -3557,13 +3558,12 @@ static int nvme_init_ns_head(struct nvme_ns *ns, struct nvme_ns_info *info)
 		}
 	}
 
-	list_add_tail_rcu(&ns->siblings, &head->list);
-	ns->head = head;
+	*head = h;
 	mutex_unlock(&ctrl->subsys->lock);
 	return 0;
 
 out_put_ns_head:
-	nvme_put_ns_head(head);
+	nvme_put_ns_head(h);
 out_unlock:
 	mutex_unlock(&ctrl->subsys->lock);
 	return ret;
@@ -3615,15 +3615,22 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (!ns)
 		return;
 
+	if (nvme_init_ns_head(ctrl, info, &ns->head))
+		goto out_free_ns;
+
 	disk = blk_mq_alloc_disk(ctrl->tagset, ns);
 	if (IS_ERR(disk))
-		goto out_free_ns;
+		goto out_free_head;
 	disk->fops = &nvme_bdev_ops;
 	disk->private_data = ns;
 
 	ns->disk = disk;
 	ns->queue = disk->queue;
 
+	mutex_lock(&ctrl->subsys->lock);
+	list_add_tail_rcu(&ns->siblings, &ns->head->list);
+	mutex_unlock(&ctrl->subsys->lock);
+
 	if (ctrl->opts && ctrl->opts->data_digest)
 		blk_queue_flag_set(QUEUE_FLAG_STABLE_WRITES, ns->queue);
 
@@ -3635,9 +3642,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	ns->ctrl = ctrl;
 	kref_init(&ns->kref);
 
-	if (nvme_init_ns_head(ns, info))
-		goto out_cleanup_disk;
-
 	/*
 	 * If multipathing is enabled, the device name for all disks and not
 	 * just those that represent shared namespaces needs to be based on the
@@ -3691,9 +3695,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (list_empty(&ns->head->list))
 		list_del_init(&ns->head->entry);
 	mutex_unlock(&ctrl->subsys->lock);
-	nvme_put_ns_head(ns->head);
- out_cleanup_disk:
 	put_disk(disk);
+ out_free_head:
+	nvme_put_ns_head(ns->head);
  out_free_ns:
 	kfree(ns);
 }
-- 
2.43.0


