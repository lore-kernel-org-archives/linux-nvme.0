Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC5BC5CFEB
	for <linux-nvme@archiver.kernel.org>; Thu, 13 Aug 2026 13:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0MyroQKa4OYjjtJkWeboPxN+7S9aSxzC1Bl91HDV7zQ=; b=VFjyChnVeb6zhO77WRqr2HpG7/
	RKriRqfL1/+taTekuBlvz/R1DnGSmkd3z79HzLOIdF/R8qLwet6Z0CurSbYq1gDgLpoH/2pNdvkDv
	YLRdQx8v2wnIj6voAMDoB11aD4fF2sc6/ZDiNWq+qx5EW7ZfG1blBzOwRNSz+1kTOHujgQkNj6cQ2
	mgw2E1tYTO4/kUdRY6MoUje/yJasCEHfBBbdR5gaL3bKEB6LBT4Clk33XFE75acNO5UuLoZMsp/+i
	+OSRAlvrZ9iXzb3TtvnhI4b3xaOzt0zrPuamAVQow+dpwzIoR/BVgL4zf2vlaw3fHvPPJB4pje3fi
	+jDjduBA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuVKs-00000000jBH-1bsp;
	Thu, 13 Aug 2026 13:19:06 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wuVKq-00000000jAo-0O65
	for linux-nvme@lists.infradead.org;
	Thu, 13 Aug 2026 13:19:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786627142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=0MyroQKa4OYjjtJkWeboPxN+7S9aSxzC1Bl91HDV7zQ=;
	b=OWq/edMIqkAa+W0NsMT02t8Ct42qs1elsZq3j0VLIRPXbVwJWSr6JB0vqth9GRwQeodS5Q
	5tYMMwf+4tUwETPtEW9n/uO54Vdshd2yrPBMn9PtNbng8ULPeweCOOy3CF4Mo4GbdnrG2c
	gHnNWr/bnI2Ju9MBKc5OGaVF6uXfrH4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-6g1-KIWLNb-GRv7scrkamg-1; Thu,
 13 Aug 2026 09:18:56 -0400
X-MC-Unique: 6g1-KIWLNb-GRv7scrkamg-1
X-Mimecast-MFC-AGG-ID: 6g1-KIWLNb-GRv7scrkamg_1786627134
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3115119560B4;
	Thu, 13 Aug 2026 13:18:54 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.redhat.corp (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E749618005BC;
	Thu, 13 Aug 2026 13:18:51 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hare@suse.de,
	hch@lst.de,
	dwagner@suse.de,
	linux-nvme@lists.infradead.org,
	mlombard@arkamax.eu
Subject: [PATCH V2] nvmet: fix max_qid race between configfs and controller allocation
Date: Thu, 13 Aug 2026 15:18:50 +0200
Message-ID: <20260813131850.79899-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xNEcWjViBmVh6mk-uTlcMVgxAKytGq4e1EoQw334Q-U_1786627134
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260813_061904_235547_23B39DFA 
X-CRM114-Status: GOOD (  19.95  )
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

The function nvmet_subsys_attr_qid_max_store() can race against
nvmet_alloc_ctrl() when a subsystem's max_qid limit is modified.

Suppose max_qid is currently 64. If nvmet_alloc_ctrl() executes:
ctrl->sqs = kzalloc_objs(struct nvmet_sq *, subsys->max_qid + 1);
and at this exact point, a userspace process changes max_qid to 128,
nvmet_subsys_attr_qid_max_store() will set the new max_qid value. It
attempts to delete active controllers to force a reconnect, but the
new controller won't be deleted because it hasn't been added to the
subsys->ctrls list yet.

nvmet_alloc_ctrl() then proceeds and adds the new controller to the
subsys->ctrls list. Later, when nvmet_install_queue() is called, it
will see max_qid set to 128, but the memory allocated for sqs is only
sized for 64 entries. This results in a KASAN out-of-bounds warning
and potential memory corruptions.

Fix this by protecting the queue allocations and list insertion in
nvmet_alloc_ctrl() with down_read(&nvmet_config_sem). Because
nvmet_subsys_attr_qid_max_store() acquires down_write(&nvmet_config_sem)
to modify the attribute, this safely prevents the configfs writer from
modifying max_qid during controller creation.

Copy the max_qid from the subsystem to the controller's structure
during the allocation; ctrl->max_qid never changes as long as the
controller remains in LIVE state, so this will prevent similar race
conditions.

Fixes: 3e980f5995e0 ("nvmet: expose max queues to configfs")
Reported-by: syzbot+2626e846cd2585c9aa67@syzkaller.appspotmail.com
Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---

V2: copy the max_qid from the subsys's structure to controller's structure

 drivers/nvme/target/admin-cmd.c   |  8 ++---
 drivers/nvme/target/core.c        | 49 +++++++++++++++++--------------
 drivers/nvme/target/fabrics-cmd.c |  2 +-
 drivers/nvme/target/nvmet.h       |  6 ++++
 drivers/nvme/target/pci-epf.c     |  2 +-
 5 files changed, 39 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 01b799e92ae6..d1176b45e8f2 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -1335,7 +1335,7 @@ static u16 nvmet_set_feat_arbitration(struct nvmet_req *req)
 
 void nvmet_execute_set_features(struct nvmet_req *req)
 {
-	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
+	struct nvmet_ctrl *ctrl = nvmet_req_ctrl(req);
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
 	u16 status = 0;
@@ -1357,7 +1357,7 @@ void nvmet_execute_set_features(struct nvmet_req *req)
 			break;
 		}
 		nvmet_set_result(req,
-			(subsys->max_qid - 1) | ((subsys->max_qid - 1) << 16));
+			(ctrl->max_qid - 1) | ((ctrl->max_qid - 1) << 16));
 		break;
 	case NVME_FEAT_IRQ_COALESCE:
 		status = nvmet_set_feat_irq_coalesce(req);
