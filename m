Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A24EE9904A
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Apr 2026 07:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1w2yi7Y4qGfPvy03af6GZoxCKD/u+DWPSSJWrMPWays=; b=fjKf1VhlFXSYelnAW9beLAKBqy
	+TqpOkRlDaU2Q96ZI3caAJmpYUo9LCGUNL7OpF8Yeo892Hut6V+X2annVBXIae6GcZD/5H2jHcePP
	7a4+Jlt0bffDzqHZUNii+7P+1UtvzdLJNOnm9/pK9wU7XdqB79DETjbT7hRhCK5HqkqLuzxOx0yg0
	kjb5BmK+ZKhQX4WMjWAPu25XPX+preCvl7MG0G8iT8qaf2DG47Gd5Dersb5HmkLZEx2tBMSIhQx1i
	DO+8NGqzRFRAy4o07U/UzW6Fw+9chYWOby/xypSdZ5TvdrqYjOHoqlae/7IXP2aFmmqzRqtLd8Bwt
	YAnBwWOg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6TG-0000000BlGT-2Ydu;
	Fri, 10 Apr 2026 07:40:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wB6TD-0000000BlDs-4B6i
	for linux-nvme@lists.infradead.org;
	Fri, 10 Apr 2026 07:40:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775806803;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1w2yi7Y4qGfPvy03af6GZoxCKD/u+DWPSSJWrMPWays=;
	b=jSGB0QiH4HH9CRcu4yPnDjo9iMK7yeBTj5pTHbA9Bn5+LFv1EwhKY81WG6BNfmEZfeLBiG
	EYMYsWZB5cY9hGDw/FtLL+vMVqarVa/Rn+VNEp26jJUWm+rEutB/KH/2rP6ihDYJpF1C7B
	xS99k6B8GGVnAPIFblna2RcQwVvlnl4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-711-hOeJsq9lMtimXvcK_8VlgQ-1; Fri,
 10 Apr 2026 03:40:00 -0400
X-MC-Unique: hOeJsq9lMtimXvcK_8VlgQ-1
X-Mimecast-MFC-AGG-ID: hOeJsq9lMtimXvcK_8VlgQ_1775806798
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 74D50180044D;
	Fri, 10 Apr 2026 07:39:58 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.170])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AF2918002A6;
	Fri, 10 Apr 2026 07:39:54 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: mheyne@amazon.de,
	emilne@redhat.com,
	jmeneghi@redhat.com,
	linux-nvme@lists.infradead.org,
	dwagner@suse.de,
	mlombard@arkamax.eu,
	mkhalfella@purestorage.com,
	chaitanyak@nvidia.com,
	hare@kernel.org,
	hch@lst.de
Subject: [PATCH V3 7/8] nvmet-loop: do not alloc admin tag set during reset
Date: Fri, 10 Apr 2026 09:39:23 +0200
Message-ID: <20260410073924.61078-8-mlombard@redhat.com>
In-Reply-To: <20260410073924.61078-1-mlombard@redhat.com>
References: <20260410073924.61078-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Zxqi9_tKrSsZXnFGBshSAfBqm6_hsCnOGwCmTiHhUDM_1775806798
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260410_004004_105126_D8F94758 
X-CRM114-Status: GOOD (  16.07  )
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

Currently, resetting a loopback controller unconditionally invokes
nvme_alloc_admin_tag_set() inside nvme_loop_configure_admin_queue().
Doing so drops the old queue and allocates a new one. Consequently,
this reverts the admin queue's timeout (q->rq_timeout) back to the
module default (NVME_ADMIN_TIMEOUT), completely wiping out any custom
timeout values the user may have configured via sysfs and potentially
racing against the sysfs nvme_admin_timeout_store() function
that may dereference the admin_q pointer during the RESETTING state.

