Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FEE8C35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:40:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9BC820674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="lEOat+my";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rtIad2vu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9BC820674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=lSqFqwz7pafTU/eeJ1SXn4POS+PqlL8F73FdUMNKKyY=; b=lEOat+myA9ET8yY1xAFwiVLFmU
	NeDvPUpcjjrz6z9IazVBYtzIal6S112n17tqWqAlCBooc0AC3gmWJSWDpIVcI/eS3/d0LeVPmbw+O
	YLmaAwfHeWf8DTug5ZA5RpYiwsrqs8HT/FyYvBsphBxdddUkigDRB1nId++4gQlhoYg3XIxSiqdJI
	iF1L6jI/RxHTLeXxFjcmw+nWEl0XJwARW2JDBC5Qv1l46MTyUwVUfCy/2Q7dSoZYhrCpThWSaLngo
	pM6buryi0MZTcoczWPuJakCzWv8IpXiPmbl+ozm7G2FPDu7EdHBgSpiLyBuWpyU1X2hLiXXK875TS
	Ppw2Pbgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPbO-0006Xj-6b; Wed, 05 Feb 2020 18:40:42 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZ3-0003bR-VK
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:19 +0000
Received: by mail-wr1-x444.google.com with SMTP id t3so4000035wru.7
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GzUC1vW+bjTa7YtkPRPP6qFV/jJS/KlpU7G2uopeXCQ=;
 b=rtIad2vuRvnDnzvmnALfDUXXsSd5Euzy8aYkDsyZ++vURvyf2s7CAdORo2CNXkkb2Y
 f03sA59DbD4CqFDrSDjSf6YtcoJQRjy6yyVgvtLd4J6yAAIF/58vif5dYQ9Kr3PCb1xy
 7B7tMMHsIZDo5KUvxx/+Mmiu8QySczYyYukZ+7HULqPHt9BYazTR+lKhBxGRhbb3fsmg
 ZpJ5yyBXq3sfimI6T//3mvVPegKMbnaXRMV6pf3A3+cgDCzAqCo+puLEXclbpjKpp+lk
 n4+o8ss3fwLVgFBPgJp/jtP9V5DLtHWL21j15lE22O8yYrC16OeIlaI+3+hAVbo9E22r
 YSuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GzUC1vW+bjTa7YtkPRPP6qFV/jJS/KlpU7G2uopeXCQ=;
 b=W808FaUcj92GQXO3QwP5glithO7ICnf8oin2Gx6zDIsNwd7VSbpO2gvJJNW6qjMGpo
 umsp2svJJE/yaBZtsVvRNeWpDpwxqKb2q9YgII8f+FKHcUXD74s3runUUxQ7sZWWEIeQ
 7O7CecH21FHQCMZAJwAHEpP/vEw91QIMtyx3jXnSW+v7AIPT9niLet6vZRYmYF/c7ICs
 II+CyEs7YxM2NQfZYf56QOFZOtue87eJoqajCD9Daz6YRrUTeUGyNRh3Ph4hOfFOqmKj
 FDZ4xzrpk/OsdXlTKPXpO1HN/98/IwHRhZEWaj5UQJ+C+ulH+NKVIBlkt15DVGFy+WFq
 Zk3w==
X-Gm-Message-State: APjAAAXm4EPcYvSC/8ugX5/dqfdREImQEvuItWNC0c2Q340CxywsBMp0
 LwFd98xCncgxz6Ji+G2xpChh7COi
X-Google-Smtp-Source: APXvYqyQI0dV+H60wD7+c1TTWb+KjDmyvRsjuDfr41PfPldqXZNTDNkvfca+0pgXXzIqjSjAwD27gA==
X-Received: by 2002:adf:b7c2:: with SMTP id t2mr30112125wre.269.1580927896039; 
 Wed, 05 Feb 2020 10:38:16 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:15 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 09/29] nvme-fc: Ensure private pointers are NULL if no data
Date: Wed,  5 Feb 2020 10:37:33 -0800
Message-Id: <20200205183753.25959-10-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103818_012570_03A896EE 
X-CRM114-Status: GOOD (  13.34  )
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
Cc: James Smart <jsmart2021@gmail.com>, martin.petersen@oracle.com
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
---
 drivers/nvme/host/fc.c   | 81 ++++++++++++++++++++++++++++++------------------
 drivers/nvme/target/fc.c |  5 ++-
 2 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 2e5163600f63..1a58e3dc0399 100644
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
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
