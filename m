Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D9E0C433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 15 Mar 2022 07:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6HjWuhk2Agx1dJoTvfVJmI7D/C+wcIKVohzhp6qOVN0=; b=3O09mMEWjSXry9AfEJoOjIh7TO
	sFfLoLkk28+94JNnbhDt/icQlfQnZjwnPCRnEH2FGi3okcBbwP/Pl4KDR1nwyIAqmCpc1X3jUK8a2
	A8PqNKoFJkpuVx7uDlv6SuXnKhEnGKCXgKBbcQzYN/9+tfwt1q9opc23wAWSR5QymDKhTwmp9BXye
	uekuXSNI5/CdUscjizVitkVgcOvcu4WQmU1xrNt5CdfTPtbx+chBVhbypWvwSBfazkdRrcm6W/PGw
	fohxXUOI3eyXrU5mGtBd2dCOV5waLqDSnKd54YV06amL0xLXccVIHLWcsyF12/Uiw2MO8/5UPTh5l
	U0WSfF0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nU1ME-00845I-2u; Tue, 15 Mar 2022 07:12:38 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nU1MA-00844z-Cv
 for linux-nvme@lists.infradead.org; Tue, 15 Mar 2022 07:12:36 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BA36468AFE; Tue, 15 Mar 2022 08:12:30 +0100 (CET)
Date: Tue, 15 Mar 2022 08:12:30 +0100
From: "hch@lst.de" <hch@lst.de>
To: Sungup Moon <sungup.moon@samsung.com>
Cc: "kbusch@kernel.org" <kbusch@kernel.org>, "axboe@fb.com" <axboe@fb.com>,
 "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] driver/nvme/host: Support duplicated nsid for the
 private ns
Message-ID: <20220315071230.GA2069@lst.de>
References: <CGME20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
 <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314110545epcms2p4a227eac7c4652445050e70ee2350635d@epcms2p4>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220315_001234_768717_3A03B676 
X-CRM114-Status: GOOD (  22.39  )
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

I looked at this a bit more and found two issues:

 - nvme_init_ns_head will now leak the ns_head for the private namespaces
   with potentially duplicate IDs case.
 - nvme_mpath_set_disk_name still needs to use the subsystem-wide IDA
   for the nvme instance name as the subsystem and controller ones
   could otherwise clash.

Let me know what you think of this version:

---
From 1b217962cc10fa59eae98fc112adc64bddc462b3 Mon Sep 17 00:00:00 2001
From: Sungup Moon <sungup.moon@samsung.com>
Date: Mon, 14 Mar 2022 20:05:45 +0900
Subject: nvme: allow duplicated NSIDs for the private namespaces

A NVMe subsystem with multiple controller can have private namespaces
that use the same NSID under some conditions:

 "If Namespace Management, ANA Reporting, or NVM Sets are supported, the
  NSIDs shall be unique within the NVM subsystem. If the Namespace
  Management, ANA Reporting, and NVM Sets are not supported, then NSIDs:
   a) for shared namespace shall be unique; and
   b) for private namespace are not required to be unique."

Reference: Section 6.1.6 NSID and Namespace Usage; NVM Express 1.4c spec.

Make sure this specific setup is supported in Linux.

Signed-off-by: Sungup Moon <sungup.moon@samsung.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      |  7 ++++++-
 drivers/nvme/host/multipath.c |  7 ++++---
 drivers/nvme/host/nvme.h      | 19 +++++++++++++++++++
 include/linux/nvme.h          |  1 +
 4 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f8084ded69e50..c7127d439b3de 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3657,7 +3657,12 @@ static struct nvme_ns_head *nvme_find_ns_head(struct nvme_subsystem *subsys,
 	lockdep_assert_held(&subsys->lock);
 
 	list_for_each_entry(h, &subsys->nsheads, entry) {
-		if (h->ns_id != nsid)
+		/*
+		 * Private namespaces can share NSIDs under some conditions.
+		 * In that case we can't use the same ns_head for namespaces
+		 * with the same NSID.
+		 */
+		if (h->ns_id != nsid || !nvme_is_uniqueue_nsid(ctrl, head))
 			continue;
 		if (!list_empty(&h->list) && nvme_tryget_ns_head(h))
 			return h;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d13b81cd6225c..6b6df1016cb91 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -504,10 +504,11 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 
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
index 587d92df118b7..9add586434929 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -718,6 +718,25 @@ static inline bool nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
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


