Return-Path: <SRS0=S8v+=4A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A788C2BA83
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 13:42:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70C2C20659
	for <linux-nvme@archiver.kernel.org>; Wed, 12 Feb 2020 13:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PBwKM0c+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70C2C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=GQD713EzitbR1GzMZpdLhvRS8StQE/Qo269zkO+g/mk=; b=PBw
	KM0c+IihWOjZI6cTw+NxKiOy9DindKxmd1CegdF+cEZTsPyUfMrxSq91hoW97beHzju9+0LDWxzyW
	LmmeScyemNLMc5GUYk0qB7kUMQ4a4W5Bo14ZWJwEmrwlWIfAxYRUKoGnoi7WD10PsaEK4b+MT7svR
	ydlB7WwCut0XUBEmm67OVYAoL1YKM5eh7r5lTtTLoNJviTCdXANtaRkSvQ9VbX2fDDaOwcFSDe4aO
	urx9xA6XSTetJrTneEJV7KmhXan694BsquUM8hNpGuiIljN4pDEsv1ZeiIQqNGzKxa5OaYpAt55Mk
	xkqK0AkvgTgLhBqWYHiV78FEYHiOPMA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j1sHE-00071F-AY; Wed, 12 Feb 2020 13:42:04 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j1sH5-0006rH-Az
 for linux-nvme@lists.infradead.org; Wed, 12 Feb 2020 13:41:57 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id DFC86AE54;
 Wed, 12 Feb 2020 13:41:53 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme-multipath: do not reset controller on unknown status
Date: Wed, 12 Feb 2020 14:41:40 +0100
Message-Id: <20200212134140.105817-1-hare@suse.de>
X-Mailer: git-send-email 2.16.4
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200212_054155_680652_813EE1A2 
X-CRM114-Status: GOOD (  16.59  )
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
Cc: Keith Busch <keith.busch@intel.com>,
 John Managhini <john.meneghini@netapp.com>, Christoph Hellwig <hch@lst.de>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We're seeing occasional controller resets during straight I/O,
but only when multipath is active.
The problem here is the nvme-multipath will reset the controller
on every unknown status, which really is an odd behaviour, seeing
that the host already received a perfectly good status; it's just
that it's not smart enough to understand it.
And resetting wouldn't help at all; the error status will continue
to be received.
So we should rather pass up any unknown error to the generic
routines and let them deal with this situation.

Signed-off-by: Hannes Reinecke <hare@suse.de>
Cc: John Managhini <john.meneghini@netapp.com>
---
 drivers/nvme/host/core.c      |  4 ++--
 drivers/nvme/host/multipath.c | 18 ++++++++++--------
 drivers/nvme/host/nvme.h      |  2 +-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5dc32b72e7fa..edb081781ae7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -293,8 +293,8 @@ void nvme_complete_rq(struct request *req)
 	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
 		if ((req->cmd_flags & REQ_NVME_MPATH) &&
 		    blk_path_error(status)) {
-			nvme_failover_req(req);
-			return;
+			if (nvme_failover_req(req))
+				return;
 		}
 
 		if (!blk_queue_dying(req->q)) {
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 797c18337d96..71e8acae78eb 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -64,16 +64,16 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	}
 }
 
-void nvme_failover_req(struct request *req)
+bool nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 	u16 status = nvme_req(req)->status;
 	unsigned long flags;
+	bool handled = false;
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
-	blk_mq_end_request(req, 0);
 
 	switch (status & 0x7ff) {
 	case NVME_SC_ANA_TRANSITION:
@@ -88,11 +88,13 @@ void nvme_failover_req(struct request *req)
 		 * mark the the path as pending and kick of a re-read of the ANA
 		 * log page ASAP.
 		 */
+		blk_mq_end_request(req, 0);
 		nvme_mpath_clear_current_path(ns);
 		if (ns->ctrl->ana_log_buf) {
 			set_bit(NVME_NS_ANA_PENDING, &ns->flags);
 			queue_work(nvme_wq, &ns->ctrl->ana_work);
 		}
+		handled = true;
 		break;
 	case NVME_SC_HOST_PATH_ERROR:
 	case NVME_SC_HOST_ABORTED_CMD:
@@ -100,18 +102,18 @@ void nvme_failover_req(struct request *req)
 		 * Temporary transport disruption in talking to the controller.
 		 * Try to send on a new path.
 		 */
+		blk_mq_end_request(req, 0);
 		nvme_mpath_clear_current_path(ns);
+		handled = true;
 		break;
 	default:
-		/*
-		 * Reset the controller for any non-ANA error as we don't know
-		 * what caused the error.
-		 */
-		nvme_reset_ctrl(ns->ctrl);
+		/* Delegate to common error handling */
 		break;
 	}
 
-	kblockd_schedule_work(&ns->head->requeue_work);
+	if (handled)
+		kblockd_schedule_work(&ns->head->requeue_work);
+	return handled;
 }
 
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1024fec7914c..7e28084f71af 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -550,7 +550,7 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
-void nvme_failover_req(struct request *req);
+bool nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
