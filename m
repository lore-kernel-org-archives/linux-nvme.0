Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4D84C433FE
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Mar 2022 11:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DGgI6GeKXIlHik68KLcJrYPG3JaX6d+bYya9Q+9wDmk=; b=hsmSl6pxhG3J94b1aQNPF7VZNJ
	2dFom1BWAnOf2saos7Jj9ckgjRfYjg4Km+k23MyOJ6OyHcYnT9Pbl8hK7Fjx++PaTZn+NLO6n4/YO
	cBfXGEjoMwMn3NLToF3agJOE6Q6LXUYOCWtftqRT6lEIeEt+e1Nh9+YpS6AAvmctrM/GAJ7P6CpHX
	3mI0aqikVZjTVAeIBTI3rtPlJSioVTtUywyF8qZeqT+EgoB3kXH+Yro+Hb/CvQePaveUS4VWtANtF
	I5BmnEGyuw9TXPxxfH2MpELdB09lItUebpY/rpyaLuPnlzyg3I0MEo5utW6jkkJ2lwjxSIb57JxyR
	b7MSoAPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nWGfN-007XUu-Ma; Mon, 21 Mar 2022 11:57:41 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nWGfE-007XPo-SM
 for linux-nvme@lists.infradead.org; Mon, 21 Mar 2022 11:57:35 +0000
Received: by mail-wm1-f43.google.com with SMTP id
 o7-20020a05600c4fc700b0038c87edc21eso2856789wmq.0
 for <linux-nvme@lists.infradead.org>; Mon, 21 Mar 2022 04:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=DGgI6GeKXIlHik68KLcJrYPG3JaX6d+bYya9Q+9wDmk=;
 b=ApE9ncq5v4I2By9hxMR9UpS4a7Ju4wOogQIa6Hclj8UE6TH0bJKu3rhaucI2le6XN8
 w0AU7s9R5Dj0uQqkuVdj1YIAEUQDQTAPT1aJkkf5gjj3wyeAFuvLPAU0meUpGhJIkXtZ
 582DCZ+45Mqp3IW6pQx69g0ie5RTAq23x3s1/teHVF/Gx7WHAHK3SIfY3n9YJ+QMT5N9
 UpO6ZigE0jwbM7YrBL7HriFykNQyOwl4y1QDQyxZgJcfj4TF8Shr1NCSAFG633m94vHL
 BqUh+Z2qt1f6e3Fkg8M2JFs9NOsmjUHpJrLxtoiyLMD6vIQcDO+8giKIG9FMNLAOXfZS
 +28Q==
X-Gm-Message-State: AOAM5319OH7VaSCrsoq2OmqZ0E2kWVElvHp4Ux63pUMfSWn3AI2QKP2z
 GaWaNue2lqlSZaw970oTPe2Y4LqRpig=
X-Google-Smtp-Source: ABdhPJwk/grnaRLVA+AwzE/csHjcBgizQ7hC+J2CrpyhmjAQ2yX8flWwMmx4nlqwrQ4RhUCbQepYEQ==
X-Received: by 2002:a05:600c:1991:b0:389:f806:68d1 with SMTP id
 t17-20020a05600c199100b00389f80668d1mr26690523wmq.72.1647863848941; 
 Mon, 21 Mar 2022 04:57:28 -0700 (PDT)
Received: from localhost.localdomain (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90]) by smtp.gmail.com with ESMTPSA id
 k7-20020a056000004700b0020402c09064sm5821007wrx.97.2022.03.21.04.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Mar 2022 04:57:28 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Cc: James Smart <james.smart@broadcom.com>,
	Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH] nvmet: use a private workqueue instead of the system workqueue
Date: Mon, 21 Mar 2022 13:57:27 +0200
Message-Id: <20220321115727.774650-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220321_045732_968526_D5384DB3 
X-CRM114-Status: GOOD (  26.10  )
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

Any attempt to flush kernel-global WQs has possibility of deadlock
so we should simply stop using them, instead introduce nvmet_wq
which is the generic nvmet workqueue for work elements that
don't explicitly require a dedicated workqueue (by the mere fact
that they are using the system_wq).

