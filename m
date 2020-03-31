Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B78BAC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:52:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70F8A206CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EA/qNzVI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SIXTiOl5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70F8A206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=5f2lMS0Wi8ZeSh+XGVmNtWmjlmrwF+XizIlYyr7i/dE=; b=EA/qNzVIQ014NGaDnIliajP+PA
	pt3d7Vhs0KpOBVpvMw0jrxKoGjtSYdqcWo6B9WracVv5RAdnIWBGYwgCUkhhsM9hXdli5gBOHBfwM
	VPYa1URjkvH8tbVhWxQuIgjlG35x2HHtAoMcr6ynd44VqmTNOKvyQLncAIhJAcYtuXaJN1desdm/Y
	2wFQm4M8l9TXElM9SomXVzQgZWNh5stsnhEp0RYZTIqzV8Edu11mfBtGAHFq4luiCjANQaAlDhKUF
	16gkx2O87GGi3EFk5LvbglKnMsqU8G8KVd07o6Y9eZ2sxWOGZP1UvHuCrm8xc/nMn+L3E8MUapWEN
	70Y6+ZxA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJK7N-0005dM-62; Tue, 31 Mar 2020 16:52:01 +0000
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK5t-0004TJ-Oa
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:50:31 +0000
Received: by mail-wr1-x443.google.com with SMTP id u10so26901336wro.7
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ZOxCm7lXq1NUk8hGjYfn5tR2cnOG5hOmBYSCGq9S8lo=;
 b=SIXTiOl52J51xHwN9gBnZ3t3/yAE2uRasAcnqqJ/cw7uWSxaKbdL1BdXzQrhUSl4uC
 Kv+u6jVWYUm6qDWljaKHg2zaPNezkzBBAry+p71vUdqO2Us6dkTvXymEUmeoR65c3c+p
 CXGXL/5TLf9NcMgbFKt+Rb8o9GE7H6iySjqpKSHPHdHKKBpcVf0KN8jRvTLKcDbMHhBu
 7ogh91YtaVIDcXkDreWn93/f9S13+238pcRbwRiUBfxPO0HYt0tJxtiCcaeCfmm0MFUL
 dmZgrnrnlKVWetajqWcinRKbM82H27+eikDO80yJNlPJsx3WNLaVSmcV+aOxiupKYlaZ
 9VyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ZOxCm7lXq1NUk8hGjYfn5tR2cnOG5hOmBYSCGq9S8lo=;
 b=C9kqh+H5TgeS6BqlbJfNL1vbFpK8w7hbFSze/rzJKRmQ6B2m56jD6F0mG0suPP6Xbn
 OV2cuDDCHUROfv65CJE/gdEEyioNYAVUZjDLo7Vyzo/6xzEoooaQeoB1MCF+LXrZwOkK
 WUhmpxyb+VqqEPE9gyW6z9U4O39nM1Vc8PUBEQ29rW8DkoXTcB+ibeOBjYE69K82T9t8
 +IhFHWIqLeqdmFWpWU5tZ5X3lgvMbBOKprKc0fD5KmJhGwTx/MB+BGeHWhyfPh8/Y83q
 nhliMWF9wcke9GI9RayNbsCu/IuK4JInr413nolBB0u/5hy5U0eKGooKnrOsN546nNSl
 BKnQ==
X-Gm-Message-State: ANhLgQ2WVebb8M9F9FzZoyjF1b5a77JZ/fNXMLP+wV+EnSABh1UB1WWp
 2Ik9N5xqLY+/fH+YZZDOznROIUWJ
X-Google-Smtp-Source: ADFU+vvRp+w9PSB2bd6L3KUH7d5f/GfvMq7muOU/DYiy1f+MVxo9LqE5C/wk9npZk+IoMfLDa3/yNA==
X-Received: by 2002:adf:e60c:: with SMTP id p12mr9644145wrm.219.1585673427706; 
 Tue, 31 Mar 2020 09:50:27 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.50.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:50:27 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 05/26] nvme-fc: Ensure private pointers are NULL if no data
Date: Tue, 31 Mar 2020 09:49:50 -0700
Message-Id: <20200331165011.15819-6-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095029_832243_21407470 
X-CRM114-Status: GOOD (  13.96  )
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
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Ensure that when allocations are done, and the lldd options indicate
no private data is needed, that private pointers will be set to NULL
(catches driver error that forgot to set private data size).

