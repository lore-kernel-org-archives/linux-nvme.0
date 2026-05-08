Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CF97CD3436
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2026 13:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RurKlSir945mU+Ex7CVEjOGMztFnSTUPcwSFDjNCpkg=; b=XQ87daHzl+L7n++FgTZ8m5oKdN
	aTERYatYxB76SVGEfKRuD84x+YyGZlKNTLDsL+4SqnPEylFZ6Lh0JmXFNN9ZM13lXx4qbkbIXfXzF
	Cc8Mm6GsAbm98iMN8skQ9w9/lCWqLHJ2E3DFE7IW6ipZXgZzL+tlXDYVUtqMC7Ma2iTyZutIKk1Jv
	mC9bp8zPWZodvQiLQvcwGWwJVdWxdUoZ9t8AVBM4M5j9S/7tuq8CfuI3QMJy/yFp1ldqsw0goKtlh
	sQNHIMZJ2NRRNL/HUVaeUKLNmFtkebLK75qlzVEOpzB3l5j8rrImWmJVwzBj7MIH8MoVesob2N1GF
	5cYBqMLw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLLLV-00000006Ytr-11rL;
	Fri, 08 May 2026 13:34:25 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLLLR-00000006YqT-3McE
	for linux-nvme@lists.infradead.org;
	Fri, 08 May 2026 13:34:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778247261;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RurKlSir945mU+Ex7CVEjOGMztFnSTUPcwSFDjNCpkg=;
	b=euy+24mUuZhPpKjK5neunA/FfXLVBirQc3xdwysDgkUwH9adCqrQgj/CnAYzr0MsI+K5v0
	o2hz70zTT2YdBrfrlvwqplGwVmBmGIfrGB9tSnp+rtdQKMcfcI2EkrptAdtLTUJipX9Tyx
	N36+6gNAqm/DiJI2kEaaO5is01hOcvk=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-D63Nq2IYPLSMXuAtz6dvWg-1; Fri,
 08 May 2026 09:34:17 -0400
X-MC-Unique: D63Nq2IYPLSMXuAtz6dvWg-1
X-Mimecast-MFC-AGG-ID: D63Nq2IYPLSMXuAtz6dvWg_1778247252
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5433219560A1;
	Fri,  8 May 2026 13:34:12 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.105])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 22231195394A;
	Fri,  8 May 2026 13:34:08 +0000 (UTC)
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
Subject: [PATCH V4 8/9] nvmet-loop: do not alloc admin tag set during reset
Date: Fri,  8 May 2026 15:33:34 +0200
Message-ID: <20260508133335.98612-9-mlombard@redhat.com>
In-Reply-To: <20260508133335.98612-1-mlombard@redhat.com>
References: <20260508133335.98612-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ErLktQlU3bTXFQNfGSYVY1BtTptVDCNXUZs304p4TB4_1778247252
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260508_063422_154505_D4A65082 
X-CRM114-Status: GOOD (  14.02  )
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

Decouple the admin tag set lifecycle from the admin queue
configuration and destruction paths, which are executed during resets;
Specifically:

* Move nvme_alloc_admin_tag_set() into nvme_loop_create_ctrl() so it
  is only allocated once during the initial controller creation.

* Defer the destruction of the admin tag set to
  nvme_loop_delete_ctrl_host() and the terminal error-handling
  paths of nvme_loop_reset_ctrl_work() and
  nvme_loop_create_ctrl().

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/nvme/target/loop.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index d98d0cdc5d6f..070d16068e6b 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -274,7 +274,6 @@ static void nvme_loop_destroy_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
 	nvmet_cq_put(&ctrl->queues[0].nvme_cq);
-	nvme_remove_admin_tag_set(&ctrl->ctrl);
 }
 
 static void nvme_loop_free_ctrl(struct nvme_ctrl *nctrl)
@@ -375,25 +374,18 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	}
 	ctrl->ctrl.queue_count = 1;
 
-	error = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
-			&nvme_loop_admin_mq_ops,
-			sizeof(struct nvme_loop_iod) +
-			NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
-	if (error)
-		goto out_free_sq;
-
 	/* reset stopped state for the fresh admin queue */
 	clear_bit(NVME_CTRL_ADMIN_Q_STOPPED, &ctrl->ctrl.flags);
 
 	error = nvmf_connect_admin_queue(&ctrl->ctrl);
 	if (error)
-		goto out_cleanup_tagset;
+		goto out_free_sq;
 
 	set_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
 
 	error = nvme_enable_ctrl(&ctrl->ctrl);
 	if (error)
-		goto out_cleanup_tagset;
+		goto out_free_sq;
 
 	ctrl->ctrl.max_hw_sectors =
 		(NVME_LOOP_MAX_SEGMENTS - 1) << PAGE_SECTORS_SHIFT;
@@ -402,14 +394,12 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 	error = nvme_init_ctrl_finish(&ctrl->ctrl, false);
 	if (error)
-		goto out_cleanup_tagset;
+		goto out_free_sq;
 
 	return 0;
 
-out_cleanup_tagset:
-	clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
-	nvme_remove_admin_tag_set(&ctrl->ctrl);
 out_free_sq:
+	clear_bit(NVME_LOOP_Q_LIVE, &ctrl->queues[0].flags);
 	nvmet_sq_destroy(&ctrl->queues[0].nvme_sq);
 	nvmet_cq_put(&ctrl->queues[0].nvme_cq);
 	return error;
@@ -432,6 +422,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 static void nvme_loop_delete_ctrl_host(struct nvme_ctrl *ctrl)
 {
 	nvme_loop_shutdown_ctrl(to_loop_ctrl(ctrl));
+	nvme_remove_admin_tag_set(ctrl);
 }
 
 static void nvme_loop_delete_ctrl(struct nvmet_ctrl *nctrl)
@@ -494,6 +485,7 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
 out_disable:
+	nvme_remove_admin_tag_set(&ctrl->ctrl);
 	dev_warn(ctrl->ctrl.device, "Removing after reset failure\n");
 	nvme_uninit_ctrl(&ctrl->ctrl);
 }
@@ -594,10 +586,17 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	if (!ctrl->queues)
 		goto out_uninit_ctrl;
 
-	ret = nvme_loop_configure_admin_queue(ctrl);
+	ret = nvme_alloc_admin_tag_set(&ctrl->ctrl, &ctrl->admin_tag_set,
+			&nvme_loop_admin_mq_ops,
+			sizeof(struct nvme_loop_iod) +
+			NVME_INLINE_SG_CNT * sizeof(struct scatterlist));
 	if (ret)
 		goto out_free_queues;
 
+	ret = nvme_loop_configure_admin_queue(ctrl);
+	if (ret)
+		goto out_remove_admin_tagset;
+
 	if (opts->queue_size > ctrl->ctrl.maxcmd) {
 		/* warn if maxcmd is lower than queue_size */
 		dev_warn(ctrl->ctrl.device,
@@ -633,6 +632,8 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	nvme_quiesce_admin_queue(&ctrl->ctrl);
 	nvme_cancel_admin_tagset(&ctrl->ctrl);
 	nvme_loop_destroy_admin_queue(ctrl);
+out_remove_admin_tagset:
+	nvme_remove_admin_tag_set(&ctrl->ctrl);
 out_free_queues:
 	kfree(ctrl->queues);
 out_uninit_ctrl:
-- 
2.54.0


