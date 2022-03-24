Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B83C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Mar 2022 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qgR5Jg4kOPHgxL2gNh2w5QUDBOUp3UIrYvWBdWCongU=; b=nLpA86X0Z3S/oHdZfpqqLvHsxQ
	XGlx7rnCNrPpIok+8F/S0jp5EDXdxgfum2UkcOzCr9+Wf45/M0exvVsxlG5HJw7htF8ZMFw9CgLMs
	7FDoaLPMaIH7OSi7X2zAX5AFp0N/Rsz2kZcpByzMGPwgHZYIJjBj8QAT2+weqAMPCbCZzojkGVf8A
	xOuj3DLe70UCJ/FEPdsLlVCVGeCn6hzfBX8zckqkvoUNQqus/FL2HjNkJOvUKVZ98bpeJhxTUe0+v
	7JnTYQwhmSvfOsT86XTMxv//NBCnXevA6joknj6aCdUPWpEdaVdPPlFZPw0bO0tMOFu2o5gWRsOyE
	lidpFitA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nXPcR-00H3VA-Bd; Thu, 24 Mar 2022 15:43:23 +0000
Received: from [2001:4bb8:19a:b822:2a44:1428:2337:3096] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nXPcL-00H3Uh-N1; Thu, 24 Mar 2022 15:43:18 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kbusch@kernel.org
Cc: sungup.moon@samsung.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: allow duplicate NSIDs for the private namespaces
Date: Thu, 24 Mar 2022 16:43:14 +0100
Message-Id: <20220324154314.1571239-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

From: Sungup Moon <sungup.moon@samsung.com>

A NVMe subsystem with multiple controller can have private namespaces
that use the same NSID under some conditions:

 "If Namespace Management, ANA Reporting, or NVM Sets are supported, the
  NSIDs shall be unique within the NVM subsystem. If the Namespace
  Management, ANA Reporting, and NVM Sets are not supported, then NSIDs:
   a) for shared namespace shall be unique; and
   b) for private namespace are not required to be unique."

Reference: Section 6.1.6 NSID and Namespace Usage; NVM Express 1.4c spec.

Make sure this specific setup is supported in Linux.

Fixes: 9ad1927a3bc2 ("nvme: always search for namespace head")
Signed-off-by: Sungup Moon <sungup.moon@samsung.com>
[hch: refactored and fixed the controller vs subsystem based naming
      conflict]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      | 15 ++++++++++-----
 drivers/nvme/host/multipath.c |  7 ++++---
 drivers/nvme/host/nvme.h      | 19 +++++++++++++++++++
 include/linux/nvme.h          |  1 +
 4 files changed, 34 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ccc5877d514b0..fb94dc8dc6313 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3627,15 +3627,20 @@ static const struct attribute_group *nvme_dev_attr_groups[] = {
 	NULL,
 };
 
-static struct nvme_ns_head *nvme_find_ns_head(struct nvme_subsystem *subsys,
+static struct nvme_ns_head *nvme_find_ns_head(struct nvme_ctrl *ctrl,
 		unsigned nsid)
 {
 	struct nvme_ns_head *h;
 
-	lockdep_assert_held(&subsys->lock);
+	lockdep_assert_held(&ctrl->subsys->lock);
 
-	list_for_each_entry(h, &subsys->nsheads, entry) {
-		if (h->ns_id != nsid)
+	list_for_each_entry(h, &ctrl->subsys->nsheads, entry) {
+		/*
+		 * Private namespaces can share NSIDs under some conditions.
+		 * In that case we can't use the same ns_head for namespaces
+		 * with the same NSID.
+		 */
+		if (h->ns_id != nsid || !nvme_is_uniqueue_nsid(ctrl, h))
 			continue;
 		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
 			return h;
@@ -3829,7 +3834,7 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 	}
 
 	mutex_lock(&ctrl->subsys->lock);
-	head = nvme_find_ns_head(ctrl->subsys, nsid);
+	head = nvme_find_ns_head(ctrl, nsid);
 	if (!head) {
 		ret = nvme_subsys_check_duplicate_ids(ctrl->subsys, ids);
 		if (ret) {
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c97d7f843977c..485e5904f2474 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -482,10 +482,11 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 
 	/*
 	 * Add a multipath node if the subsystems supports multiple controllers.
-	 * We also do this for private namespaces as the namespace sharing data could
-	 * change after a rescan.
+	 * We also do this for private namespaces as the namespace sharing flag
+	 * could change after a rescan.
 	 */
-	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) || !multipath)
+	if (!(ctrl->subsys->cmic & NVME_CTRL_CMIC_MULTI_CTRL) ||
+	    !nvme_is_uniqueue_nsid(ctrl, head) || !multipath)
 		return 0;
 
 	head->disk = blk_alloc_disk(ctrl->numa_node);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1ea908d43e174..82504ff2546d9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -722,6 +722,25 @@ static inline bool nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		return queue_live;
 	return __nvme_check_ready(ctrl, rq, queue_live);
 }
+
+/*
+ * NSID shall be unique for all shared namespaces, or if at least one of the
+ * following conditions is met:
+ *   1. Namespace Management is supported by the controller
+ *   2. ANA is supported by the controller
+ *   3. NVM Set are supported by the controller
+ *
+ * In other case, private namespace are not required to report a unique NSID.
+ */
+static inline bool nvme_is_uniqueue_nsid(struct nvme_ctrl *ctrl,
+		struct nvme_ns_head *head)
+{
+	return head->shared ||
+		(ctrl->oacs & NVME_CTRL_OACS_NS_MNGT_SUPP) ||
+		(ctrl->subsys->cmic & NVME_CTRL_CMIC_ANA) ||
+		(ctrl->ctratt & NVME_CTRL_CTRATT_NVM_SETS);
+}
+
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9dbc3ef4daf7c..2dcee34d467d6 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -345,6 +345,7 @@ enum {
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
+	NVME_CTRL_OACS_NS_MNGT_SUPP		= 1 << 3,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
 	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
-- 
2.30.2


