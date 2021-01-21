Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEEF0C433E0
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 14:29:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D18B239EB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 14:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D18B239EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cloud.ionos.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=diDqcANrJ1LGVazK4qt/VlQVeByvvHZH7aaz6ZnUICE=; b=yMftrmaGm5qGSBOHrm916YEMSv
	MYRIshpCb3wQ7mJy7BTOWsqvqG/tThkigW/rSvuKrmwMThkxrKA8EzVcNi2F3CoswjjnuNfTIefVb
	Bvi4RJSnNTFoU6pTvCXSpD4oTpvNjob8km3r9f1EGEiXCmyUviOHGe04zjjUpgMBZajx8teAb6q1T
	UUj7DPPU6LpY9L/Ck0JxYB5T/h0S1DfrEJdVg9ntPNy0V3YcgGdD+o9eedZjcI2mxrwVGhLcrudCF
	NVvTpgkDZS7QNI7yrltYW7vGiixhDE4q4DOpuxzK7oW+M4HPGLAuLzJbNN3J8VZz+m5ih2BxiDJsg
	iqKKuntQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2axn-0007Hp-Dd; Thu, 21 Jan 2021 14:29:31 +0000
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2axj-0007GS-5H
 for linux-nvme@lists.infradead.org; Thu, 21 Jan 2021 14:29:28 +0000
Received: by mail-ed1-x52e.google.com with SMTP id f1so2663766edr.12
 for <linux-nvme@lists.infradead.org>; Thu, 21 Jan 2021 06:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.ionos.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UWqGWX0PceAd5JKq7hDiNyPJdxqISRxioeQ6fiCbynw=;
 b=PwNSrWuEUxblJJ0l2KJow3eZNDvcajwV/n1erINsxrGJuoLodnyRLMyZ8Las0GDAcG
 a9/ocI2oy2eQ2G4PGoWUNxcxpfzgrOmei4XjXOBWysVGa3Hxshtx+uNrGs3n1fn7uBU3
 27FFoqbewFQrDQKSeTeSn9Ppa3w3YwF+hohrbszEgnhGisLtwtSC7iDOkxNpE3vnZlzu
 BBTE27K/bH62QLxg7ObRIhVCuHqD1wnfJPZLP9Ti9mwkis5P+28umXp/wPeUtayEEhJ5
 8IgrYWer56Fx0YxulSruwOG1psUaMOUjv0KRI2dlsqXPUaTmUz89ili3p71ctFW26seJ
 MEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UWqGWX0PceAd5JKq7hDiNyPJdxqISRxioeQ6fiCbynw=;
 b=AYtTih+cI4OuKbXYAcHmHvQuFG4jA7WldiuMumGG6DvcLKoMpXMma31boyCkbzpucl
 q2rQle6LX4LmNvwUNXCYlL7HUMZJULga0814NFDkz8aP9CuZBa09m/0mqgBlCVAioLVk
 7Z/wy8D7KTpebwHofV0Feehh5cW8CTW5vsWr5eN3wa1aL7kI3/P+oNpkhCMccHiooRv2
 MbYB2pDUQ5New6VNrrLc3LaVGJf6A8rZn7vVg1udLElvG2sAWVFbf0TZygmrNVzjiYxC
 CT1CLk8NcDZhjoWKiTs3rPzTkE4nhDly+pSmgBwdsO+eDaVxtt5JG36idOyGKX+jLkx1
 vPEg==
X-Gm-Message-State: AOAM532x/TQ7rvMYah2CoiYIG6Gj0DhCo62b3aRcBKCzcTVYVMMfcayn
 /eStTM/c5XchYe/CK9OJa3xoGg==
X-Google-Smtp-Source: ABdhPJww2yUULgxb3Djo1XuYre5p+7XS22kgArglzSnblIXylaukCaJsYXcUlPuGAExiPc9wUPa9yg==
X-Received: by 2002:aa7:d7c8:: with SMTP id e8mr7171158eds.355.1611239365888; 
 Thu, 21 Jan 2021 06:29:25 -0800 (PST)
Received: from ls00508.pb.local ([2001:1438:4010:2540:481b:68e3:af3e:e933])
 by smtp.gmail.com with ESMTPSA id gt18sm2263684ejb.104.2021.01.21.06.29.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jan 2021 06:29:25 -0800 (PST)
From: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
To: axboe@kernel.dk
Subject: [PATCH 1/2] block: remove unnecessary argument from
 blk_execute_rq_nowait
