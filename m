Return-Path: <SRS0=HFDN=OT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCB5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 04:17:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 691216135D
	for <linux-nvme@archiver.kernel.org>; Wed, 29 Sep 2021 04:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 691216135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=A94IB4H+iaN9MLcVU3SB60SwcoGvs2ejFoz1dFo6v6o=; b=rKj9MGWrwN2Ly2
	VtbMzPx15TUXjFP8RZZjp0rwe4lqzlI2L00lH/hqcLgrpc0GyffXIgAIyjmvfx6A1E6lCfblIAq1+
	02cBuK5Jw3QBCG+Z+SDlM7Gv6FIG9wiRG+OC272Reb/qphOlkPDZEv8W0uOPXYXhIdN+4seyFJmW9
	q9DKygW43a9uCIFYfhCtPkZcES1hbDtc6B+QCwdeQhZb81YR6XFlgMjz1/NcwltwfbaJWg8Xsix+O
	ovlnn9ud9rUvoDg2qFCdtX+ffap0X4oqmp7DoryGhyz7pMbJXYX4gN5lXRH59ureW7bRrPQ3/1bFa
	yb008CJk3V4GG76CyYBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mVR1n-009uDB-V1; Wed, 29 Sep 2021 04:17:07 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mVR1b-009uB8-OL
 for linux-nvme@lists.infradead.org; Wed, 29 Sep 2021 04:16:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632889014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8khe7q1vnNQnXOkYiEUEG4zTHCshU/XmPklcL2J55YA=;
 b=bv6LWDcdKef+xVrjbWVyOegAA+aSTIBszdWXfWjCSKHywhvvob/1IXn1aeH0DuCTQagAyB
 ocLrjx85DhYcDf67hyNByhzha8H0GONf6Ia/rpqMrwo8KiAH9AK1VNplfgx3ywwL+JoD2T
 CecAkPAbTlh9GThecsfrHMxWaHdXWiE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-0pon3bRTM66hYpgZ0sgr0Q-1; Wed, 29 Sep 2021 00:16:49 -0400
X-MC-Unique: 0pon3bRTM66hYpgZ0sgr0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28AD584A5E0;
 Wed, 29 Sep 2021 04:16:48 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4C8BE5E255;
 Wed, 29 Sep 2021 04:16:46 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
 linux-block@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/5] nvme: apply nvme API to quiesce/unquiesce admin queue
Date: Wed, 29 Sep 2021 12:15:56 +0800
Message-Id: <20210929041559.701102-3-ming.lei@redhat.com>
In-Reply-To: <20210929041559.701102-1-ming.lei@redhat.com>
References: <20210929041559.701102-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210928_211655_920281_9CF7549B 
X-CRM114-Status: GOOD (  18.63  )
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

Apply the added two APIs to quiesce/unquiesce admin queue.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/core.c   |  2 +-
 drivers/nvme/host/fc.c     |  8 ++++----
 drivers/nvme/host/pci.c    |  8 ++++----
 drivers/nvme/host/rdma.c   | 14 +++++++-------
 drivers/nvme/host/tcp.c    | 16 ++++++++--------
 drivers/nvme/target/loop.c |  4 ++--
 6 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c675eef70a63..91d91d4f76d7 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4484,7 +4484,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
 	if (ctrl->admin_q && !blk_queue_dying(ctrl->admin_q))
-		blk_mq_unquiesce_queue(ctrl->admin_q);
+		nvme_start_admin_queue(ctrl);
 
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		nvme_set_queue_dying(ns);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index aa14ad963d91..580a216da619 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2382,7 +2382,7 @@ nvme_fc_ctrl_free(struct kref *ref)
 	list_del(&ctrl->ctrl_list);
 	spin_unlock_irqrestore(&ctrl->rport->lock, flags);
 
-	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+	nvme_start_admin_queue(&ctrl->ctrl);
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
 	blk_cleanup_queue(ctrl->ctrl.fabrics_q);
 	blk_mq_free_tag_set(&ctrl->admin_tag_set);
@@ -2510,7 +2510,7 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 	/*
 	 * clean up the admin queue. Same thing as above.
 	 */
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvme_stop_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
@@ -3095,7 +3095,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	ctrl->ctrl.max_hw_sectors = ctrl->ctrl.max_segments <<
 						(ilog2(SZ_4K) - 9);
 
-	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+	nvme_start_admin_queue(&ctrl->ctrl);
 
 	ret = nvme_init_ctrl_finish(&ctrl->ctrl);
 	if (ret || test_bit(ASSOC_FAILED, &ctrl->flags))
@@ -3249,7 +3249,7 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	nvme_fc_free_queue(&ctrl->queues[0]);
 
 	/* re-enable the admin_q so anything new can fast fail */
-	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+	nvme_start_admin_queue(&ctrl->ctrl);
 
 	/* resume the io queues so that things will fast fail */
 	nvme_start_queues(&ctrl->ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ca5bda26226a..fa3efb003aa6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1396,7 +1396,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 
 	nvmeq->dev->online_queues--;
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
-		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
+		nvme_stop_admin_queue(&nvmeq->dev->ctrl);
 	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags))
 		pci_free_irq(to_pci_dev(nvmeq->dev->dev), nvmeq->cq_vector, nvmeq);
 	return 0;
@@ -1655,7 +1655,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 		 * user requests may be waiting on a stopped queue. Start the
 		 * queue to flush these to completion.
 		 */
