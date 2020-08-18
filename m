Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FE5C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 07:12:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3184320738
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 07:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="S2jS/Onp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sbJU7IfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3184320738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7NF3VfQNWSOEPLAJaDdg2Mh0Dn/oy7QNHX8bzICvBic=; b=S2jS/OnpSbMKcx5Z0pzYpmc1J
	ydsA1RG54Wk7TPFzWj+f7J7SN4FLGazwx19jFo0+Ya0/9RFj6OulaRA8PdufNv3ESi/mj3hsVTPmg
	m+pCjpbUaY7xzX48Cbobd0ji0G9wH801w/uzd8L3EcG6Vgui5DC9KwW4Rj3TB6rtTexXlUMv0tVf4
	aXJnb3qgIcs0m1SrFUr9RbTOFP9RRUGNw4goQXFq8wOp1B2NRrZdlraDILhZeEy6n+11xKKdx1HRZ
	2HMrBm7gE0CJATt2ZAErKdcZkd7ZSdwdAeDkM2RsweIhwyuaxRUUDExzolZO1++e29cxjrMOxE77E
	tr1pFuP2A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7vmo-0001A8-Hx; Tue, 18 Aug 2020 07:11:58 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vmY-00013m-VO
 for linux-nvme@merlin.infradead.org; Tue, 18 Aug 2020 07:11:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=u3Jec85fKABzbO2OMiWhRdfFS8ZpyEjkIkFEcquYsVY=; b=sbJU7IfVNDCXr67dMJiTPYE4iF
 YTcET9WZDKe4+0iPlJhVlRhUaY9e+Shg1VFtPbtx0lIDdHFpfF8CaX4Co+IkpmjqH80pthl7qcmAf
 Jpm99LYLYkEofsEXrPADRuTt3IsqA0etaO2bqiymaildHDNsD2uBJaO4DFWjDJbm8gDa2K0buVujw
 6SZCKa6aQbOhL9MgRSZwtgZPyb+zADBJ/CtwVS53AqdbOlq8i2VA3hVmTsvomoWU2tevBQHE2PKXq
 UQFNhGOujq6jj1VNWd09rfURBywCLNiPjAN/zrSCSOdKGOebOxJDT8wgjPbtGakHuN/sm4M9JqbsI
 +oX0YR9Q==;
Received: from [2001:4bb8:198:f3b2:a8c9:886a:f150:c8c6] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7vmW-0005YL-4l; Tue, 18 Aug 2020 07:11:41 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvme: refactor command completion
Date: Tue, 18 Aug 2020 09:11:30 +0200
Message-Id: <20200818071132.1136033-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200818071132.1136033-1-hch@lst.de>
References: <20200818071132.1136033-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, Mike Snitzer <snitzer@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Lift all the code to decide the dispostition of a completed command
from nvme_complete_rq and nvme_failover_req into a new helper, which
returns an emum of the potential actions.  nvme_complete_rq then
just switches on those and calls the proper helper for the action.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Mike Snitzer <snitzer@redhat.com>
---
 drivers/nvme/host/core.c      | 75 ++++++++++++++++++++++-------------
 drivers/nvme/host/multipath.c | 47 ++++++----------------
 drivers/nvme/host/nvme.h      | 31 +++++++++++++--
 3 files changed, 89 insertions(+), 64 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88cff309d8e4f0..36bb0fe9c7f6f8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -241,17 +241,6 @@ static blk_status_t nvme_error_status(u16 status)
 	}
 }
 
-static inline bool nvme_req_needs_retry(struct request *req)
-{
-	if (blk_noretry_request(req))
-		return false;
-	if (nvme_req(req)->status & NVME_SC_DNR)
-		return false;
-	if (nvme_req(req)->retries >= nvme_max_retries)
-		return false;
-	return true;
-}
-
 static void nvme_retry_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
@@ -268,34 +257,66 @@ static void nvme_retry_req(struct request *req)
 	blk_mq_delay_kick_requeue_list(req->q, delay);
 }
 
-void nvme_complete_rq(struct request *req)
+enum nvme_disposition {
+	COMPLETE,
+	RETRY,
+	FAILOVER,
+};
+
+static inline enum nvme_disposition nvme_decide_disposition(struct request *req)
 {
-	blk_status_t status = nvme_error_status(nvme_req(req)->status);
+	if (likely(nvme_req(req)->status == 0))
+		return COMPLETE;
 
-	trace_nvme_complete_rq(req);
+	if (blk_noretry_request(req) ||
+	    (nvme_req(req)->status & NVME_SC_DNR) ||
+	    nvme_req(req)->retries >= nvme_max_retries)
+		return COMPLETE;
 
-	nvme_cleanup_cmd(req);
+	if (req->cmd_flags & REQ_NVME_MPATH) {
+		if (nvme_is_path_error(nvme_req(req)->status))
+			return FAILOVER;
+	}
 
-	if (nvme_req(req)->ctrl->kas)
-		nvme_req(req)->ctrl->comp_seen = true;
+	if (blk_queue_dying(req->q))
+		return COMPLETE;
 
-	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
-			return;
+	return RETRY;
+}
 