Date: Thu, 21 Jan 2021 15:29:04 +0100
Message-Id: <20210121142905.13089-2-guoqing.jiang@cloud.ionos.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210121142905.13089-1-guoqing.jiang@cloud.ionos.com>
References: <20210121142905.13089-1-guoqing.jiang@cloud.ionos.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210121_092927_243742_F3FEA88A 
X-CRM114-Status: GOOD (  16.70  )
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
Cc: linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-mmc@vger.kernel.org, Guoqing Jiang <guoqing.jiang@cloud.ionos.com>,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, linux-ide@vger.kernel.org,
 target-devel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The 'q' is not used since commit a1ce35fa4985 ("block: remove dead
elevator code"), also update the comment of the function.

Cc: target-devel@vger.kernel.org
Cc: linux-scsi@vger.kernel.org
Cc: virtualization@lists.linux-foundation.org
Cc: linux-ide@vger.kernel.org
Cc: linux-mmc@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Cc: linux-nfs@vger.kernel.org
Signed-off-by: Guoqing Jiang <guoqing.jiang@cloud.ionos.com>
---
 block/blk-exec.c                   | 10 ++++------
 drivers/block/sx8.c                |  4 ++--
 drivers/nvme/host/core.c           |  4 ++--
 drivers/nvme/host/lightnvm.c       |  2 +-
 drivers/nvme/host/pci.c            |  4 ++--
 drivers/nvme/target/passthru.c     |  2 +-
 drivers/scsi/scsi_error.c          |  2 +-
 drivers/scsi/sg.c                  |  3 +--
 drivers/scsi/st.c                  |  2 +-
 drivers/target/target_core_pscsi.c |  3 +--
 include/linux/blkdev.h             |  2 +-
 11 files changed, 17 insertions(+), 21 deletions(-)

diff --git a/block/blk-exec.c b/block/blk-exec.c
index 85324d53d072..2e37e85456fb 100644
--- a/block/blk-exec.c
+++ b/block/blk-exec.c
@@ -31,8 +31,7 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
 }
 
 /**
- * blk_execute_rq_nowait - insert a request into queue for execution
- * @q:		queue to insert the request in
+ * blk_execute_rq_nowait - insert a request to I/O scheduler for execution
  * @bd_disk:	matching gendisk
  * @rq:		request to insert
  * @at_head:    insert request at head or tail of queue
@@ -45,9 +44,8 @@ static void blk_end_sync_rq(struct request *rq, blk_status_t error)
  * Note:
  *    This function will invoke @done directly if the queue is dead.
  */
