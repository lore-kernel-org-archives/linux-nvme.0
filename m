Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00248FCE07F
	for <linux-nvme@archiver.kernel.org>; Thu, 26 Feb 2026 13:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+RdHQmGra2FLVl/W9ilWFks617j4wVuoSbsKqd0Thn8=; b=so7t2yHQycjkmL9FEry8BVYy16
	CM47MvKv++zlYjapXJm/RAq4NrrEMl1kE6u4if4eah4SYA20kBgmBW8XGG9c8YG4N1ks1KDIc1LBY
	17aKsNI0yK1Xr5IQbCFZZljw6vEJuHTi1xDuDGxZTM+ZMfCFOiGY4O/yHLN+Ba4vSZhmFW8q6ced6
	KiOpubBjVulGxgRxGWyBDAi9DLW5nlwPsH9lD9/MJL8Z5id2oionxCRTgoundgErEwzqh84zIjBAd
	baBdaUyB1268DtNvf+qS1jI50Msf/OOZY6Ono5c1q00JXV0gSXh+4v4u9FBW5WN13cHYq4pU3bI2Y
	JcWEJEmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvbbx-00000006ElV-2Mzv;
	Thu, 26 Feb 2026 13:41:01 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvbbv-00000006EkW-0jdC
	for linux-nvme@lists.infradead.org;
	Thu, 26 Feb 2026 13:41:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0B20444169;
	Thu, 26 Feb 2026 13:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE7AC116C6;
	Thu, 26 Feb 2026 13:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772113257;
	bh=0azBERXcRTN33V3AXQD758lpRoN9AlvXH7kqpfeZ/q8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oBk6/A9/NcPJ7ezf065AonndDI7t79vPhZKPshoYUMPaojwkjTSE+mJ4WcWhgVWTw
	 dK7/7k654nvJNsBtpvFRt9uRbl65D5bAD+4KfdBCWIb+z/y6okemcmxRxUG9QpyNe5
	 RvHnYqLzVc8Fec6+ZGH29JvAKOV3H+RlyIjWS6BS+QJyYhKeW7ttHWyKBRBMXSbiWH
	 WxHboMdWAeVe36vNg+87wrWVXOJqbI1B2ZAynBNlHMirw1Le0nurwLZC8p7jVzDWLN
	 GUx/jGVnAZ9eLkL2USDt46PdqHDjhcClOSSj7ssqJty8Cemi5wlUg+siYDsQs9vplU
	 mW3NsJcdsLsJA==
From: Daniel Wagner <wagi@kernel.org>
Date: Thu, 26 Feb 2026 14:40:35 +0100
Subject: [PATCH 1/3] nvme: failover requests for inactive hctx
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260226-revert-cpu-read-lock-v1-1-eb005072566e@kernel.org>
References: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
In-Reply-To: <20260226-revert-cpu-read-lock-v1-0-eb005072566e@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>, 
 Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>
Cc: Guangwu Zhang <guazhang@redhat.com>, 
 Chengming Zhou <zhouchengming@bytedance.com>, 
 Thomas Gleixner <tglx@kernel.org>, linux-nvme@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.3
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260226_054059_285437_B0973CCE 
X-CRM114-Status: GOOD (  21.50  )
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

When the ctrl is not in LIVE state, a hardware queue can be in the
INACTIVE state due to CPU hotplug offlining operations. In this case,
the driver will freeze and quiesce the request queue and doesn't expect
new request entering via queue_rq. Though a request will fail eventually,
though shortcut it and fail it earlier.

Check if a request is targeted for an inactive hardware queue and use
nvme_failover_req and hand it back to the block layer.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/core.c      | 55 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/multipath.c | 43 ---------------------------------
 drivers/nvme/host/nvme.h      |  1 -
 3 files changed, 54 insertions(+), 45 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5ebcaa2f859..e84df1a2d321 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -454,6 +454,51 @@ void nvme_end_req(struct request *req)
 	blk_mq_end_request(req, status);
 }
 