Changes were done using the following replaces:
s/schedule_work(/queue_work(nvmet_wq, /g
s/schedule_delayed_work(/queue_delayed_work(nvmet_wq, /g
s/flush_scheduled_work()/flush_workqueue(nvmet_wq)/g

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/target/admin-cmd.c     |  2 +-
 drivers/nvme/target/configfs.c      |  2 +-
 drivers/nvme/target/core.c          | 22 ++++++++++++++++------
 drivers/nvme/target/fc.c            |  8 ++++----
 drivers/nvme/target/fcloop.c        | 16 ++++++++--------
 drivers/nvme/target/io-cmd-file.c   |  6 +++---
 drivers/nvme/target/loop.c          |  4 ++--
 drivers/nvme/target/modules.builtin |  0
 drivers/nvme/target/nvmet.h         |  1 +
 drivers/nvme/target/passthru.c      |  2 +-
 drivers/nvme/target/rdma.c          | 12 ++++++------
 drivers/nvme/target/tcp.c           | 10 +++++-----
 12 files changed, 48 insertions(+), 37 deletions(-)
 create mode 100644 drivers/nvme/target/modules.builtin

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fb24746de06..c3a9df5545cf 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -984,7 +984,7 @@ void nvmet_execute_async_event(struct nvmet_req *req)
 	ctrl->async_event_cmds[ctrl->nr_async_event_cmds++] = req;
 	mutex_unlock(&ctrl->lock);
 
-	schedule_work(&ctrl->async_event_work);
+	queue_work(nvmet_wq, &ctrl->async_event_work);
 }
 
 void nvmet_execute_keep_alive(struct nvmet_req *req)
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 091a0ca16361..173583ce40d2 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -1593,7 +1593,7 @@ static void nvmet_port_release(struct config_item *item)
 	struct nvmet_port *port = to_nvmet_port(item);
 
 	/* Let inflight controllers teardown complete */
-	flush_scheduled_work();
+	flush_workqueue(nvmet_wq);
 	list_del(&port->global_entry);
 
 	kfree(port->ana_state);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 724a6d373340..18444eaf35ab 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -17,6 +17,7 @@
 
 struct workqueue_struct *buffered_io_wq;
 struct workqueue_struct *zbd_wq;
+struct workqueue_struct *nvmet_wq;
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
 static DEFINE_IDA(cntlid_ida);
 
@@ -205,7 +206,7 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	list_add_tail(&aen->entry, &ctrl->async_events);
 	mutex_unlock(&ctrl->lock);
 
-	schedule_work(&ctrl->async_event_work);
+	queue_work(nvmet_wq, &ctrl->async_event_work);
 }
 
 static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
@@ -385,7 +386,7 @@ static void nvmet_keep_alive_timer(struct work_struct *work)
 	if (reset_tbkas) {
 		pr_debug("ctrl %d reschedule traffic based keep-alive timer\n",
 			ctrl->cntlid);
-		schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+		queue_delayed_work(nvmet_wq, &ctrl->ka_work, ctrl->kato * HZ);
 		return;
 	}
 
@@ -403,7 +404,7 @@ void nvmet_start_keep_alive_timer(struct nvmet_ctrl *ctrl)
 	pr_debug("ctrl %d start keep-alive timer for %d secs\n",
 		ctrl->cntlid, ctrl->kato);
 
-	schedule_delayed_work(&ctrl->ka_work, ctrl->kato * HZ);
+	queue_delayed_work(nvmet_wq, &ctrl->ka_work, ctrl->kato * HZ);
 }
 
 void nvmet_stop_keep_alive_timer(struct nvmet_ctrl *ctrl)
@@ -1479,7 +1480,7 @@ void nvmet_ctrl_fatal_error(struct nvmet_ctrl *ctrl)
 	mutex_lock(&ctrl->lock);
 	if (!(ctrl->csts & NVME_CSTS_CFS)) {
 		ctrl->csts |= NVME_CSTS_CFS;
-		schedule_work(&ctrl->fatal_err_work);
+		queue_work(nvmet_wq, &ctrl->fatal_err_work);
 	}
 	mutex_unlock(&ctrl->lock);
 }
@@ -1621,9 +1622,15 @@ static int __init nvmet_init(void)
 		goto out_free_zbd_work_queue;
 	}
 
+	nvmet_wq = alloc_workqueue("nvmet-wq", WQ_MEM_RECLAIM, 0);
+	if (!nvmet_wq) {
+		error = -ENOMEM;
+		goto out_free_buffered_work_queue;
+	}
+
 	error = nvmet_init_discovery();
 	if (error)
