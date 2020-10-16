Return-Path: <SRS0=oO1v=DX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F5AC433E7
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 14:28:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B6120866
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 14:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="kgg9DI8R";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H6Ou2x4j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B6120866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ArQtKkBhZGk9/tPRuCCk/EUg+wjvRAT+2gb3nIQntwY=; b=kgg9DI8RveKlRE3dMtT4cokRo
	TWHGDhZsqD3yYv1xGeumxZK/mm7BIUaHiFwCfuRzBhJU0NhKvfEqG26a9R6zja7048fNI95dE2+bH
	ZthXCXH1ezxoL10NK37ULhCvX0P7e0rHgIslQgKemfJP5df+YfIq/4XtRSyMI8ZkrHRE0Rjxs4JsJ
	gNBMWEPFaW+QImF39RDoXwJauWJ3M3YH/zoX/hZkEWYNzP55z32HnC7fWRt8CFT1RjmTF//c/Wjll
	XaFKT8EZk8bQt8UMg2gy2GFmmv/9u4c2Gkcu+izDMD9Ny9qPn1N+SzmfjARWm9MQ/avccIdeFW3eJ
	3SDRyzUmA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTQj0-0006fl-PX; Fri, 16 Oct 2020 14:28:54 +0000
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTQiy-0006ey-CO
 for linux-nvme@lists.infradead.org; Fri, 16 Oct 2020 14:28:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602858531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lz3Ou5mJa3qRn8JaO0Ng0wU2ITlWqsK2TaLAz5ZaXd8=;
 b=H6Ou2x4jtQNbdPy8lGvd4feYP13FlS7YsqpabSkzAIjedoQgzqEl7OiBVyJ2bDq7j01eV5
 RFEZC+8Y/qe8aGZVPZKR4LYyBDDjCbf5fn+lAQGOF4olWmTpaWMO08IgA54EymiyXtFMaE
 gyyggNKMhRACRqLy391ucXL1UB5SJWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-ANENXbAcPSyuCtPLGJdHug-1; Fri, 16 Oct 2020 10:28:47 -0400
X-MC-Unique: ANENXbAcPSyuCtPLGJdHug-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0171B186DD2A;
 Fri, 16 Oct 2020 14:28:46 +0000 (UTC)
Received: from localhost (ovpn-12-93.pek2.redhat.com [10.72.12.93])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D2556EF55;
 Fri, 16 Oct 2020 14:28:44 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH 3/4] nvme: tcp: fix race between timeout and normal completion
Date: Fri, 16 Oct 2020 22:28:10 +0800
Message-Id: <20201016142811.1262214-4-ming.lei@redhat.com>
In-Reply-To: <20201016142811.1262214-1-ming.lei@redhat.com>
References: <20201016142811.1262214-1-ming.lei@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_102852_455297_96FDFC03 
X-CRM114-Status: GOOD (  20.19  )
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
Cc: Yi Zhang <yi.zhang@redhat.com>, Sagi Grimberg <sagi@grimberg.me>,
 Chao Leng <lengchao@huawei.com>, Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

NVMe TCP timeout handler allows to abort request directly when the
controller isn't in LIVE state. nvme_tcp_error_recovery() updates
controller state as RESETTING, and schedule reset work function. If
new timeout comes before the work function is called, the new timedout
request will be aborted directly, however at that time, the controller
isn't shut down yet, then timeout abort vs. normal completion race
will be triggered.

Fix the race by the following approach:

1) aborting timed out request directly only in case that controller is in
CONNECTING and DELETING state. In the two states, controller has been shutdown,
so it is safe to do so; Also, it is enough to recovery controller in this way,
because we only stop/destroy queues during RESETTING, and cancel all in-flight
requests, no new request is required in RESETTING.

2) delay unquiesce io queues and admin queue until controller is LIVE
because it isn't necessary to start queues during RESETTING. Instead,
this way may risk timeout vs. normal completion race because we need
to abort timed-out request directly during CONNECTING state for setting
up controller.