-		if (!blk_queue_dying(req->q)) {
-			nvme_retry_req(req);
-			return;
-		}
-	} else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-		   req_op(req) == REQ_OP_ZONE_APPEND) {
+static inline void nvme_end_req(struct request *req)
+{
+	blk_status_t status = nvme_error_status(nvme_req(req)->status);
+
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    req_op(req) == REQ_OP_ZONE_APPEND)
 		req->__sector = nvme_lba_to_sect(req->q->queuedata,
 			le64_to_cpu(nvme_req(req)->result.u64));
-	}
 
 	nvme_trace_bio_complete(req, status);
 	blk_mq_end_request(req, status);
 }
+
+void nvme_complete_rq(struct request *req)
+{
+	trace_nvme_complete_rq(req);
+	nvme_cleanup_cmd(req);
+
+	if (nvme_req(req)->ctrl->kas)
+		nvme_req(req)->ctrl->comp_seen = true;
+
+	switch (nvme_decide_disposition(req)) {
+	case COMPLETE:
+		nvme_end_req(req);
+		return;
+	case RETRY:
+		nvme_retry_req(req);
+		return;
+	case FAILOVER:
+		nvme_failover_req(req);
+		return;
+	}
+}
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
 bool nvme_cancel_request(struct request *req, void *data, bool reserved)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3ded54d2c9c6ad..abc5bcf7209506 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -65,51 +65,30 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	}
 }
 
-bool nvme_failover_req(struct request *req)
+void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
-	u16 status = nvme_req(req)->status;
+	u16 status = nvme_req(req)->status & 0x7ff;
 	unsigned long flags;
 
-	switch (status & 0x7ff) {
-	case NVME_SC_ANA_TRANSITION:
-	case NVME_SC_ANA_INACCESSIBLE:
-	case NVME_SC_ANA_PERSISTENT_LOSS:
-		/*
-		 * If we got back an ANA error we know the controller is alive,
-		 * but not ready to serve this namespaces.  The spec suggests
-		 * we should update our general state here, but due to the fact
-		 * that the admin and I/O queues are not serialized that is
-		 * fundamentally racy.  So instead just clear the current path,
-		 * mark the the path as pending and kick of a re-read of the ANA
-		 * log page ASAP.
-		 */
-		nvme_mpath_clear_current_path(ns);
-		if (ns->ctrl->ana_log_buf) {
-			set_bit(NVME_NS_ANA_PENDING, &ns->flags);
-			queue_work(nvme_wq, &ns->ctrl->ana_work);
-		}
-		break;
-	case NVME_SC_HOST_PATH_ERROR:
-	case NVME_SC_HOST_ABORTED_CMD:
-		/*
-		 * Temporary transport disruption in talking to the controller.
-		 * Try to send on a new path.
-		 */
-		nvme_mpath_clear_current_path(ns);
-		break;
-	default:
-		/* This was a non-ANA error so follow the normal error path. */
-		return false;
+	nvme_mpath_clear_current_path(ns);
+
+	/*
+	 * If we got back an ANA error, we know the controller is alive but not
+	 * ready to serve this namespace.  Kick of a re-read of the ANA
+	 * information page, and just try any other available path for now.
+	 */
+	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
+		set_bit(NVME_NS_ANA_PENDING, &ns->flags);
+		queue_work(nvme_wq, &ns->ctrl->ana_work);
 	}
 
 	spin_lock_irqsave(&ns->head->requeue_lock, flags);
 	blk_steal_bios(&ns->head->requeue_list, req);
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
-	blk_mq_end_request(req, 0);
 
+	blk_mq_end_request(req, 0);
 	kblockd_schedule_work(&ns->head->requeue_work);
-	return true;
 }
 
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 510f7dbeba9871..4ff6fd2890821d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -523,6 +523,32 @@ static inline u32 nvme_bytes_to_numd(size_t len)
 	return (len >> 2) - 1;
 }
 
+static inline bool nvme_is_ana_error(u16 status)
+{
+	switch (status & 0x7ff) {
+	case NVME_SC_ANA_TRANSITION:
+	case NVME_SC_ANA_INACCESSIBLE:
+	case NVME_SC_ANA_PERSISTENT_LOSS:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static inline bool nvme_is_path_error(u16 status)
+{
+	switch (status & 0x7ff) {
+	case NVME_SC_HOST_PATH_ERROR:
+	case NVME_SC_HOST_ABORTED_CMD:
+	case NVME_SC_ANA_TRANSITION:
+	case NVME_SC_ANA_INACCESSIBLE:
+	case NVME_SC_ANA_PERSISTENT_LOSS:
+		return true;
+	default:
+		return false;
+	}
+}
+
 /*
  * Fill in the status and result information from the CQE, and then figure out
  * if blk-mq will need to use IPI magic to complete the request, and if yes do
@@ -635,7 +661,7 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
-bool nvme_failover_req(struct request *req);
+void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
@@ -694,9 +720,8 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
 }
 
-static inline bool nvme_failover_req(struct request *req)
+static inline void nvme_failover_req(struct request *req)
 {
-	return false;
 }
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