+static void nvme_failover_req(struct request *req)
+{
+	struct nvme_ns *ns = req->q->queuedata;
+	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
+	unsigned long flags;
+	struct bio *bio;
+
+	if (nvme_ns_head_multipath(ns->head))
+		nvme_mpath_clear_current_path(ns);
+
+	/*
+	 * If we got back an ANA error, we know the controller is alive but not
+	 * ready to serve this namespace.  Kick of a re-read of the ANA
+	 * information page, and just try any other available path for now.
+	 */
+	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
+		set_bit(NVME_NS_ANA_PENDING, &ns->flags);
+		queue_work(nvme_wq, &ns->ctrl->ana_work);
+	}
+
+	spin_lock_irqsave(&ns->head->requeue_lock, flags);
+	for (bio = req->bio; bio; bio = bio->bi_next) {
+		if (nvme_ns_head_multipath(ns->head))
+			bio_set_dev(bio, ns->head->disk->part0);
+		if (bio->bi_opf & REQ_POLLED) {
+			bio->bi_opf &= ~REQ_POLLED;
+			bio->bi_cookie = BLK_QC_T_NONE;
+		}
+		/*
+		 * The alternate request queue that we may end up submitting
+		 * the bio to may be frozen temporarily, in this case REQ_NOWAIT
+		 * will fail the I/O immediately with EAGAIN to the issuer.
+		 * We are not in the issuer context which cannot block. Clear
+		 * the flag to avoid spurious EAGAIN I/O failures.
+		 */
+		bio->bi_opf &= ~REQ_NOWAIT;
+	}
+	blk_steal_bios(&ns->head->requeue_list, req);
+	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
+
+	nvme_req(req)->status = 0;
+	nvme_end_req(req);
+	kblockd_schedule_work(&ns->head->requeue_work);
+}
+
 void nvme_complete_rq(struct request *req)
 {
 	struct nvme_ctrl *ctrl = nvme_req(req)->ctrl;
@@ -762,8 +807,13 @@ blk_status_t nvme_fail_nonready_command(struct nvme_ctrl *ctrl,
 	    state != NVME_CTRL_DELETING &&
 	    state != NVME_CTRL_DEAD &&
 	    !test_bit(NVME_CTRL_FAILFAST_EXPIRED, &ctrl->flags) &&
-	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH))
+	    !blk_noretry_request(rq) && !(rq->cmd_flags & REQ_NVME_MPATH)) {
+		if (test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state)) {
+			nvme_failover_req(rq);
+			return BLK_STS_OK;
+		}
 		return BLK_STS_RESOURCE;
+	}
 
 	if (!(rq->rq_flags & RQF_DONTPREP))
 		nvme_clear_nvme_request(rq);
@@ -809,6 +859,9 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 		}
 	}
 
+	if (test_bit(BLK_MQ_S_INACTIVE, &rq->mq_hctx->state))
+		return false;
+
 	return queue_live;
 }
 EXPORT_SYMBOL_GPL(__nvme_check_ready);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 174027d1cc19..cce3a23f6de5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -134,49 +134,6 @@ void nvme_mpath_start_freeze(struct nvme_subsystem *subsys)
 			blk_freeze_queue_start(h->disk->queue);
 }
 
-void nvme_failover_req(struct request *req)
-{
-	struct nvme_ns *ns = req->q->queuedata;
-	u16 status = nvme_req(req)->status & NVME_SCT_SC_MASK;
-	unsigned long flags;
-	struct bio *bio;
-
-	nvme_mpath_clear_current_path(ns);
-
-	/*
-	 * If we got back an ANA error, we know the controller is alive but not
-	 * ready to serve this namespace.  Kick of a re-read of the ANA
-	 * information page, and just try any other available path for now.
-	 */
-	if (nvme_is_ana_error(status) && ns->ctrl->ana_log_buf) {
-		set_bit(NVME_NS_ANA_PENDING, &ns->flags);
-		queue_work(nvme_wq, &ns->ctrl->ana_work);
-	}
-
-	spin_lock_irqsave(&ns->head->requeue_lock, flags);
-	for (bio = req->bio; bio; bio = bio->bi_next) {
-		bio_set_dev(bio, ns->head->disk->part0);
-		if (bio->bi_opf & REQ_POLLED) {
-			bio->bi_opf &= ~REQ_POLLED;
-			bio->bi_cookie = BLK_QC_T_NONE;
-		}
-		/*
-		 * The alternate request queue that we may end up submitting
-		 * the bio to may be frozen temporarily, in this case REQ_NOWAIT
-		 * will fail the I/O immediately with EAGAIN to the issuer.
-		 * We are not in the issuer context which cannot block. Clear
-		 * the flag to avoid spurious EAGAIN I/O failures.
-		 */
-		bio->bi_opf &= ~REQ_NOWAIT;
-	}
-	blk_steal_bios(&ns->head->requeue_list, req);
-	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
-
-	nvme_req(req)->status = 0;
-	nvme_end_req(req);
-	kblockd_schedule_work(&ns->head->requeue_work);
-}
-
 void nvme_mpath_start_request(struct request *rq)
 {
 	struct nvme_ns *ns = rq->q->queuedata;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9a5f28c5103c..dbd063413da9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -967,7 +967,6 @@ void nvme_mpath_unfreeze(struct nvme_subsystem *subsys);
 void nvme_mpath_wait_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_start_freeze(struct nvme_subsystem *subsys);
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys);
-void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
 void nvme_mpath_add_sysfs_link(struct nvme_ns_head *ns);

-- 
2.53.0


