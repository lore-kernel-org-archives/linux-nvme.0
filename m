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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1913BC352A2
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:41:37 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBE3420674
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:41:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="f3qB3Aqj";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+T8Dmog"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBE3420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=fTEVH04bnDcRfDI27wHlI0RQVFun8alSA4YOB+Ft5f8=; b=f3qB3AqjPzK+Mlwct+o6f4hE4Z
	YxhNw6smM4WWSBFW0WxfDUhjskXcyZ4om3c9g9dRsnVNV8sPZfPB+LrjR10JHFyv9DPWHbfeCPtfK
	+MxXud+3c22LoztIEwqQBoNhlC4uS6bH6zOJ9clb+/p6fbuju6A5sv06eSj4qsfOOSHFPefXBtDzF
	En4CoNS4T8zKlJ7pnv9IaF3fsnP+z2ED2dN90fHVe1xNl6hxi5Rw2lRND1PYIRBe2cmgdyhH8Akio
	OVvE4/IlEK/zD6nsYrzKOL0IeOAd20+100XCQY33repzvKUcOGOEWcWF3ziXe9No+9DB2ahfklS06
	Ae7SHR1A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPcE-0007Oz-58; Wed, 05 Feb 2020 18:41:34 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZ8-0003gE-8A
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:25 +0000
Received: by mail-wr1-x444.google.com with SMTP id k11so4000234wrd.9
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Hna7onr+Ra9sg9APHNTegm9aIWu0Z0faNWhHdXiBk38=;
 b=f+T8DmoggirBzXctJyIIAevp9bqU2nh2yQ1WOZSxelRZOfYKOg+hiepgdKAB0/6Ziv
 kzIGoMudua9/58on+9g+qg4e5jRVaWqDLkcP9faYVZhp65zLFtfzBlL+mevsGXVoz6jO
 wBI3YU2uFFyRezb6OjfZMxp0HGq23a4AmJ/GLjs+dCd8SgEPZr+5B/QyoB2LTdYxeIqh
 PFHAuEOwyMfdW8d0wNZTyLI5SMH1L8BUh0TLSZqlV2bRmDrs68CnV1FDFiO7XZI69Y4t
 aM68dHEI3RquM0sPYM/KJhe6vSuhBBa/rv0FTAjLw4/OulfZHsdho3mzJ7upJX9xNwOL
 eInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Hna7onr+Ra9sg9APHNTegm9aIWu0Z0faNWhHdXiBk38=;
 b=O0nS35IeEctuVlzTk0faeZpo0Gx9fOKm4PDAw4Gn4QO66Jf2N8XeD8kiJ3XD0UTzSl
 0yNAfDMk1/V3XosTQb/nZKUT2KJdg5F+gdPHle+f3Ko2arKcl3kOxmEcUFonkoqJ/hVy
 cgOZWrBxYUlD/bNuVO8Nyc0gzq/HGTmHMfeXUkTeJ/8BccXnavM6eyOilTNIaMyOhoUd
 9cN8d0fa0lbZYLhRwV1dIII+phkbs1OT+oAjou3QGGxvc2LvA9msFl89fhah7DzVMOB3
 UEMHV31QdfyKSMVnYszAaoYAnaTo/fkQ1Zsah0SVyp0MsdGZUDFAQtcWUDb1ypbsIfJS
 lwvQ==
X-Gm-Message-State: APjAAAVXEvdQ7hDsyhVLNWZdRH2xhxm6eMkbCo8BSXSPIxdSnoi0XAhe
 hcXQ4clvK1R/WGxMYfugKVWOcE1n
X-Google-Smtp-Source: APXvYqwFrkXLg5FfDTWec8Jx/53rRNmIAkM4Dm3qCkSoufo3wPli9ZvwCJricj6dq+C4lN6b4jWJ9Q==
X-Received: by 2002:a5d:6406:: with SMTP id z6mr29533117wru.294.1580927900629; 
 Wed, 05 Feb 2020 10:38:20 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.19
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:20 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 12/29] nvme-fc: Add Disconnect Association Rcv support
Date: Wed,  5 Feb 2020 10:37:36 -0800
Message-Id: <20200205183753.25959-13-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103822_446414_CCBC8E99 
X-CRM114-Status: GOOD (  22.27  )
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