Slightly reorg the allocations so that private data follows allocations
for LS request/response buffers. Ensures better alignments for the buffers
as well as the private pointer.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
---
 drivers/nvme/host/fc.c   | 81 ++++++++++++++++++++++++++++++------------------
 drivers/nvme/target/fc.c |  5 ++-
 2 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index bfbd1c2c1638..8281e5dae93b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -396,7 +396,10 @@ nvme_fc_register_localport(struct nvme_fc_port_info *pinfo,
 	newrec->ops = template;
 	newrec->dev = dev;
 	ida_init(&newrec->endp_cnt);
-	newrec->localport.private = &newrec[1];
+	if (template->local_priv_sz)
+		newrec->localport.private = &newrec[1];
+	else
+		newrec->localport.private = NULL;
 	newrec->localport.node_name = pinfo->node_name;
 	newrec->localport.port_name = pinfo->port_name;
 	newrec->localport.port_role = pinfo->port_role;
@@ -705,7 +708,10 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 	newrec->remoteport.localport = &lport->localport;
 	newrec->dev = lport->dev;
 	newrec->lport = lport;
-	newrec->remoteport.private = &newrec[1];
+	if (lport->ops->remote_priv_sz)
+		newrec->remoteport.private = &newrec[1];
+	else
+		newrec->remoteport.private = NULL;
 	newrec->remoteport.port_role = pinfo->port_role;
 	newrec->remoteport.node_name = pinfo->node_name;
 	newrec->remoteport.port_name = pinfo->port_name;
@@ -1153,18 +1159,23 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
 	int ret, fcret = 0;
 
 	lsop = kzalloc((sizeof(*lsop) +
-			 ctrl->lport->ops->lsrqst_priv_sz +
-			 sizeof(*assoc_rqst) + sizeof(*assoc_acc)), GFP_KERNEL);
+			 sizeof(*assoc_rqst) + sizeof(*assoc_acc) +
+			 ctrl->lport->ops->lsrqst_priv_sz), GFP_KERNEL);
 	if (!lsop) {
+		dev_info(ctrl->ctrl.device,
+			"NVME-FC{%d}: send Create Association failed: ENOMEM\n",
+			ctrl->cnum);
 		ret = -ENOMEM;
 		goto out_no_memory;
 	}
-	lsreq = &lsop->ls_req;
 
-	lsreq->private = (void *)&lsop[1];
-	assoc_rqst = (struct fcnvme_ls_cr_assoc_rqst *)
-			(lsreq->private + ctrl->lport->ops->lsrqst_priv_sz);
+	assoc_rqst = (struct fcnvme_ls_cr_assoc_rqst *)&lsop[1];
 	assoc_acc = (struct fcnvme_ls_cr_assoc_acc *)&assoc_rqst[1];
+	lsreq = &lsop->ls_req;
+	if (ctrl->lport->ops->lsrqst_priv_sz)
+		lsreq->private = &assoc_acc[1];
+	else
+		lsreq->private = NULL;
 
 	assoc_rqst->w0.ls_cmd = FCNVME_LS_CREATE_ASSOCIATION;
 	assoc_rqst->desc_list_len =
@@ -1262,18 +1273,23 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	int ret, fcret = 0;
 
 	lsop = kzalloc((sizeof(*lsop) +
-			 ctrl->lport->ops->lsrqst_priv_sz +
-			 sizeof(*conn_rqst) + sizeof(*conn_acc)), GFP_KERNEL);
+			 sizeof(*conn_rqst) + sizeof(*conn_acc) +
+			 ctrl->lport->ops->lsrqst_priv_sz), GFP_KERNEL);
 	if (!lsop) {
+		dev_info(ctrl->ctrl.device,
+			"NVME-FC{%d}: send Create Connection failed: ENOMEM\n",
+			ctrl->cnum);
 		ret = -ENOMEM;
 		goto out_no_memory;
 	}
-	lsreq = &lsop->ls_req;
 
-	lsreq->private = (void *)&lsop[1];
-	conn_rqst = (struct fcnvme_ls_cr_conn_rqst *)
-			(lsreq->private + ctrl->lport->ops->lsrqst_priv_sz);
+	conn_rqst = (struct fcnvme_ls_cr_conn_rqst *)&lsop[1];
 	conn_acc = (struct fcnvme_ls_cr_conn_acc *)&conn_rqst[1];
