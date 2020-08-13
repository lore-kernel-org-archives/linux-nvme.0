Return-Path: <SRS0=x9Yf=BX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C19C433E1
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 18:44:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 381E42078B
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2020 18:44:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0pX/yQZ1";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CA9J0NCe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 381E42078B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=rPvDcBdZLRwkzMV33KT6ul1sRNfrNRLz1DMCu+wOJrE=; b=0pX/yQZ1aqTQsFq2b3HzubQEJ
	dg5T4n7o5P9lRpIeJhnrRxHjdLgVxhh1ZSNIEAN6INnQLGO/89AMtKc+ZftQBKfaci5F62I/F/p4f
	WheMrzBoUY7lLnxScVsNQs0SoPwYi90X6c6LxW5zZs7daXIEq4C3LnR6KdYlGaLetwwFJ8OBAe+jd
	o4yiIbNOQyvZjX8NmFQpiNCI3F6rfM36MEwqd+uoUZKrj4oT0n3xTbzD5fFBU63B1r0KWgegHFWIC
	alTEwuDy4UQ5WfnqI0RebxzeHfNyFuufU0Q7j2QADasxxpjWMOhpmP0XWt4Zs8Jmfuzw5JIPHRh0G
	b9Qwd2fRA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6ICi-000210-1E; Thu, 13 Aug 2020 18:43:56 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6ICg-00020u-Dt
 for linux-nvme@merlin.infradead.org; Thu, 13 Aug 2020 18:43:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=t5nJE96O1RkmYsGdZnhCkj4DTRVVWzDm77I82JJRQtA=; b=CA9J0NCe6CMZ6ezAGlNitnS48M
 86c0hE90PADtakCk/u5Yj7lf6/XNtjnRrsHbP7uUnn+vya2ewpf5NQ3tJXN6ukqasTCnO3BGySk7B
 k6DMViThU1tB60iHoKCdOWW7WXO13dXYrYVv/f8FxRUi+RFdPT8iMqT1gEZV+Briv3M0bCd5UjoBo
 7d4z2aAJFwKpAIp5S6EbAbMyK78C31/qyg2+fuByxZJM5T9Qtt4jsDX2khq+wQGA93wUFf5DtXBdQ
 Ov3fUuTx1mhQE21UVraA5CBBPYuLwVwzXPI5WqZYTHrByKPcVOeDAY1vOcEEnXd7W+GZyrM61mwWA
 beefihJQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat
 Linux)) id 1k6ICb-0002dc-Jp; Thu, 13 Aug 2020 18:43:49 +0000
Date: Thu, 13 Aug 2020 19:43:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@redhat.com>
Subject: Re: [RESEND PATCH] nvme: explicitly use normal NVMe error handling
 when appropriate
Message-ID: <20200813184349.GA8191@infradead.org>
References: <6B826235-C504-4621-B8F7-34475B200979@netapp.com>
 <20200807000755.GA28957@redhat.com>
 <510f5aff-0437-b1ce-f7ab-c812edbea880@grimberg.me>
 <20200807045015.GA29737@redhat.com>
 <fec745aa-0091-ee1f-cb0f-da9e18cf0aa2@grimberg.me>
 <20200810143620.GA19127@redhat.com>
 <20200810172209.GA19535@redhat.com>
 <20200813144811.GA5452@redhat.com>
 <20200813153623.GA30905@infradead.org>
 <20200813174704.GA6137@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200813174704.GA6137@redhat.com>
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@infradead.org>,
 dm-devel@redhat.com, Ewan Milne <emilne@redhat.com>,
 Chao Leng <lengchao@huawei.com>, Keith Busch <kbusch@kernel.org>, "Meneghini,
 John" <John.Meneghini@netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Thu, Aug 13, 2020 at 01:47:04PM -0400, Mike Snitzer wrote:
> This is just a tweak to improve the high-level fault tree of core NVMe
> error handling.  No functional change, but for such basic errors,
> avoiding entering nvme_failover_req is meaningful on a code flow level.
> Makes code to handle errors that need local retry clearer by being more
> structured, less circuitous.
> 
> Allows NVMe core's handling of such errors to be more explicit and live
> in core.c rather than multipath.c -- so things like ACRE handling can be
> made explicitly part of core and not nested under nvme_failover_req's
> relatively obscure failsafe that returns false for anything it doesn't
> care about.

If we're going that way I'd rather do something like the (untested)
patch below that adds a dispostion function with a function that
decides it and then just switches on it:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 88cff309d8e4f0..a740320f0d4ee7 100644
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
@@ -268,33 +257,75 @@ static void nvme_retry_req(struct request *req)
 	blk_mq_delay_kick_requeue_list(req->q, delay);
 }
 