Add a 'new' boolean parameter to nvme_loop_configure_admin_queue() to
distinguish between an initial probe and a reset. Only allocate the
admin tag set during the initial controller creation and do not
remove it when resetting the controller.
This ensures the existing queues and their sysfs-configured timeouts
remain intact across controller resets.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/loop.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d98d0cdc5d6f..c9cf0ddc1b85 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -261,7 +261,7 @@ static const struct blk_mq_ops nvme_loop_admin_mq_ops = {
 	.init_hctx	= nvme_loop_init_admin_hctx,
 };
 
-static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
+static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl, bool remove)
 {
 	if (!test_and_clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags))
 		return;
@@ -274,7 +274,8 @@ static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
 	nvmet_cq_put(&ctrl->queues[0].nvme_cq);
-	nvme_remove_admin_tag_set(&ctrl->ctrl);
+	if (remove)
+		nvme_remove_admin_tag_set(&ctrl->ctrl);
 }
 
 static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
@@ -361,7 +362,7 @@ static int nvme_loop_connect_io_queues(struct nvme_loop_ctrl *ctrl)
 	return 0;
 }
 
-static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
+static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl, bool new)
 {
 	int error;
 
@@ -375,12 +376,15 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	}
 	ctrl->ctrl.queue_count = 1;
 
-	error = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
-			&nvme_loop_admin_mq_ops,
-			sizeof(struct nvme_loop_iod) +
-			NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
-	if (error)
-		goto out_free_sq;
+	if (new) {
+		error = nvme_alloc_admin_tag_set(&ctrl->ctrl,
+				&ctrl->admin_tag_set,
+				&nvme_loop_admin_mq_ops,
+				sizeof(struct nvme_loop_iod) +
+				NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
+		if (error)
+			goto out_free_sq;
+	}
 
 	/* reset stopped state for the fresh admin queue */
 	clear_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->ctrl.flags);
@@ -415,7 +419,7 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	return error;
 }
 
-static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
+static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl, bool remove)
 {
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_quiesce_io_queues(&ctrl->ctrl);
@@ -426,12 +430,12 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 	if (nvme_ctrl_state(&ctrl->ctrl) == NVME_CTRL_LIVE)
 		nvme_disable_ctrl(&ctrl->ctrl, true);
 
-	nvme_loop_destroy_admin_queue(ctrl);
+	nvme_loop_destroy_admin_queue(ctrl, remove);
 }
 
 static void nvme_loop_delete_ctrl_host(struct nvme_ctrl *ctrl)
 {
-	nvme_loop_shutdown_ctrl(to_loop_ctrl(ctrl));
+	nvme_loop_shutdown_ctrl(to_loop_ctrl(ctrl), true);
 }
 
 static void nvme_loop_delete_ctrl(struct nvmet_ctrl *nctrl)
@@ -453,7 +457,7 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 	int ret;
 
 	nvme_stop_ctrl(&ctrl->ctrl);
-	nvme_loop_shutdown_ctrl(ctrl);
+	nvme_loop_shutdown_ctrl(ctrl, false);
 
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING)) {
 		enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
@@ -465,7 +469,7 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 		return;
 	}
 
-	ret = nvme_loop_configure_admin_queue(ctrl);
+	ret = nvme_loop_configure_admin_queue(ctrl, false);
 	if (ret)
 		goto out_disable;
 
@@ -492,7 +496,7 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 out_destroy_admin:
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
-	nvme_loop_destroy_admin_queue(ctrl);
+	nvme_loop_destroy_admin_queue(ctrl, true);
 out_disable:
 	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
 	nvme_uninit_ctrl(&ctrl->ctrl);
@@ -594,7 +598,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	if (!ctrl->queues)
 		goto out_uninit_ctrl;
 
-	ret = nvme_loop_configure_admin_queue(ctrl);
+	ret = nvme_loop_configure_admin_queue(ctrl, true);
 	if (ret)
 		goto out_free_queues;
 
@@ -632,7 +636,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 out_remove_admin_queue:
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
-	nvme_loop_destroy_admin_queue(ctrl);
+	nvme_loop_destroy_admin_queue(ctrl, true);
 out_free_queues:
 	kfree(ctrl->queues);
 out_uninit_ctrl:
-- 
2.53.0