@@ -1494,7 +1494,7 @@ void nvmet_get_feat_async_event(struct nvmet_req *req)
 
 void nvmet_execute_get_features(struct nvmet_req *req)
 {
-	struct nvmet_subsys *subsys = nvmet_req_subsys(req);
+	struct nvmet_ctrl *ctrl = nvmet_req_ctrl(req);
 	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
@@ -1534,7 +1534,7 @@ void nvmet_execute_get_features(struct nvmet_req *req)
 		break;
 	case NVME_FEAT_NUM_QUEUES:
 		nvmet_set_result(req,
-			(subsys->max_qid-1) | ((subsys->max_qid-1) << 16));
+			(ctrl->max_qid-1) | ((ctrl->max_qid-1) << 16));
 		break;
 	case NVME_FEAT_KATO:
 		nvmet_get_feat_kato(req);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4477c4d6b1ee..357848c8d6c1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -875,7 +875,7 @@ u16 nvmet_check_cqid(struct nvmet_ctrl *ctrl, u16 cqid, bool create)
 	if (!ctrl->cqs)
 		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
 
-	if (cqid > ctrl->subsys->max_qid)
+	if (cqid > ctrl->max_qid)
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
 
 	if ((create && ctrl->cqs[cqid]) || (!create && !ctrl->cqs[cqid]))
