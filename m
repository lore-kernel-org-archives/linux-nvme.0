Return-Path: <SRS0=X9H7=XW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B266C4360C
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:52:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CECB521655
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Sep 2019 21:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JObyycpI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DvgQV6dl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CECB521655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=BZiQ7gZCPv8S31re9GZmFvngV0uy6FcVRTl4ytNM77o=; b=JObyycpIbY5cBaT4np8eMsX8MM
	OcJCkzAivMB6KLEy2nAdzK0vIT4ugUc9h6Ns9OEQK7JVCqnWX/gYjrTYkIF/mKXt2vDzSeZEmB7QS
	SCJX/8vm18PMkdaoWhUoPtkr4N6x1+cUbTXiSo7d1PLkXqntF3oo9umDqpr04yn4IEVqTnR9t0qcw
	1GahUHBNp39Tu//oUaTnUxU76p4IWvIvNU5EuFzZAlODbcJesIURlPGI7/EFqXyMDlL/14TC5kgfX
	DYxcH0hFdlrWd7nSH4kii6yaLCn23FItxOidVXC2ZQxMi50XHTQA+6iLhJc/uGqfFqh4dpByJ0biK
	WUcuFS5w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.2 #3 (Red Hat Linux))
	id 1iDy9o-0000mk-38; Fri, 27 Sep 2019 21:52:08 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iDy9a-0000TY-AD
 for linux-nvme@lists.infradead.org; Fri, 27 Sep 2019 21:51:55 +0000
Received: by mail-pf1-x444.google.com with SMTP id h195so2282045pfe.5
 for <linux-nvme@lists.infradead.org>; Fri, 27 Sep 2019 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=UUdlGza3YxU2eOH4nWTG8ghcVw3ruPJ0Wwc4KKh/kDQ=;
 b=DvgQV6dlZO25Sh4WmysctCk6wFDaAFo+cCdtzwS4WMjkuSu03sc1ik1T8WVPlJMBhK
 tkzI6QdkfpTXzTAnBPKZ43uW8iKoJuDthThVcUX2ZD80POd+KoYzE/KtSgvzlxd8ZsZS
 xMOyCz1m3T+zNw47khlIX2ti59xdNAcXmfz37lcvKhFhhMlEZB7JFkFy8LdJeXyNfARp
 suLeiDrE1HPbSTMa+zsgi5b5Z+UFR1tToziURg1XlY8CjCkLwSAsxjoskydDg6aJH7v5
 cbjhW4e5WJsct10kAIv5ccmaFciCgtRoEvjIrohhSdu+1pNvw/YE1+FG/C1OV3B8B1/o
 sdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=UUdlGza3YxU2eOH4nWTG8ghcVw3ruPJ0Wwc4KKh/kDQ=;
 b=IhSculkZf5j/i0o4cegHJS3qmo9HbHfR5YfSkV4wkk4TpgDiVdzETDwg7jttIMuML5
 YFVgJENuckvdNUz8RzPZuC/kl5CaaMAr6KsDo73BBYHbMGA3FcrVHBCjmvWEF+xyuf3y
 dCi2AHEGGRm+H4pa5PNDr0TlJykQbK6DtRM3BI+1eGOHJwjniBHHG9DC4KC6j4jBlaqL
 +6UMTW9t2XmR5pvTi7IbBJoe4pBErtg7dHBfFGmoCD10b5Yeu6744WVmDMq4Fd0fozZ0
 QD3XdQ3IsjmrwToqJBv26KrnJuVWv3UCS+1C7V9pV6yRVlHAfeRgb1G+E6Nbpn77+stw
 ijYA==
X-Gm-Message-State: APjAAAW16l18rSlbfjx43WPHCaUOCfd964ph4IAi9UxyF3CNoNc14Cme
 Be4YyP1O+abirfIWG1dNS1Da+lDe
X-Google-Smtp-Source: APXvYqyxkmNrsXiYFd5Qr/YP2OxitkYF6998VVzfdpQgGr+AZ0vgkuhvjxSIxCdwPU0ZxDqg5vMxsw==
X-Received: by 2002:a62:798e:: with SMTP id u136mr7072707pfc.3.1569621113625; 
 Fri, 27 Sep 2019 14:51:53 -0700 (PDT)
