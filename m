Return-Path: <SRS0=j3u6=B3=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369AEC433E1
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 08:18:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D380C20738
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2020 08:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kyBBmlBz";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YaCwPc9d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D380C20738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=VHRPORoGmhYcvMB3NieFPYZmyAdVxsVBSJwfDzqxpR4=; b=kyBBmlBzyhrX2mGj/Ez6SYwxl
	7B5mYXN2BACC/Q5ngpLoZeZ5cksdGlVLup2xkhr0U/JA32Evr1agUT782xm/jk2HIWtfd6WDrOc+V
	XgLax6CcsYg6q6bv1O0VoSRInx8+W7qTP0857yDKLkJevqg6gV/IEqaEhCNUB8Plrsj83vtqVAbc7
	2FlcAxb37L9ZjPQOPbaPTdLnpxQbHMfuVsiRNp2rESaSBFf5Yic8uXbk0Tlk6C8U1oN6Zd2yee7Hn
	CZMVTN8+PQKNF071CAj5yBSmeUOXnVFinA6FQfvJHbO/wqvLl2XQKeOoPDVxzV5FsWqeQ+YV5pDRT
	Gvk90jT+w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k7aLs-0007QM-W4; Mon, 17 Aug 2020 08:18:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7aLD-00077d-Bb
 for linux-nvme@merlin.infradead.org; Mon, 17 Aug 2020 08:18:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=A79G/rkEfMUaCKMoME268iJszYyvKIk+neodRGTNUwg=; b=YaCwPc9djy5PSA8Vd76TjiY+s5
 g2QCNyWvN9HsIk+hMaUfHeNdx3vHkEmqLfzPzXFjK16IsuxKpdSky+Mt2orwVov4iIXhk47kpE+L9
 b/pJ6MPBrt88hl4k2j1hTt1Ke2IIon8I6nKR/f/T5ZNRkZEPJNHK7oxoTIlrEVdZ5HgOgEHGzgurD
 wxGzC+URYjYL9DyNQCDS2GMAsh28GxFZaSNFdmOhBi4On0AZih20N2hPw001LtNJQyhsz8LYZ6H87
 xWcmK4Ex7ix/AsEvMcEY7JQyocHlKRsy6PUJOaY1i2K1chF5x2ZUhuDqvYAs8RTGukJXUJeILZa1D
 dX6Eta2w==;
Received: from [2001:4bb8:188:3918:4550:cdf7:3d45:afb9] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k7aLB-000460-8t; Mon, 17 Aug 2020 08:18:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/4] nvme: refactor command completion
Date: Mon, 17 Aug 2020 10:15:42 +0200
Message-Id: <20200817081544.837699-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817081544.837699-1-hch@lst.de>
References: <20200817081544.837699-1-hch@lst.de>
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
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Lift all the code to decide the dispostition of a completed command
from nvme_complete_rq and nvme_failover_req into a new helper, which
returns an emum of the potential actions.  nvme_complete_rq then
just switches on those and calls the proper helper for the action.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c      | 76 ++++++++++++++++++++++-------------
 drivers/nvme/host/multipath.c | 47 ++++++----------------
 drivers/nvme/host/nvme.h      | 31 ++++++++++++--
 3 files changed, 90 insertions(+), 64 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88cff309d8e4f0..8d474adad721fb 100644
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
@@ -268,34 +257,67 @@ static void nvme_retry_req(struct request *req)
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
+	u16 status = nvme_req(req)->status & 0x7ff;
 
-	trace_nvme_complete_rq(req);
+	if (likely(status == 0))
+		return COMPLETE;
 
-	nvme_cleanup_cmd(req);
+	if (blk_noretry_request(req) || (status & NVME_SC_DNR) ||
+	    nvme_req(req)->retries >= nvme_max_retries)
+		return COMPLETE;
 
-	if (nvme_req(req)->ctrl->kas)
-		nvme_req(req)->ctrl->comp_seen = true;
+	if (req->cmd_flags & REQ_NVME_MPATH) {
+		if (nvme_is_path_error(status))
+			return FAILOVER;
+	}
 
-	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
-			return;
+	if (blk_queue_dying(req->q))
+		return COMPLETE;
 
-		if (!blk_queue_dying(req->q)) {
-			nvme_retry_req(req);
-			return;
-		}
-	} else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-		   req_op(req) == REQ_OP_ZONE_APPEND) {
+	return RETRY;
+}
+
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
index 6d69cc7306d034..dfcdeb318f3ab6 100644
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
  * Fill in the status and result information from the CQE, and then figure
  * out if we blk-mq will need to use IPI magic to complete the request, and
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