-		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
+		nvme_start_admin_queue(&dev->ctrl);
 		blk_cleanup_queue(dev->ctrl.admin_q);
 		blk_mq_free_tag_set(&dev->admin_tagset);
 	}
@@ -1689,7 +1689,7 @@ static int nvme_alloc_admin_tags(struct nvme_dev *dev)
 			return -ENODEV;
 		}
 	} else
-		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
+		nvme_start_admin_queue(&dev->ctrl);
 
 	return 0;
 }
@@ -2624,7 +2624,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	if (shutdown) {
 		nvme_start_queues(&dev->ctrl);
 		if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q))
-			blk_mq_unquiesce_queue(dev->ctrl.admin_q);
+			nvme_start_admin_queue(&dev->ctrl);
 	}
 	mutex_unlock(&dev->shutdown_lock);
 }
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 40317e1b9183..799a35558986 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -919,7 +919,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	else
 		ctrl->ctrl.max_integrity_segments = 0;
 
-	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+	nvme_start_admin_queue(&ctrl->ctrl);
 
 	error = nvme_init_ctrl_finish(&ctrl->ctrl);
 	if (error)
@@ -928,7 +928,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	return 0;
 
 out_quiesce_queue:
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvme_stop_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 out_stop_queue:
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
@@ -1026,12 +1026,12 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 static void nvme_rdma_teardown_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvme_stop_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	if (remove)
-		blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+		nvme_start_admin_queue(&ctrl->ctrl);
 	nvme_rdma_destroy_admin_queue(ctrl, remove);
 }
 
@@ -1154,7 +1154,7 @@ static int nvme_rdma_setup_ctrl(struct nvme_rdma_ctrl *ctrl, bool new)
 		nvme_rdma_destroy_io_queues(ctrl, new);
 	}
 destroy_admin:
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvme_stop_admin_queue(&ctrl->ctrl);
 	blk_sync_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
@@ -1194,7 +1194,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	nvme_rdma_teardown_io_queues(ctrl, false);
 	nvme_start_queues(&ctrl->ctrl);
 	nvme_rdma_teardown_admin_queue(ctrl, false);
-	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+	nvme_start_admin_queue(&ctrl->ctrl);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
@@ -2232,7 +2232,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 	cancel_delayed_work_sync(&ctrl->reconnect_work);
 
 	nvme_rdma_teardown_io_queues(ctrl, shutdown);
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvme_stop_admin_queue(&ctrl->ctrl);
 	if (shutdown)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 	else
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 3c1c29dd3020..4109b726e052 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1915,7 +1915,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	if (error)
 		goto out_stop_queue;
 
-	blk_mq_unquiesce_queue(ctrl->admin_q);
+	nvme_start_admin_queue(ctrl);
 
 	error = nvme_init_ctrl_finish(ctrl);
 	if (error)
@@ -1924,7 +1924,7 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	return 0;
 
 out_quiesce_queue:
-	blk_mq_quiesce_queue(ctrl->admin_q);
+	nvme_stop_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 out_stop_queue:
 	nvme_tcp_stop_queue(ctrl, 0);
@@ -1946,12 +1946,12 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	blk_mq_quiesce_queue(ctrl->admin_q);
+	nvme_stop_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	nvme_cancel_admin_tagset(ctrl);
 	if (remove)
-		blk_mq_unquiesce_queue(ctrl->admin_q);
+		nvme_start_admin_queue(ctrl);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
 }
 
@@ -1960,7 +1960,7 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 {
 	if (ctrl->queue_count <= 1)
 		return;
-	blk_mq_quiesce_queue(ctrl->admin_q);
+	nvme_stop_admin_queue(ctrl);
 	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
 	nvme_sync_io_queues(ctrl);
@@ -2055,7 +2055,7 @@ static int nvme_tcp_setup_ctrl(struct nvme_ctrl *ctrl, bool new)
 		nvme_tcp_destroy_io_queues(ctrl, new);
 	}
 destroy_admin:
-	blk_mq_quiesce_queue(ctrl->admin_q);
+	nvme_stop_admin_queue(ctrl);
 	blk_sync_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	nvme_cancel_admin_tagset(ctrl);
@@ -2098,7 +2098,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	/* unquiesce to fail fast pending requests */
 	nvme_start_queues(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, false);
-	blk_mq_unquiesce_queue(ctrl->admin_q);
+	nvme_start_admin_queue(ctrl);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
@@ -2116,7 +2116,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
 
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
-	blk_mq_quiesce_queue(ctrl->admin_q);
+	nvme_stop_admin_queue(ctrl);
 	if (shutdown)
 		nvme_shutdown_ctrl(ctrl);
 	else
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 0285ccc7541f..440e1544033b 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -398,7 +398,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	ctrl->ctrl.max_hw_sectors =
 		(NVME_LOOP_MAX_SEGMENTS - 1) << (PAGE_SHIFT - 9);
 
-	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+	nvme_start_admin_queue(&ctrl->ctrl);
 
 	error = nvme_init_ctrl_finish(&ctrl->ctrl);
 	if (error)
@@ -428,7 +428,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 		nvme_loop_destroy_io_queues(ctrl);
 	}
 
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	nvme_stop_admin_queue(&ctrl->ctrl);
 	if (ctrl->ctrl.state == NVME_CTRL_LIVE)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 
-- 
2.31.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