Received: from pallmd1.broadcom.com ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id g5sm3430507pfh.133.2019.09.27.14.51.52
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 27 Sep 2019 14:51:53 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 2/3] nvme-fc and nvmet-fc: sync with FC-NVME-2 header changes
Date: Fri, 27 Sep 2019 14:51:35 -0700
Message-Id: <20190927215136.3096-3-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20190927215136.3096-1-jsmart2021@gmail.com>
References: <20190927215136.3096-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190927_145154_352936_FA079015 
X-CRM114-Status: GOOD (  15.66  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Sync sources with revised structure and field names to correspond with
FC-NVME-2 header sync-up.

Tested interoperability with success:
- prior initiator with new target
- prior target with new initiator
- new on new

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/host/fc.c   | 24 +++++++++++-------------
 drivers/nvme/target/fc.c | 27 +++++++++++++++------------
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9081ca9e8621..be99b3c8264f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1224,7 +1224,7 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
 	lsreq->rqstlen = sizeof(*assoc_rqst);
 	lsreq->rspaddr = assoc_acc;
 	lsreq->rsplen = sizeof(*assoc_acc);
-	lsreq->timeout = NVME_FC_CONNECT_TIMEOUT_SEC;
+	lsreq->timeout = NVME_FC_LS_TIMEOUT_SEC;
 
 	ret = nvme_fc_send_ls_req(ctrl->rport, lsop);
 	if (ret)
@@ -1332,7 +1332,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	lsreq->rqstlen = sizeof(*conn_rqst);
 	lsreq->rspaddr = conn_acc;
 	lsreq->rsplen = sizeof(*conn_acc);
-	lsreq->timeout = NVME_FC_CONNECT_TIMEOUT_SEC;
+	lsreq->timeout = NVME_FC_LS_TIMEOUT_SEC;
 
 	ret = nvme_fc_send_ls_req(ctrl->rport, lsop);
 	if (ret)
@@ -1413,8 +1413,8 @@ nvme_fc_disconnect_assoc_done(struct nvmefc_ls_req *lsreq, int status)
 static void
 nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
 {
-	struct fcnvme_ls_disconnect_rqst *discon_rqst;
-	struct fcnvme_ls_disconnect_acc *discon_acc;
+	struct fcnvme_ls_disconnect_assoc_rqst *discon_rqst;
+	struct fcnvme_ls_disconnect_assoc_acc *discon_acc;
 	struct nvmefc_ls_req_op *lsop;
 	struct nvmefc_ls_req *lsreq;
 	int ret;
@@ -1430,11 +1430,11 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
 	lsreq = &lsop->ls_req;
 
 	lsreq->private = (void *)&lsop[1];
-	discon_rqst = (struct fcnvme_ls_disconnect_rqst *)
+	discon_rqst = (struct fcnvme_ls_disconnect_assoc_rqst *)
 			(lsreq->private + ctrl->lport->ops->lsrqst_priv_sz);
-	discon_acc = (struct fcnvme_ls_disconnect_acc *)&discon_rqst[1];
+	discon_acc = (struct fcnvme_ls_disconnect_assoc_acc *)&discon_rqst[1];
 
-	discon_rqst->w0.ls_cmd = FCNVME_LS_DISCONNECT;
+	discon_rqst->w0.ls_cmd = FCNVME_LS_DISCONNECT_ASSOC;
 	discon_rqst->desc_list_len = cpu_to_be32(
 				sizeof(struct fcnvme_lsdesc_assoc_id) +
 				sizeof(struct fcnvme_lsdesc_disconn_cmd));
@@ -1451,14 +1451,12 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
 	discon_rqst->discon_cmd.desc_len =
 			fcnvme_lsdesc_len(
 				sizeof(struct fcnvme_lsdesc_disconn_cmd));
-	discon_rqst->discon_cmd.scope = FCNVME_DISCONN_ASSOCIATION;
-	discon_rqst->discon_cmd.id = cpu_to_be64(ctrl->association_id);
 
 	lsreq->rqstaddr = discon_rqst;
 	lsreq->rqstlen = sizeof(*discon_rqst);
 	lsreq->rspaddr = discon_acc;
 	lsreq->rsplen = sizeof(*discon_acc);
-	lsreq->timeout = NVME_FC_CONNECT_TIMEOUT_SEC;
+	lsreq->timeout = NVME_FC_LS_TIMEOUT_SEC;
 
 	ret = nvme_fc_send_ls_req_async(ctrl->rport, lsop,
 				nvme_fc_disconnect_assoc_done);
@@ -1659,7 +1657,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 					(freq->rcv_rsplen / 4) ||
 			     be32_to_cpu(op->rsp_iu.xfrd_len) !=
 					freq->transferred_length ||
-			     op->rsp_iu.status_code ||
+			     op->rsp_iu.ersp_result ||
 			     sqe->common.command_id != cqe->command_id)) {
 			status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
 			dev_info(ctrl->ctrl.device,
@@ -1669,7 +1667,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 				ctrl->cnum, be16_to_cpu(op->rsp_iu.iu_len),
 				be32_to_cpu(op->rsp_iu.xfrd_len),
 				freq->transferred_length,
-				op->rsp_iu.status_code,
+				op->rsp_iu.ersp_result,
 				sqe->common.command_id,
 				cqe->command_id);
 			goto done;
@@ -1728,7 +1726,7 @@ __nvme_fc_init_request(struct nvme_fc_ctrl *ctrl,
 	op->rq = rq;
 	op->rqno = rqno;
 
-	cmdiu->scsi_id = NVME_CMD_SCSI_ID;
+	cmdiu->format_id = NVME_CMD_FORMAT_ID;
 	cmdiu->fc_id = NVME_CMD_FC_ID;
 	cmdiu->iu_len = cpu_to_be16(sizeof(*cmdiu) / sizeof(u32));
 
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 87709ffb3123..dd585280f653 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1495,20 +1495,20 @@ static void
 nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 			struct nvmet_fc_ls_iod *iod)
 {
-	struct fcnvme_ls_disconnect_rqst *rqst =
-			(struct fcnvme_ls_disconnect_rqst *)iod->rqstbuf;
-	struct fcnvme_ls_disconnect_acc *acc =
-			(struct fcnvme_ls_disconnect_acc *)iod->rspbuf;
+	struct fcnvme_ls_disconnect_assoc_rqst *rqst =
+			(struct fcnvme_ls_disconnect_assoc_rqst *)iod->rqstbuf;
+	struct fcnvme_ls_disconnect_assoc_acc *acc =
+			(struct fcnvme_ls_disconnect_assoc_acc *)iod->rspbuf;
 	struct nvmet_fc_tgt_assoc *assoc;
 	int ret = 0;
 
 	memset(acc, 0, sizeof(*acc));
 
-	if (iod->rqstdatalen < sizeof(struct fcnvme_ls_disconnect_rqst))
+	if (iod->rqstdatalen < sizeof(struct fcnvme_ls_disconnect_assoc_rqst))
 		ret = VERR_DISCONN_LEN;
 	else if (rqst->desc_list_len !=
 			fcnvme_lsdesc_len(
-				sizeof(struct fcnvme_ls_disconnect_rqst)))
+				sizeof(struct fcnvme_ls_disconnect_assoc_rqst)))
 		ret = VERR_DISCONN_RQST_LEN;
 	else if (rqst->associd.desc_tag != cpu_to_be32(FCNVME_LSDESC_ASSOC_ID))
 		ret = VERR_ASSOC_ID;