-void blk_execute_rq_nowait(struct request_queue *q, struct gendisk *bd_disk,
-			   struct request *rq, int at_head,
-			   rq_end_io_fn *done)
+void blk_execute_rq_nowait(struct gendisk *bd_disk, struct request *rq,
+			   int at_head, rq_end_io_fn *done)
 {
 	WARN_ON(irqs_disabled());
 	WARN_ON(!blk_rq_is_passthrough(rq));
@@ -83,7 +81,7 @@ void blk_execute_rq(struct request_queue *q, struct gendisk *bd_disk,
 	unsigned long hang_check;
 
 	rq->end_io_data = &wait;
-	blk_execute_rq_nowait(q, bd_disk, rq, at_head, blk_end_sync_rq);
+	blk_execute_rq_nowait(bd_disk, rq, at_head, blk_end_sync_rq);
 
 	/* Prevent hang_check timer from firing at us during very long I/O */
 	hang_check = sysctl_hung_task_timeout_secs;
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
index 4478eb7efee0..2cdf2771f8e8 100644
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -539,7 +539,7 @@ static int carm_array_info (struct carm_host *host, unsigned int array_idx)
 	spin_unlock_irq(&host->lock);
 
 	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
-	blk_execute_rq_nowait(host->oob_q, NULL, rq, true, NULL);
+	blk_execute_rq_nowait(NULL, rq, true, NULL);
 
 	return 0;
 
@@ -578,7 +578,7 @@ static int carm_send_special (struct carm_host *host, carm_sspc_t func)
 	crq->msg_bucket = (u32) rc;
 
 	DPRINTK("blk_execute_rq_nowait, tag == %u\n", rq->tag);
-	blk_execute_rq_nowait(host->oob_q, NULL, rq, true, NULL);
+	blk_execute_rq_nowait(NULL, rq, true, NULL);
 
 	return 0;
 }
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f320273fc672..63c469edb1bc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -925,7 +925,7 @@ static void nvme_execute_rq_polled(struct request_queue *q,
 
 	rq->cmd_flags |= REQ_HIPRI;
 	rq->end_io_data = &wait;
-	blk_execute_rq_nowait(q, bd_disk, rq, at_head, nvme_end_sync_rq);
+	blk_execute_rq_nowait(bd_disk, rq, at_head, nvme_end_sync_rq);
 
 	while (!completion_done(&wait)) {
 		blk_poll(q, request_to_qc_t(rq->mq_hctx, rq), true);
@@ -1202,7 +1202,7 @@ static int nvme_keep_alive(struct nvme_ctrl *ctrl)
 	rq->timeout = ctrl->kato * HZ;
 	rq->end_io_data = ctrl;
 
-	blk_execute_rq_nowait(rq->q, NULL, rq, 0, nvme_keep_alive_end_io);
+	blk_execute_rq_nowait(NULL, rq, 0, nvme_keep_alive_end_io);
 
 	return 0;
 }
diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
index 470cef3abec3..439f2b52e985 100644
--- a/drivers/nvme/host/lightnvm.c
+++ b/drivers/nvme/host/lightnvm.c
@@ -695,7 +695,7 @@ static int nvme_nvm_submit_io(struct nvm_dev *dev, struct nvm_rq *rqd,
 
 	rq->end_io_data = rqd;
 
-	blk_execute_rq_nowait(q, NULL, rq, 0, nvme_nvm_end_io);
+	blk_execute_rq_nowait(NULL, rq, 0, nvme_nvm_end_io);
 
 	return 0;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 50d9a20568a2..6aa11067c8d0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1327,7 +1327,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	}
 
 	abort_req->end_io_data = NULL;
-	blk_execute_rq_nowait(abort_req->q, NULL, abort_req, 0, abort_endio);
+	blk_execute_rq_nowait(NULL, abort_req, 0, abort_endio);
 
 	/*
 	 * The aborted req will be completed on receiving the abort req.
@@ -2238,7 +2238,7 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	req->end_io_data = nvmeq;
 
 	init_completion(&nvmeq->delete_done);
-	blk_execute_rq_nowait(q, NULL, req, false,
+	blk_execute_rq_nowait(NULL, req, false,
 			opcode == nvme_admin_delete_cq ?
 				nvme_del_cq_end : nvme_del_queue_end);
 	return 0;
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index b9776fc8f08f..cbc88acdd233 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -275,7 +275,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 		schedule_work(&req->p.work);
 	} else {
 		rq->end_io_data = req;
-		blk_execute_rq_nowait(rq->q, ns ? ns->disk : NULL, rq, 0,
+		blk_execute_rq_nowait(ns ? ns->disk : NULL, rq, 0,
 				      nvmet_passthru_req_done);
 	}
 
diff --git a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
index f11f51e2465f..c00f06e9ecb0 100644
--- a/drivers/scsi/scsi_error.c
+++ b/drivers/scsi/scsi_error.c
@@ -2007,7 +2007,7 @@ static void scsi_eh_lock_door(struct scsi_device *sdev)
 	req->timeout = 10 * HZ;
 	rq->retries = 5;
 
-	blk_execute_rq_nowait(req->q, NULL, req, 1, eh_lock_door_done);
+	blk_execute_rq_nowait(NULL, req, 1, eh_lock_door_done);
 }
 
 /**
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index bfa8d77322d7..4383d93110f8 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -829,8 +829,7 @@ sg_common_write(Sg_fd * sfp, Sg_request * srp,
 
 	srp->rq->timeout = timeout;
 	kref_get(&sfp->f_ref); /* sg_rq_end_io() does kref_put(). */
-	blk_execute_rq_nowait(sdp->device->request_queue, sdp->disk,
-			      srp->rq, at_head, sg_rq_end_io);
+	blk_execute_rq_nowait(sdp->disk, srp->rq, at_head, sg_rq_end_io);
 	return 0;
 }
 
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
index 43f7624508a9..841ad2fc369a 100644
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -585,7 +585,7 @@ static int st_scsi_execute(struct st_request *SRpnt, const unsigned char *cmd,
 	rq->retries = retries;
 	req->end_io_data = SRpnt;
 
-	blk_execute_rq_nowait(req->q, NULL, req, 1, st_scsi_execute_end);
+	blk_execute_rq_nowait(NULL, req, 1, st_scsi_execute_end);
 	return 0;
 }
 
diff --git a/drivers/target/target_core_pscsi.c b/drivers/target/target_core_pscsi.c
index 7994f27e4527..33770e5808ce 100644
--- a/drivers/target/target_core_pscsi.c
+++ b/drivers/target/target_core_pscsi.c
@@ -1000,8 +1000,7 @@ pscsi_execute_cmd(struct se_cmd *cmd)
 		req->timeout = PS_TIMEOUT_OTHER;
 	scsi_req(req)->retries = PS_RETRY;
 
-	blk_execute_rq_nowait(pdv->pdv_sd->request_queue, NULL, req,
-			(cmd->sam_task_attr == TCM_HEAD_TAG),
+	blk_execute_rq_nowait(NULL, req, (cmd->sam_task_attr == TCM_HEAD_TAG),
 			pscsi_req_done);
 
 	return 0;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 070de09425ad..bf0ddef8aa10 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -942,7 +942,7 @@ extern int blk_rq_map_user_iov(struct request_queue *, struct request *,
 			       gfp_t);
 extern void blk_execute_rq(struct request_queue *, struct gendisk *,
 			  struct request *, int);
-extern void blk_execute_rq_nowait(struct request_queue *, struct gendisk *,
+extern void blk_execute_rq_nowait(struct gendisk *,
 				  struct request *, int, rq_end_io_fn *);
 
 /* Helper to convert REQ_OP_XXX to its string format XXX */
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