-		goto out_free_work_queue;
+		goto out_free_nvmet_work_queue;
 
 	error = nvmet_init_configfs();
 	if (error)
@@ -1632,7 +1639,9 @@ static int __init nvmet_init(void)
 
 out_exit_discovery:
 	nvmet_exit_discovery();
-out_free_work_queue:
+out_free_nvmet_work_queue:
+	destroy_workqueue(nvmet_wq);
+out_free_buffered_work_queue:
 	destroy_workqueue(buffered_io_wq);
 out_free_zbd_work_queue:
 	destroy_workqueue(zbd_wq);
@@ -1644,6 +1653,7 @@ static void __exit nvmet_exit(void)
 	nvmet_exit_configfs();
 	nvmet_exit_discovery();
 	ida_destroy(&cntlid_ida);
+	destroy_workqueue(nvmet_wq);
 	destroy_workqueue(buffered_io_wq);
 	destroy_workqueue(zbd_wq);
 
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index de90001fc5c4..ab2627e17bb9 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1491,7 +1491,7 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 	list_for_each_entry_rcu(assoc, &tgtport->assoc_list, a_list) {
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
-		if (!schedule_work(&assoc->del_work))
+		if (!queue_work(nvmet_wq, &assoc->del_work))
 			/* already deleting - release local reference */
 			nvmet_fc_tgt_a_put(assoc);
 	}
@@ -1546,7 +1546,7 @@ nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
 			continue;
 		assoc->hostport->invalid = 1;
 		noassoc = false;
-		if (!schedule_work(&assoc->del_work))
+		if (!queue_work(nvmet_wq, &assoc->del_work))
 			/* already deleting - release local reference */
 			nvmet_fc_tgt_a_put(assoc);
 	}
@@ -1592,7 +1592,7 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 		nvmet_fc_tgtport_put(tgtport);
 
 		if (found_ctrl) {
-			if (!schedule_work(&assoc->del_work))
+			if (!queue_work(nvmet_wq, &assoc->del_work))
 				/* already deleting - release local reference */
 				nvmet_fc_tgt_a_put(assoc);
 			return;
@@ -2060,7 +2060,7 @@ nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
 	iod->rqstdatalen = lsreqbuf_len;
 	iod->hosthandle = hosthandle;
 
-	schedule_work(&iod->work);
+	queue_work(nvmet_wq, &iod->work);
 
 	return 0;
 }
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 54606f1872b4..5c16372f3b53 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -360,7 +360,7 @@ fcloop_h2t_ls_req(struct nvme_fc_local_port *localport,
 		spin_lock(&rport->lock);
 		list_add_tail(&rport->ls_list, &tls_req->ls_list);
 		spin_unlock(&rport->lock);
-		schedule_work(&rport->ls_work);
+		queue_work(nvmet_wq, &rport->ls_work);
 		return ret;
 	}
 
@@ -393,7 +393,7 @@ fcloop_h2t_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
 		spin_lock(&rport->lock);
 		list_add_tail(&rport->ls_list, &tls_req->ls_list);
 		spin_unlock(&rport->lock);
-		schedule_work(&rport->ls_work);
+		queue_work(nvmet_wq, &rport->ls_work);
 	}
 
 	return 0;
@@ -448,7 +448,7 @@ fcloop_t2h_ls_req(struct nvmet_fc_target_port *targetport, void *hosthandle,
 		spin_lock(&tport->lock);
 		list_add_tail(&tport->ls_list, &tls_req->ls_list);
 		spin_unlock(&tport->lock);
-		schedule_work(&tport->ls_work);
+		queue_work(nvmet_wq, &tport->ls_work);
 		return ret;
 	}
 
@@ -480,7 +480,7 @@ fcloop_t2h_xmt_ls_rsp(struct nvme_fc_local_port *localport,
 		spin_lock(&tport->lock);
 		list_add_tail(&tport->ls_list, &tls_req->ls_list);
 		spin_unlock(&tport->lock);
-		schedule_work(&tport->ls_work);
+		queue_work(nvmet_wq, &tport->ls_work);
 	}
 
 	return 0;
@@ -520,7 +520,7 @@ fcloop_tgt_discovery_evt(struct nvmet_fc_target_port *tgtport)
 	tgt_rscn->tport = tgtport->private;
 	INIT_WORK(&tgt_rscn->work, fcloop_tgt_rscn_work);
 