+	lsreq = &lsop->ls_req;
+	if (ctrl->lport->ops->lsrqst_priv_sz)
+		lsreq->private = (void *)&conn_acc[1];
+	else
+		lsreq->private = NULL;
 
 	conn_rqst->w0.ls_cmd = FCNVME_LS_CREATE_CONNECTION;
 	conn_rqst->desc_list_len = cpu_to_be32(
@@ -1387,19 +1403,23 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
 	int ret;
 
 	lsop = kzalloc((sizeof(*lsop) +
-			 ctrl->lport->ops->lsrqst_priv_sz +
-			 sizeof(*discon_rqst) + sizeof(*discon_acc)),
-			GFP_KERNEL);
-	if (!lsop)
-		/* couldn't sent it... too bad */
+			sizeof(*discon_rqst) + sizeof(*discon_acc) +
+			ctrl->lport->ops->lsrqst_priv_sz), GFP_KERNEL);
+	if (!lsop) {
+		dev_info(ctrl->ctrl.device,
+			"NVME-FC{%d}: send Disconnect Association "
+			"failed: ENOMEM\n",
+			ctrl->cnum);
 		return;
+	}
 
-	lsreq = &lsop->ls_req;
-
-	lsreq->private = (void *)&lsop[1];
-	discon_rqst = (struct fcnvme_ls_disconnect_assoc_rqst *)
-			(lsreq->private + ctrl->lport->ops->lsrqst_priv_sz);
+	discon_rqst = (struct fcnvme_ls_disconnect_assoc_rqst *)&lsop[1];
 	discon_acc = (struct fcnvme_ls_disconnect_assoc_acc *)&discon_rqst[1];
+	lsreq = &lsop->ls_req;
+	if (ctrl->lport->ops->lsrqst_priv_sz)
+		lsreq->private = (void *)&discon_acc[1];
+	else
+		lsreq->private = NULL;
 
 	discon_rqst->w0.ls_cmd = FCNVME_LS_DISCONNECT_ASSOC;
 	discon_rqst->desc_list_len = cpu_to_be32(
@@ -1785,15 +1805,17 @@ nvme_fc_init_aen_ops(struct nvme_fc_ctrl *ctrl)
 	struct nvme_fc_fcp_op *aen_op;
 	struct nvme_fc_cmd_iu *cmdiu;
 	struct nvme_command *sqe;
-	void *private;
+	void *private = NULL;
 	int i, ret;
 
 	aen_op = ctrl->aen_ops;
 	for (i = 0; i < NVME_NR_AEN_COMMANDS; i++, aen_op++) {
-		private = kzalloc(ctrl->lport->ops->fcprqst_priv_sz,
+		if (ctrl->lport->ops->fcprqst_priv_sz) {
+			private = kzalloc(ctrl->lport->ops->fcprqst_priv_sz,
 						GFP_KERNEL);
-		if (!private)
-			return -ENOMEM;
+			if (!private)
+				return -ENOMEM;
+		}
 
 		cmdiu = &aen_op->cmd_iu;
 		sqe = &cmdiu->sqe;
@@ -1824,9 +1846,6 @@ nvme_fc_term_aen_ops(struct nvme_fc_ctrl *ctrl)
 
 	aen_op = ctrl->aen_ops;
 	for (i = 0; i < NVME_NR_AEN_COMMANDS; i++, aen_op++) {
-		if (!aen_op->fcp_req.private)
-			continue;
-
 		__nvme_fc_exit_request(ctrl, aen_op);
 
 		kfree(aen_op->fcp_req.private);
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 66de6bd8f4fd..66a60a218994 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1047,7 +1047,10 @@ nvmet_fc_register_targetport(struct nvmet_fc_port_info *pinfo,
 
 	newrec->fc_target_port.node_name = pinfo->node_name;
 	newrec->fc_target_port.port_name = pinfo->port_name;
-	newrec->fc_target_port.private = &newrec[1];
+	if (template->target_priv_sz)
+		newrec->fc_target_port.private = &newrec[1];
+	else
+		newrec->fc_target_port.private = NULL;
 	newrec->fc_target_port.port_id = pinfo->port_id;
 	newrec->fc_target_port.port_num = idx;
 	INIT_LIST_HEAD(&newrec->tgt_list);
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