-void nvme_complete_rq(struct request *req)
+enum nvme_disposition {
+	COMPLETE,
+	RETRY,
+	REDIRECT_ANA,
+	REDIRECT_TMP,
+};
+
+static inline enum nvme_disposition nvme_req_disposition(struct request *req)
+{
+	if (likely(nvme_req(req)->status == 0))
+		return COMPLETE;
+
+	if (blk_noretry_request(req) ||
+	    (nvme_req(req)->status & NVME_SC_DNR) ||
+	    nvme_req(req)->retries >= nvme_max_retries)
+		return COMPLETE;
+
+	if (req->cmd_flags & REQ_NVME_MPATH) {
+		switch (nvme_req(req)->status & 0x7ff) {
+		case NVME_SC_ANA_TRANSITION:
+		case NVME_SC_ANA_INACCESSIBLE:
+		case NVME_SC_ANA_PERSISTENT_LOSS:
+			return REDIRECT_ANA;
+		case NVME_SC_HOST_PATH_ERROR:
+		case NVME_SC_HOST_ABORTED_CMD:
+			return REDIRECT_TMP;
+		}
+	}
+
+	if (blk_queue_dying(req->q))
+		return COMPLETE;
+	return RETRY;
+}
+
+static inline void nvme_complete_req(struct request *req)
 {
 	blk_status_t status = nvme_error_status(nvme_req(req)->status);
 
-	trace_nvme_complete_rq(req);
+	if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
+	    req_op(req) == REQ_OP_ZONE_APPEND)
+		req->__sector = nvme_lba_to_sect(req->q->queuedata,
+			le64_to_cpu(nvme_req(req)->result.u64));
+
+	nvme_trace_bio_complete(req, status);
+	blk_mq_end_request(req, status);
+}
 
+void nvme_complete_rq(struct request *req)
+{
+	trace_nvme_complete_rq(req);
 	nvme_cleanup_cmd(req);
 
 	if (nvme_req(req)->ctrl->kas)
 		nvme_req(req)->ctrl->comp_seen = true;
 
-	if (unlikely(status != BLK_STS_OK && nvme_req_needs_retry(req))) {
-		if ((req->cmd_flags & REQ_NVME_MPATH) && nvme_failover_req(req))
-			return;
-
-		if (!blk_queue_dying(req->q)) {
-			nvme_retry_req(req);
-			return;
-		}
-	} else if (IS_ENABLED(CONFIG_BLK_DEV_ZONED) &&
-		   req_op(req) == REQ_OP_ZONE_APPEND) {
-		req->__sector = nvme_lba_to_sect(req->q->queuedata,
-			le64_to_cpu(nvme_req(req)->result.u64));
+	switch (nvme_req_disposition(req)) {
+	case COMPLETE:
+		nvme_complete_req(req);
+		return;
+	case RETRY:
+		nvme_retry_req(req);
+		return;
+	case REDIRECT_ANA:
+		nvme_failover_req(req, true);
+		return;
+	case REDIRECT_TMP:
+		nvme_failover_req(req, false);
+		return;
 	}
-
-	nvme_trace_bio_complete(req, status);
-	blk_mq_end_request(req, status);
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3ded54d2c9c6ad..0c22b2c88687a2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -65,51 +65,32 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	}
 }
 
-bool nvme_failover_req(struct request *req)
+void nvme_failover_req(struct request *req, bool is_ana_status)
 {
 	struct nvme_ns *ns = req->q->queuedata;
-	u16 status = nvme_req(req)->status;
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
+	 * If we got back an ANA error we know the controller is alive, but not
+	 * ready to serve this namespaces.  The spec suggests we should update
+	 * our general state here, but due to the fact that the admin and I/O
+	 * queues are not serialized that is fundamentally racy.  So instead
+	 * just clear the current path, mark the the path as pending and kick
+	 * of a re-read of the ANA log page ASAP.
+	 */
+	if (is_ana_status && ns->ctrl->ana_log_buf) {
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
index ebb8c3ed388554..aeff1c491ac2ef 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -629,7 +629,7 @@ void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags);
-bool nvme_failover_req(struct request *req);
+void nvme_failover_req(struct request *req, bool is_ana_status);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id);
@@ -688,9 +688,8 @@ static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
 }
 
-static inline bool nvme_failover_req(struct request *req)
+static inline void nvme_failover_req(struct request *req, bool is_ana_status)
 {
-	return false;
 }
 static inline void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 {

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