-	schedule_work(&tgt_rscn->work);
+	queue_work(nvmet_wq, &tgt_rscn->work);
 }
 
 static void
@@ -739,7 +739,7 @@ fcloop_fcp_req(struct nvme_fc_local_port *localport,
 	INIT_WORK(&tfcp_req->tio_done_work, fcloop_tgt_fcprqst_done_work);
 	kref_init(&tfcp_req->ref);
 
-	schedule_work(&tfcp_req->fcp_rcv_work);
+	queue_work(nvmet_wq, &tfcp_req->fcp_rcv_work);
 
 	return 0;
 }
@@ -921,7 +921,7 @@ fcloop_fcp_req_release(struct nvmet_fc_target_port *tgtport,
 {
 	struct fcloop_fcpreq *tfcp_req = tgt_fcp_req_to_fcpreq(tgt_fcpreq);
 
-	schedule_work(&tfcp_req->tio_done_work);
+	queue_work(nvmet_wq, &tfcp_req->tio_done_work);
 }
 
 static void
@@ -976,7 +976,7 @@ fcloop_fcp_abort(struct nvme_fc_local_port *localport,
 
 	if (abortio)
 		/* leave the reference while the work item is scheduled */
-		WARN_ON(!schedule_work(&tfcp_req->abort_rcv_work));
+		WARN_ON(!queue_work(nvmet_wq, &tfcp_req->abort_rcv_work));
 	else  {
 		/*
 		 * as the io has already had the done callback made,
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 6485dc8eb974..f3d58abf11e0 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -283,7 +283,7 @@ static void nvmet_file_execute_flush(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
 	INIT_WORK(&req->f.work, nvmet_file_flush_work);
-	schedule_work(&req->f.work);
+	queue_work(nvmet_wq, &req->f.work);
 }
 
 static void nvmet_file_execute_discard(struct nvmet_req *req)
@@ -343,7 +343,7 @@ static void nvmet_file_execute_dsm(struct nvmet_req *req)
 	if (!nvmet_check_data_len_lte(req, nvmet_dsm_len(req)))
 		return;
 	INIT_WORK(&req->f.work, nvmet_file_dsm_work);
-	schedule_work(&req->f.work);
+	queue_work(nvmet_wq, &req->f.work);
 }
 
 static void nvmet_file_write_zeroes_work(struct work_struct *w)
@@ -373,7 +373,7 @@ static void nvmet_file_execute_write_zeroes(struct nvmet_req *req)
 	if (!nvmet_check_transfer_len(req, 0))
 		return;
 	INIT_WORK(&req->f.work, nvmet_file_write_zeroes_work);
-	schedule_work(&req->f.work);
+	queue_work(nvmet_wq, &req->f.work);
 }
 
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 23f9d6f88804..59024af2da2e 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -166,7 +166,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		iod->req.transfer_len = blk_rq_payload_bytes(req);
 	}
 
-	schedule_work(&iod->work);
+	queue_work(nvmet_wq, &iod->work);
 	return BLK_STS_OK;
 }
 
@@ -187,7 +187,7 @@ static void nvme_loop_submit_async_event(struct nvme_ctrl *arg)
 		return;
 	}
 
-	schedule_work(&iod->work);
+	queue_work(nvmet_wq, &iod->work);
 }
 
 static int nvme_loop_init_iod(struct nvme_loop_ctrl *ctrl,
diff --git a/drivers/nvme/target/modules.builtin b/drivers/nvme/target/modules.builtin
new file mode 100644
index 000000000000..e69de29bb2d1
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 69637bf8f8e1..57d130d8a5bd 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -366,6 +366,7 @@ struct nvmet_req {
 
 extern struct workqueue_struct *buffered_io_wq;
 extern struct workqueue_struct *zbd_wq;
+extern struct workqueue_struct *nvmet_wq;
 
 static inline void nvmet_set_result(struct nvmet_req *req, u32 result)
 {
diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index a810bf569fff..e350b6d5b0ed 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -282,7 +282,7 @@ static void nvmet_passthru_execute_cmd(struct nvmet_req *req)
 	if (req->p.use_workqueue || effects) {
 		INIT_WORK(&req->p.work, nvmet_passthru_execute_cmd_work);
 		req->p.rq = rq;
-		schedule_work(&req->p.work);
+		queue_work(nvmet_wq, &req->p.work);
 	} else {
 		rq->end_io_data = req;
 		blk_execute_rq_nowait(rq, false, nvmet_passthru_req_done);
diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 2446d0918a41..2fab0b219b25 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1584,7 +1584,7 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id *cm_id,
 
 	if (queue->host_qid == 0) {
 		/* Let inflight controller teardown complete */
-		flush_scheduled_work();
+		flush_workqueue(nvmet_wq);
 	}
 
 	ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
@@ -1669,7 +1669,7 @@ static void __nvmet_rdma_queue_disconnect(struct nvmet_rdma_queue *queue)
 
 	if (disconnect) {
 		rdma_disconnect(queue->cm_id);
-		schedule_work(&queue->release_work);
+		queue_work(nvmet_wq, &queue->release_work);
 	}
 }
 
@@ -1699,7 +1699,7 @@ static void nvmet_rdma_queue_connect_fail(struct rdma_cm_id *cm_id,
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 
 	pr_err("failed to connect queue %d\n", queue->idx);
-	schedule_work(&queue->release_work);
+	queue_work(nvmet_wq, &queue->release_work);
 }
 
 /**
@@ -1773,7 +1773,7 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		if (!queue) {
 			struct nvmet_rdma_port *port = cm_id->context;
 
-			schedule_delayed_work(&port->repair_work, 0);
+			queue_delayed_work(nvmet_wq, &port->repair_work, 0);
 			break;
 		}
 		fallthrough;
@@ -1903,7 +1903,7 @@ static void nvmet_rdma_repair_port_work(struct work_struct *w)
 	nvmet_rdma_disable_port(port);
 	ret = nvmet_rdma_enable_port(port);
 	if (ret)
-		schedule_delayed_work(&port->repair_work, 5 * HZ);
+		queue_delayed_work(nvmet_wq, &port->repair_work, 5 * HZ);
 }
 
 static int nvmet_rdma_add_port(struct nvmet_port *nport)
@@ -2053,7 +2053,7 @@ static void nvmet_rdma_remove_one(struct ib_device *ib_device, void *client_data
 	}
 	mutex_unlock(&nvmet_rdma_queue_mutex);
 
-	flush_scheduled_work();
+	flush_workqueue(nvmet_wq);
 }
 
 static struct ib_client nvmet_rdma_ib_client = {
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 83ca577f72be..2793554e622e 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1269,7 +1269,7 @@ static void nvmet_tcp_schedule_release_queue(struct nvmet_tcp_queue *queue)
 	spin_lock(&queue->state_lock);
 	if (queue->state != NVMET_TCP_Q_DISCONNECTING) {
 		queue->state = NVMET_TCP_Q_DISCONNECTING;
-		schedule_work(&queue->release_work);
+		queue_work(nvmet_wq, &queue->release_work);
 	}
 	spin_unlock(&queue->state_lock);
 }
@@ -1684,7 +1684,7 @@ static void nvmet_tcp_listen_data_ready(struct sock *sk)
 		goto out;
 
 	if (sk->sk_state == TCP_LISTEN)
-		schedule_work(&port->accept_work);
+		queue_work(nvmet_wq, &port->accept_work);
 out:
 	read_unlock_bh(&sk->sk_callback_lock);
 }
@@ -1815,7 +1815,7 @@ static u16 nvmet_tcp_install_queue(struct nvmet_sq *sq)
 
 	if (sq->qid == 0) {
 		/* Let inflight controller teardown complete */
-		flush_scheduled_work();
+		flush_workqueue(nvmet_wq);
 	}
 
 	queue->nr_cmds = sq->size * 2;
@@ -1876,12 +1876,12 @@ static void __exit nvmet_tcp_exit(void)
 
 	nvmet_unregister_transport(&nvmet_tcp_ops);
 
-	flush_scheduled_work();
+	flush_workqueue(nvmet_wq);
 	mutex_lock(&nvmet_tcp_queue_mutex);
 	list_for_each_entry(queue, &nvmet_tcp_queue_list, queue_list)
 		kernel_sock_shutdown(queue->sock, SHUT_RDWR);
 	mutex_unlock(&nvmet_tcp_queue_mutex);
-	flush_scheduled_work();
+	flush_workqueue(nvmet_wq);
 
 	destroy_workqueue(nvmet_tcp_wq);
 }
-- 
2.30.2