@@ -1523,8 +1523,11 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 			fcnvme_lsdesc_len(
 				sizeof(struct fcnvme_lsdesc_disconn_cmd)))
 		ret = VERR_DISCONN_CMD_LEN;
-	else if ((rqst->discon_cmd.scope != FCNVME_DISCONN_ASSOCIATION) &&
-			(rqst->discon_cmd.scope != FCNVME_DISCONN_CONNECTION))
+	/*
+	 * As the standard changed on the LS, check if old format and scope
+	 * something other than Association (e.g. 0).
+	 */
+	else if (rqst->discon_cmd.rsvd8[0])
 		ret = VERR_DISCONN_SCOPE;
 	else {
 		/* match an active association */
@@ -1556,8 +1559,8 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 
 	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
 			fcnvme_lsdesc_len(
-				sizeof(struct fcnvme_ls_disconnect_acc)),
-			FCNVME_LS_DISCONNECT);
+				sizeof(struct fcnvme_ls_disconnect_assoc_acc)),
+			FCNVME_LS_DISCONNECT_ASSOC);
 
 	/* release get taken in nvmet_fc_find_target_assoc */
 	nvmet_fc_tgt_a_put(iod->assoc);
@@ -1632,7 +1635,7 @@ nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
 		/* Creates an IO Queue/Connection */
 		nvmet_fc_ls_create_connection(tgtport, iod);
 		break;
-	case FCNVME_LS_DISCONNECT:
+	case FCNVME_LS_DISCONNECT_ASSOC:
 		/* Terminate a Queue/Connection or the Association */
 		nvmet_fc_ls_disconnect(tgtport, iod);
 		break;
@@ -2299,7 +2302,7 @@ nvmet_fc_rcv_fcp_req(struct nvmet_fc_target_port *target_port,
 
 	/* validate iu, so the connection id can be used to find the queue */
 	if ((cmdiubuf_len != sizeof(*cmdiu)) ||
-			(cmdiu->scsi_id != NVME_CMD_SCSI_ID) ||
+			(cmdiu->format_id != NVME_CMD_FORMAT_ID) ||
 			(cmdiu->fc_id != NVME_CMD_FC_ID) ||
 			(be16_to_cpu(cmdiu->iu_len) != (sizeof(*cmdiu)/4)))
 		return -EIO;
-- 
2.13.7


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
