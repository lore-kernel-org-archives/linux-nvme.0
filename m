Return-Path: <SRS0=7z9d=C3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E70FC43463
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 02:12:36 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9BE7235F9
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2020 02:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r9r1rxso";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhyCJxHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BE7235F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FfGHld3lJodkJIHI20WOJXpyDL2qqvD2+Nh61Qlngzo=; b=r9r1rxsoi0HjltVqPsfjDUAQF
	5DKIjb4c3ECeY3quIU7zITWwGCUIndfj2GUpgyzAHN+W7P35CyYTZIrfo1XnHt2NEsqjsIlCFoAUc
	SSp4ncho2KIou6diooT0xsZTGdOyws9f70d1O2E6Exim2Jk27HJLGxaxJ08UYgMynLwrs6mCgvn6b
	F1rDX9Md3B/HU3HysTq6xUTxTv7cH0zHTMx/+NUqiP/6J+Z7PuchvR4DzYqCE9mEmu3GGYmnVRWdq
	xgiI2/womH/jSKP4ghV93n7EBp/dCySAa2f6Wphqfd0kv+8+iakXuCrCcH4WtJQe6SQpBleOGzXoX
	ACRyAMupQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kJ5ss-0007Nx-4C; Fri, 18 Sep 2020 02:12:22 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kJ5m6-0003et-LF
 for linux-nvme@lists.infradead.org; Fri, 18 Sep 2020 02:05:23 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id D1898238E3;
 Fri, 18 Sep 2020 02:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1600394721;
 bh=qS/Xbq0Jpq56JcCfjAFHKQ6K9SV18Q3CkH5HI7LzysE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=rhyCJxHWMCbVx3Db4o3e5wCVJ5bi8S/2OkhuoboyLcHegzpLsLGYHMjFQGzdJ3i3H
 J438xaOfGZPcdCdJqQRU1Njub3Kn9r10weOMq93w6zCJdaMaY01sVwNVZcxVHFvmhh
 UdrHQnOQbswCUGtRPKVgayWuYIHJDS6I9FSKaAZk=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 205/330] nvme-multipath: do not reset on unknown
 status
Date: Thu, 17 Sep 2020 21:59:05 -0400
Message-Id: <20200918020110.2063155-205-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200918020110.2063155-1-sashal@kernel.org>
References: <20200918020110.2063155-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200917_220522_898570_759A544C 
X-CRM114-Status: GOOD (  15.82  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Sasha Levin <sashal@kernel.org>, linux-nvme@lists.infradead.org,
 Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, John Meneghini <johnm@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: John Meneghini <johnm@netapp.com>

[ Upstream commit 764e9332098c0e60251386a507fe46ac91276120 ]

The nvme multipath error handling defaults to controller reset if the
error is unknown. There are, however, no existing nvme status codes that
indicate a reset should be used, and resetting causes unnecessary
disruption to the rest of IO.

Change nvme's error handling to first check if failover should happen.
If not, let the normal error handling take over rather than reset the
controller.

Based-on-a-patch-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: John Meneghini <johnm@netapp.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c      |  5 +----
 drivers/nvme/host/multipath.c | 21 +++++++++------------
 drivers/nvme/host/nvme.h      |  5 +++--
 3 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3cb017fa3a790..05688fa579e81 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -288,11 +288,8 @@ void nvme_complete_rq(struct request *req)
 		nvme_req(req)->ctrl->comp_seen = true;
 
 	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-		if ((req->cmd_flags & REQ_NVME_MPATH) &&
-		    blk_path_error(status)) {
-			nvme_failover_req(req);
+		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
 			return;
-		}
 
 		if (!blk_queue_dying(req->q)) {
 			nvme_retry_req(req);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0a458f7880887..3968f89f7855a 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -65,17 +65,12 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	}
 }
 
-void nvme_failover_req(struct request *req)
+bool nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 	u16 status = nvme_req(req)->status;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ns->head->requeue_lock, flags);
-	blk_steal_bios(&ns->head->requeue_list, req);
-	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
-	blk_mq_end_request(req, 0);
-
 	switch (status & 0x7ff) {
 	case NVME_SC_ANA_TRANSITION:
 	case NVME_SC_ANA_INACCESSIBLE:
@@ -104,15 +99,17 @@ void nvme_failover_req(struct request *req)
 		nvme_mpath_clear_current_path(ns);
 		break;
 	default:
-		/*
-		 * Reset the controller for any non-ANA error as we don't know
-		 * what caused the error.
-		 */
-		nvme_reset_ctrl(ns->ctrl);
-		break;
+		/* This was a non-ANA error so follow the normal error path. */
+		return false;
 	}
 
+	spin_lock_irqsave(&ns->head->requeue_lock, flags);
+	blk_steal_bios(&ns->head->requeue_list, req);
+	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
+	blk_mq_end_request(req, 0);
+
 	kblockd_schedule_work(&ns->head->requeue_work);
+	return true;
 }
 
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 056953bd8bd81..80bfffa943ccd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -530,7 +530,7 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
-void nvme_failover_req(struct request *req);
+bool nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
@@ -579,8 +579,9 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
 }
 
-static inline void nvme_failover_req(struct request *req)
+static inline bool nvme_failover_req(struct request *req)
 {
+	return false;
 }
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