CC: Chao Leng <lengchao@huawei.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Reported-by: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/tcp.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index d6a3e1487354..56ac61a90c1b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1886,7 +1886,6 @@ static int nvme_tcp_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_tcp_stop_queue(ctrl, 0);
 	if (ctrl->admin_tagset) {
@@ -1897,15 +1896,13 @@ static void nvme_tcp_teardown_admin_queue(struct nvme_ctrl *ctrl,
 	if (remove)
 		blk_mq_unquiesce_queue(ctrl->admin_q);
 	nvme_tcp_destroy_admin_queue(ctrl, remove);
-	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 		bool remove)
 {
-	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	if (ctrl->queue_count <= 1)
-		goto out;
+		return;
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	nvme_start_freeze(ctrl);
 	nvme_stop_queues(ctrl);
@@ -1918,8 +1915,6 @@ static void nvme_tcp_teardown_io_queues(struct nvme_ctrl *ctrl,
 	if (remove)
 		nvme_start_queues(ctrl);
 	nvme_tcp_destroy_io_queues(ctrl, remove);
-out:
-	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
@@ -1938,6 +1933,8 @@ static void nvme_tcp_reconnect_or_remove(struct nvme_ctrl *ctrl)
 				ctrl->opts->reconnect_delay * HZ);
 	} else {
 		dev_info(ctrl->device, "Removing controller...\n");
+		nvme_start_queues(ctrl);
+		blk_mq_unquiesce_queue(ctrl->admin_q);
 		nvme_delete_ctrl(ctrl);
 	}
 }
@@ -2030,11 +2027,11 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
 	nvme_stop_keep_alive(ctrl);
+
+	mutex_lock(&tcp_ctrl->teardown_lock);
 	nvme_tcp_teardown_io_queues(ctrl, false);
-	/* unquiesce to fail fast pending requests */
-	nvme_start_queues(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, false);
-	blk_mq_unquiesce_queue(ctrl->admin_q);
+	mutex_unlock(&tcp_ctrl->teardown_lock);
 
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_CONNECTING)) {
 		/* state change failure is ok if we started ctrl delete */
@@ -2051,6 +2048,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
 	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
 
+	mutex_lock(&to_tcp_ctrl(ctrl)->teardown_lock);
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
 	blk_mq_quiesce_queue(ctrl->admin_q);
 	if (shutdown)
@@ -2058,6 +2056,7 @@ static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	else
 		nvme_disable_ctrl(ctrl);
 	nvme_tcp_teardown_admin_queue(ctrl, shutdown);
+	mutex_unlock(&to_tcp_ctrl(ctrl)->teardown_lock);
 }
 
 static void nvme_tcp_delete_ctrl(struct nvme_ctrl *ctrl)
@@ -2192,19 +2191,20 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
 		"queue %d: timeout request %#x type %d\n",
 		nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);
 
-	if (ctrl->state != NVME_CTRL_LIVE) {
+	/*
+	 * During CONNECTING or DELETING, the controller has been shutdown,
+	 * so it is safe to abort the request directly, otherwise timeout
+	 * vs. normal completion will be triggered.
+	 */
+	if (ctrl->state == NVME_CTRL_CONNECTING ||
+			ctrl->state == NVME_CTRL_DELETING ||
+			ctrl->state == NVME_CTRL_DELETING_NOIO) {
 		/*
-		 * If we are resetting, connecting or deleting we should
-		 * complete immediately because we may block controller
-		 * teardown or setup sequence
+		 * If we are connecting we should complete immediately because
+		 * we may block controller setup sequence
 		 * - ctrl disable/shutdown fabrics requests
 		 * - connect requests
 		 * - initialization admin requests
-		 * - I/O requests that entered after unquiescing and
-		 *   the controller stopped responding
-		 *
-		 * All other requests should be cancelled by the error
-		 * recovery work, so it's fine that we fail it here.
 		 */
 		nvme_tcp_complete_timed_out(rq);
 		return BLK_EH_DONE;
-- 
2.25.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