@@ -923,7 +923,7 @@ u16 nvmet_check_sqid(struct nvmet_ctrl *ctrl, u16 sqid,
 	if (!ctrl->sqs)
 		return NVME_SC_INTERNAL | NVME_STATUS_DNR;
 
-	if (sqid > ctrl->subsys->max_qid)
+	if (sqid > ctrl->max_qid)
 		return NVME_SC_QID_INVALID | NVME_STATUS_DNR;
 
 	if ((create && ctrl->sqs[sqid]) ||
@@ -1652,11 +1652,29 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	if (!ctrl->changed_ns_list)
 		goto out_free_ctrl;
 
-	ctrl->sqs = kzalloc_objs(struct nvmet_sq *, subsys->max_qid + 1);
+	/*
+	 * Discovery controllers may use some arbitrary high value
+	 * in order to cleanup stale discovery sessions
+	 */
+	if (nvmet_is_disc_subsys(ctrl->subsys) && !kato)
+		kato = NVMET_DISC_KATO_MS;
+
+	/* keep-alive timeout in seconds */
+	ctrl->kato = DIV_ROUND_UP(kato, 1000);
+
+	ctrl->err_counter = 0;
+	spin_lock_init(&ctrl->error_lock);
+
+	down_read(&nvmet_config_sem);
+	mutex_lock(&subsys->lock);
+
+	ctrl->max_qid = subsys->max_qid;
+
+	ctrl->sqs = kzalloc_objs(struct nvmet_sq *, ctrl->max_qid + 1);
 	if (!ctrl->sqs)
 		goto out_free_changed_ns_list;
 
-	ctrl->cqs = kzalloc_objs(struct nvmet_cq *, subsys->max_qid + 1);
+	ctrl->cqs = kzalloc_objs(struct nvmet_cq *, ctrl->max_qid + 1);
 	if (!ctrl->cqs)
 		goto out_free_sqs;
 
@@ -1669,22 +1687,6 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	}
 	ctrl->cntlid = ret;
 
-	/*
-	 * Discovery controllers may use some arbitrary high value
-	 * in order to cleanup stale discovery sessions
-	 */
-	if (nvmet_is_disc_subsys(ctrl->subsys) && !kato)
-		kato = NVMET_DISC_KATO_MS;
-
-	/* keep-alive timeout in seconds */
-	ctrl->kato = DIV_ROUND_UP(kato, 1000);
-
-	ctrl->err_counter = 0;
-	spin_lock_init(&ctrl->error_lock);
-
-	nvmet_start_keep_alive_timer(ctrl);
-
-	mutex_lock(&subsys->lock);
 	ret = nvmet_ctrl_init_pr(ctrl);
 	if (ret)
 		goto init_pr_fail;
@@ -1692,6 +1694,9 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	nvmet_setup_p2p_ns_map(ctrl, args->p2p_client);
 	nvmet_debugfs_ctrl_setup(ctrl);
 	mutex_unlock(&subsys->lock);
+	up_read(&nvmet_config_sem);
+
+	nvmet_start_keep_alive_timer(ctrl);
 
 	if (args->hostid)
 		uuid_copy(&ctrl->hostid, args->hostid);
@@ -1721,14 +1726,14 @@ struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_alloc_ctrl_args *args)
 	return ctrl;
 
 init_pr_fail:
-	mutex_unlock(&subsys->lock);
-	nvmet_stop_keep_alive_timer(ctrl);
 	ida_free(&cntlid_ida, ctrl->cntlid);
 out_free_cqs:
 	kfree(ctrl->cqs);
 out_free_sqs:
 	kfree(ctrl->sqs);
 out_free_changed_ns_list:
+	mutex_unlock(&subsys->lock);
+	up_read(&nvmet_config_sem);
 	kfree(ctrl->changed_ns_list);
 out_free_ctrl:
 	kfree(ctrl);
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 7cadd1c9e44c..42d1d1811671 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -370,7 +370,7 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 		goto out;
 	}
 
-	if (unlikely(qid > ctrl->subsys->max_qid)) {
+	if (unlikely(qid > ctrl->max_qid)) {
 		pr_warn("invalid queue id (%d)\n", qid);
 		status = NVME_SC_CONNECT_INVALID_PARAM | NVME_STATUS_DNR;
 		req->cqe->result.u32 = IPO_IATTR_CONNECT_SQE(qid);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index aaba745e3c21..ed5e9f1ce5b4 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -265,6 +265,7 @@ struct nvmet_ctrl {
 
 	uuid_t			hostid;
 	u16			cntlid;
+	u16			max_qid;
 	u32			kato;
 
 	struct nvmet_port	*port;
@@ -753,6 +754,11 @@ static inline struct nvmet_subsys *nvmet_req_subsys(struct nvmet_req *req)
 	return req->sq->ctrl->subsys;
 }
 
+static inline struct nvmet_ctrl *nvmet_req_ctrl(struct nvmet_req *req)
+{
+	return req->sq->ctrl;
+}
+
 static inline bool nvmet_is_disc_subsys(struct nvmet_subsys *subsys)
 {
     return subsys->type != NVME_NQN_NVME;
diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfec..e97e71416d27 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2077,7 +2077,7 @@ static int nvmet_pci_epf_create_ctrl(struct nvmet_pci_epf *nvme_epf,
 	}
 
 	/* Allocate our queues, up to the maximum number. */
-	ctrl->nr_queues = min(ctrl->tctrl->subsys->max_qid + 1, max_nr_queues);
+	ctrl->nr_queues = min(ctrl->tctrl->max_qid + 1, max_nr_queues);
 	ret = nvmet_pci_epf_alloc_queues(ctrl);
 	if (ret)
 		goto out_put_ctrl;
-- 
2.55.0