The nvme-fc host transport did not support the reception of a
FC-NVME LS. Reception is necessary to implement full compliance
with FC-NVME-2.

Populate the LS receive handler, and specifically the handling
of a Disconnect Association LS. The response to the LS, if it
matched a controller, must be sent after the aborts for any
I/O on any connection have been sent.

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/host/fc.c | 363 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 359 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 40e1141c76db..ab1fbefb6bee 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -62,6 +62,17 @@ struct nvmefc_ls_req_op {
 	bool			req_queued;
 };
 
+struct nvmefc_ls_rcv_op {
+	struct nvme_fc_rport		*rport;
+	struct nvmefc_ls_rsp		*lsrsp;
+	union nvmefc_ls_requests	*rqstbuf;
+	union nvmefc_ls_responses	*rspbuf;
+	u16				rqstdatalen;
+	bool				handled;
+	dma_addr_t			rspdma;
+	struct list_head		lsrcv_list;	/* rport->ls_rcv_list */
+} __aligned(sizeof(u64));	/* alignment for other things alloc'd with */
+
 enum nvme_fcpop_state {
 	FCPOP_STATE_UNINIT	= 0,
 	FCPOP_STATE_IDLE	= 1,
@@ -118,6 +129,7 @@ struct nvme_fc_rport {
 	struct list_head		endp_list; /* for lport->endp_list */
 	struct list_head		ctrl_list;
 	struct list_head		ls_req_list;
+	struct list_head		ls_rcv_list;
 	struct list_head		disc_list;
 	struct device			*dev;	/* physical device for dma */
 	struct nvme_fc_lport		*lport;
@@ -125,6 +137,7 @@ struct nvme_fc_rport {
 	struct kref			ref;
 	atomic_t                        act_ctrl_cnt;
 	unsigned long			dev_loss_end;
+	struct work_struct		lsrcv_work;
 } __aligned(sizeof(u64));	/* alignment for other things alloc'd with */
 
 enum nvme_fcctrl_flags {
@@ -148,6 +161,7 @@ struct nvme_fc_ctrl {
 	atomic_t		assoc_active;
 	atomic_t		err_work_active;
 	u64			association_id;
+	struct nvmefc_ls_rcv_op	*rcv_disconn;
 
 	struct list_head	ctrl_list;	/* rport->ctrl_list */
 
@@ -225,6 +239,9 @@ static struct device *fc_udev_device;
 static void __nvme_fc_delete_hw_queue(struct nvme_fc_ctrl *,
 			struct nvme_fc_queue *, unsigned int);
 
+static void nvme_fc_handle_ls_rqst_work(struct work_struct *work);
+
+
 static void
 nvme_fc_free_lport(struct kref *ref)
 {
@@ -711,6 +728,7 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 	atomic_set(&newrec->act_ctrl_cnt, 0);
 	spin_lock_init(&newrec->lock);
 	newrec->remoteport.localport = &lport->localport;
+	INIT_LIST_HEAD(&newrec->ls_rcv_list);
 	newrec->dev = lport->dev;
 	newrec->lport = lport;
 	if (lport->ops->remote_priv_sz)
@@ -724,6 +742,7 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
 	newrec->remoteport.port_state = FC_OBJSTATE_ONLINE;
 	newrec->remoteport.port_num = idx;
 	__nvme_fc_set_dev_loss_tmo(newrec, pinfo);
+	INIT_WORK(&newrec->lsrcv_work, nvme_fc_handle_ls_rqst_work);
 
 	spin_lock_irqsave(&nvme_fc_lock, flags);
 	list_add_tail(&newrec->endp_list, &lport->endp_list);
@@ -1013,6 +1032,7 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
 static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
 
+static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
 
 static void
 __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
@@ -1161,6 +1181,7 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
 	struct nvmefc_ls_req *lsreq;
 	struct fcnvme_ls_cr_assoc_rqst *assoc_rqst;
 	struct fcnvme_ls_cr_assoc_acc *assoc_acc;
+	unsigned long flags;
 	int ret, fcret = 0;
 
 	lsop = kzalloc((sizeof(*lsop) +
@@ -1250,11 +1271,13 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
 			"q %d Create Association LS failed: %s\n",
 			queue->qnum, validation_errors[fcret]);
 	} else {
+		spin_lock_irqsave(&ctrl->lock, flags);
 		ctrl->association_id =
 			be64_to_cpu(assoc_acc->associd.association_id);
 		queue->connection_id =
 			be64_to_cpu(assoc_acc->connectid.connection_id);
 		set_bit(NVME_FC_Q_CONNECTED, &queue->flags);
+		spin_unlock_irqrestore(&ctrl->lock, flags);
 	}
 
 out_free_buffer:
@@ -1435,6 +1458,247 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
 		kfree(lsop);
 }
 
+static void
+nvme_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
+{
+	struct nvmefc_ls_rcv_op *lsop = lsrsp->nvme_fc_private;
+	struct nvme_fc_rport *rport = lsop->rport;
+	struct nvme_fc_lport *lport = rport->lport;
+	unsigned long flags;
+
+	spin_lock_irqsave(&rport->lock, flags);
+	list_del(&lsop->lsrcv_list);
+	spin_unlock_irqrestore(&rport->lock, flags);
+
+	fc_dma_sync_single_for_cpu(lport->dev, lsop->rspdma,
+				sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
+	fc_dma_unmap_single(lport->dev, lsop->rspdma,
+			sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
+
+	kfree(lsop);
+
+	nvme_fc_rport_put(rport);
+}
+
+static void
+nvme_fc_xmt_ls_rsp(struct nvmefc_ls_rcv_op *lsop)
+{
+	struct nvme_fc_rport *rport = lsop->rport;
+	struct nvme_fc_lport *lport = rport->lport;
+	struct fcnvme_ls_rqst_w0 *w0 = &lsop->rqstbuf->w0;
+	int ret;
+
+	fc_dma_sync_single_for_device(lport->dev, lsop->rspdma,
+				  sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
+
+	ret = lport->ops->xmt_ls_rsp(&lport->localport, &rport->remoteport,
+				     lsop->lsrsp);
+	if (ret) {
+		dev_warn(lport->dev,
+			"LLDD rejected LS RSP xmt: LS %d status %d\n",
+			w0->ls_cmd, ret);
+		nvme_fc_xmt_ls_rsp_done(lsop->lsrsp);
+		return;
+	}
+}
+
+static struct nvme_fc_ctrl *
+nvme_fc_match_disconn_ls(struct nvme_fc_rport *rport,
+		      struct nvmefc_ls_rcv_op *lsop)
+{
+	struct fcnvme_ls_disconnect_assoc_rqst *rqst =
+					&lsop->rqstbuf->rq_dis_assoc;
+	struct nvme_fc_ctrl *ctrl, *ret = NULL;
+	struct nvmefc_ls_rcv_op *oldls = NULL;
+	u64 association_id = be64_to_cpu(rqst->associd.association_id);
+	unsigned long flags;
+
+	spin_lock_irqsave(&rport->lock, flags);
+
+	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
+		if (!nvme_fc_ctrl_get(ctrl))
+			continue;
+		spin_lock(&ctrl->lock);
+		if (association_id == ctrl->association_id) {
+			oldls = ctrl->rcv_disconn;
+			ctrl->rcv_disconn = lsop;
+			ret = ctrl;
+		}
+		spin_unlock(&ctrl->lock);
+		if (ret)
+			/* leave the ctrl get reference */
+			break;
+		nvme_fc_ctrl_put(ctrl);
+	}
+
+	spin_unlock_irqrestore(&rport->lock, flags);
+
+	/* transmit a response for anything that was pending */
+	if (oldls) {
+		dev_info(rport->lport->dev,
+			"NVME-FC{%d}: Multiple Disconnect Association "
+			"LS's received\n", ctrl->cnum);
+		/* overwrite good response with bogus failure */
+		oldls->lsrsp->rsplen = nvme_fc_format_rjt(oldls->rspbuf,
+						sizeof(*oldls->rspbuf),
+						rqst->w0.ls_cmd,
+						FCNVME_RJT_RC_UNAB,
+						FCNVME_RJT_EXP_NONE, 0);
+		nvme_fc_xmt_ls_rsp(oldls);
+	}
+
+	return ret;
+}
+
+/*
+ * returns true to mean LS handled and ls_rsp can be sent
+ * returns false to defer ls_rsp xmt (will be done as part of
+ *     association termination)
+ */
+static bool
+nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
+{
+	struct nvme_fc_rport *rport = lsop->rport;
+	struct fcnvme_ls_disconnect_assoc_rqst *rqst =
+					&lsop->rqstbuf->rq_dis_assoc;
+	struct fcnvme_ls_disconnect_assoc_acc *acc =
+					&lsop->rspbuf->rsp_dis_assoc;
+	struct nvme_fc_ctrl *ctrl = NULL;
+	int ret = 0;
+
+	memset(acc, 0, sizeof(*acc));
+
+	ret = nvmefc_vldt_lsreq_discon_assoc(lsop->rqstdatalen, rqst);
+	if (!ret) {
+		/* match an active association */
+		ctrl = nvme_fc_match_disconn_ls(rport, lsop);
+		if (!ctrl)
+			ret = VERR_NO_ASSOC;
+	}
+
+	if (ret) {
+		dev_info(rport->lport->dev,
+			"Disconnect LS failed: %s\n",
+			validation_errors[ret]);
+		lsop->lsrsp->rsplen = nvme_fc_format_rjt(acc,
+					sizeof(*acc), rqst->w0.ls_cmd,
+					(ret == VERR_NO_ASSOC) ?
+						FCNVME_RJT_RC_INV_ASSOC :
+						FCNVME_RJT_RC_LOGIC,
+					FCNVME_RJT_EXP_NONE, 0);
+		return true;
+	}
+
+	/* format an ACCept response */
+
+	lsop->lsrsp->rsplen = sizeof(*acc);
+
+	nvme_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
+			fcnvme_lsdesc_len(
+				sizeof(struct fcnvme_ls_disconnect_assoc_acc)),
+			FCNVME_LS_DISCONNECT_ASSOC);
+
+	/*
+	 * the transmit of the response will occur after the exchanges
+	 * for the association have been ABTS'd by
+	 * nvme_fc_delete_association().
+	 */
+
+	/* fail the association */
+	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
+
+	/* release the reference taken by nvme_fc_match_disconn_ls() */
+	nvme_fc_ctrl_put(ctrl);
+
+	return false;
+}
+
+/*
+ * Actual Processing routine for received FC-NVME LS Requests from the LLD
+ * returns true if a response should be sent afterward, false if rsp will
+ * be sent asynchronously.
+ */
+static bool
+nvme_fc_handle_ls_rqst(struct nvmefc_ls_rcv_op *lsop)
+{
+	struct fcnvme_ls_rqst_w0 *w0 = &lsop->rqstbuf->w0;
+	bool ret = true;
+
+	lsop->lsrsp->nvme_fc_private = lsop;
+	lsop->lsrsp->rspbuf = lsop->rspbuf;
+	lsop->lsrsp->rspdma = lsop->rspdma;
+	lsop->lsrsp->done = nvme_fc_xmt_ls_rsp_done;
+	/* Be preventative. handlers will later set to valid length */
+	lsop->lsrsp->rsplen = 0;
+
+	/*
+	 * handlers:
+	 *   parse request input, execute the request, and format the
+	 *   LS response
+	 */
+	switch (w0->ls_cmd) {
+	case FCNVME_LS_DISCONNECT_ASSOC:
+		ret = nvme_fc_ls_disconnect_assoc(lsop);
+		break;
+	case FCNVME_LS_DISCONNECT_CONN:
+		lsop->lsrsp->rsplen = nvme_fc_format_rjt(lsop->rspbuf,
+				sizeof(*lsop->rspbuf), w0->ls_cmd,
+				FCNVME_RJT_RC_UNSUP, FCNVME_RJT_EXP_NONE, 0);
+		break;
+	case FCNVME_LS_CREATE_ASSOCIATION:
+	case FCNVME_LS_CREATE_CONNECTION:
+		lsop->lsrsp->rsplen = nvme_fc_format_rjt(lsop->rspbuf,
+				sizeof(*lsop->rspbuf), w0->ls_cmd,
+				FCNVME_RJT_RC_LOGIC, FCNVME_RJT_EXP_NONE, 0);
+		break;
+	default:
+		lsop->lsrsp->rsplen = nvme_fc_format_rjt(lsop->rspbuf,
+				sizeof(*lsop->rspbuf), w0->ls_cmd,
+				FCNVME_RJT_RC_INVAL, FCNVME_RJT_EXP_NONE, 0);
+		break;
+	}
+
+	return(ret);
+}
+
+static void
+nvme_fc_handle_ls_rqst_work(struct work_struct *work)
+{
+	struct nvme_fc_rport *rport =
+		container_of(work, struct nvme_fc_rport, lsrcv_work);
+	struct fcnvme_ls_rqst_w0 *w0;
+	struct nvmefc_ls_rcv_op *lsop;
+	unsigned long flags;
+	bool sendrsp;
+
+restart:
+	sendrsp = true;
+	spin_lock_irqsave(&rport->lock, flags);
+	list_for_each_entry(lsop, &rport->ls_rcv_list, lsrcv_list) {
+		if (lsop->handled)
+			continue;
+
+		lsop->handled = true;
+		if (rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
+			spin_unlock_irqrestore(&rport->lock, flags);
+			sendrsp = nvme_fc_handle_ls_rqst(lsop);
+		} else {
+			spin_unlock_irqrestore(&rport->lock, flags);
+			w0 = &lsop->rqstbuf->w0;
+			lsop->lsrsp->rsplen = nvme_fc_format_rjt(
+						lsop->rspbuf,
+						sizeof(*lsop->rspbuf),
+						w0->ls_cmd,
+						FCNVME_RJT_RC_UNAB,
+						FCNVME_RJT_EXP_NONE, 0);
+		}
+		if (sendrsp)
+			nvme_fc_xmt_ls_rsp(lsop);
+		goto restart;
+	}
+	spin_unlock_irqrestore(&rport->lock, flags);
+}
+
 /**
  * nvme_fc_rcv_ls_req - transport entry point called by an LLDD
  *                       upon the reception of a NVME LS request.
@@ -1461,20 +1725,92 @@ nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
 {
 	struct nvme_fc_rport *rport = remoteport_to_rport(portptr);
 	struct nvme_fc_lport *lport = rport->lport;
+	struct fcnvme_ls_rqst_w0 *w0 = (struct fcnvme_ls_rqst_w0 *)lsreqbuf;
+	struct nvmefc_ls_rcv_op *lsop;
+	unsigned long flags;
+	int ret;
+
+	nvme_fc_rport_get(rport);
 
 	/* validate there's a routine to transmit a response */
-	if (!lport->ops->xmt_ls_rsp)
-		return(-EINVAL);
+	if (!lport->ops->xmt_ls_rsp) {
+		dev_info(lport->dev,
+			"RCV %s LS failed: no LLDD xmt_ls_rsp\n",
+			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
+				nvmefc_ls_names[w0->ls_cmd] : "");
+		ret = -EINVAL;
+		goto out_put;
+	}
+
+	if (lsreqbuf_len > sizeof(union nvmefc_ls_requests)) {
+		dev_info(lport->dev,
+			"RCV %s LS failed: payload too large\n",
+			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
+				nvmefc_ls_names[w0->ls_cmd] : "");
+		ret = -E2BIG;
+		goto out_put;
+	}
+
+	lsop = kzalloc(sizeof(*lsop) +
+			sizeof(union nvmefc_ls_requests) +
+			sizeof(union nvmefc_ls_responses),
+			GFP_KERNEL);
+	if (!lsop) {
+		dev_info(lport->dev,
+			"RCV %s LS failed: No memory\n",
+			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
+				nvmefc_ls_names[w0->ls_cmd] : "");
+		ret = -ENOMEM;
+		goto out_put;
+	}
+	lsop->rqstbuf = (union nvmefc_ls_requests *)&lsop[1];
+	lsop->rspbuf = (union nvmefc_ls_responses *)&lsop->rqstbuf[1];
+
+	lsop->rspdma = fc_dma_map_single(lport->dev, lsop->rspbuf,
+					sizeof(*lsop->rspbuf),
+					DMA_TO_DEVICE);
+	if (fc_dma_mapping_error(lport->dev, lsop->rspdma)) {
+		dev_info(lport->dev,
+			"RCV %s LS failed: DMA mapping failure\n",
+			(w0->ls_cmd <= NVME_FC_LAST_LS_CMD_VALUE) ?
+				nvmefc_ls_names[w0->ls_cmd] : "");
+		ret = -EFAULT;
+		goto out_free;
+	}
+
+	lsop->rport = rport;
+	lsop->lsrsp = lsrsp;
+
+	memcpy(lsop->rqstbuf, lsreqbuf, lsreqbuf_len);
+	lsop->rqstdatalen = lsreqbuf_len;
+
+	spin_lock_irqsave(&rport->lock, flags);
+	if (rport->remoteport.port_state != FC_OBJSTATE_ONLINE) {
+		spin_unlock_irqrestore(&rport->lock, flags);
+		ret = -ENOTCONN;
+		goto out_unmap;
+	}
+	list_add_tail(&lsop->lsrcv_list, &rport->ls_rcv_list);
+	spin_unlock_irqrestore(&rport->lock, flags);
+
+	schedule_work(&rport->lsrcv_work);
 
 	return 0;
+
+out_unmap:
+	fc_dma_unmap_single(lport->dev, lsop->rspdma,
+			sizeof(*lsop->rspbuf), DMA_TO_DEVICE);
+out_free:
+	kfree(lsop);
+out_put:
+	nvme_fc_rport_put(rport);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(nvme_fc_rcv_ls_req);
 
 
 /* *********************** NVME Ctrl Routines **************************** */
 
-static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
-
 static void
 __nvme_fc_exit_request(struct nvme_fc_ctrl *ctrl,
 		struct nvme_fc_fcp_op *op)
@@ -2631,6 +2967,8 @@ static int
 nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	struct nvmefc_ls_rcv_op *disls = NULL;
+	unsigned long flags;
 	int ret;
 	bool changed;
 
@@ -2748,7 +3086,13 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 out_disconnect_admin_queue:
 	/* send a Disconnect(association) LS to fc-nvme target */
 	nvme_fc_xmt_disconnect_assoc(ctrl);
+	spin_lock_irqsave(&ctrl->lock, flags);
 	ctrl->association_id = 0;
+	disls = ctrl->rcv_disconn;
+	ctrl->rcv_disconn = NULL;
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+	if (disls)
+		nvme_fc_xmt_ls_rsp(disls);
 out_delete_hw_queue:
 	__nvme_fc_delete_hw_queue(ctrl, &ctrl->queues[0], 0);
 out_free_queue:
@@ -2768,6 +3112,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 static void
 nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 {
+	struct nvmefc_ls_rcv_op *disls = NULL;
 	unsigned long flags;
 	int priorstate;
 
@@ -2842,7 +3187,17 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	if (ctrl->association_id)
 		nvme_fc_xmt_disconnect_assoc(ctrl);
 
+	spin_lock_irqsave(&ctrl->lock, flags);
 	ctrl->association_id = 0;
+	disls = ctrl->rcv_disconn;
+	ctrl->rcv_disconn = NULL;
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+	if (disls)
+		/*
+		 * if a Disconnect Request was waiting for a response, send
+		 * now that all ABTS's have been issued (and are complete).
+		 */
+		nvme_fc_xmt_ls_rsp(disls);
 
 	if (ctrl->ctrl.tagset) {
 		nvme_fc_delete_hw_io_queues(ctrl);
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
