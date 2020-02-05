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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A73FC35247
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 19:45:41 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5DF020730
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 19:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="KmjroDtv";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E00tAE+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5DF020730
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=b4CQrjEytYQ5mGD7/bU7UnToXkfOlnhwFNm6Ng8j0Zc=; b=KmjroDtvJf/itFic6spknLsnQI
	PX/ZcHTMM6EU7VofT+5ccTB7KyDQn0j4mAoilGhgNjKE9u/lgrLE37d010h1nEma8y3eX62nI5pqq
	Zos4KDr7pUOKJcfCG429bKNUvj5a/OIK4DNO3ZHoUjllSZDMkV/AwtJvRuT4+5eF9QTdEfKyAW/VU
	SaRFo/sW/YstPTbKzyd5WJvVoCd2JY+KTQeUn5iTny4W4iJLpuUxt5Xoi6KjC64gV4UdEeG7ZxPDZ
	IJUCscmVNw76VKLHsr1+n4bb2RAaB8MxI3jgVTFArHqo6yAVa5BZPDrrADcNeLuygP621tT6abQfo
	jlmSF0ng==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izQcC-0007Vk-J0; Wed, 05 Feb 2020 19:45:36 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPYw-0003SN-Av
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:12 +0000
Received: by mail-wm1-x342.google.com with SMTP id g1so3580071wmh.4
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=VbMjFT2psUe5CpYNt4KfszHWyM5DFnxGKKAXLItcTjw=;
 b=E00tAE+M3U9XqF7J+FckVhp093IE+BAYWzlIJOh7cQilseFnooMQElnjm4qu8ACE4T
 utQmlla+yImjK5OB2cXaOpnIWAVCZcc7+ani5Vahq0pMpuv44joXjGgSmVesInQYcNsY
 nIdbgYv1FY+A5vrBcWeKnu2zmCx/eqdoJ5Ql4onpc5deIoSzGRXS9Z2Kfg4+fM9mchR6
 Y2Mlcg0ARuGpKRsY0xvWby57eJ++5Fkori4JECqFGMxhUQSsgLoKLYRFw+0PIZfsiQoV
 N2RDCIgTr6W0C8kt24cs04abch8N5ENfiRDNv2HcD2iIstRaxNIUvz65MBeiUlGl6+RE
 Jdcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=VbMjFT2psUe5CpYNt4KfszHWyM5DFnxGKKAXLItcTjw=;
 b=EpjKt5fRCtJ1xsHh1h36ce+OteCLU+ujRWAEhhub0NPQjmLDphrksH1dGB7iur73ep
 e3Ze0OKzW432ZyKZTVyClHtmHlv2SaYiW98JTWm71ogdK7UzuPLcjfxZiUYngNbDH6y1
 Vxcgl0+nHRr42RQ6s2y7AgLomALa9k1csD/vT851DU059FqlBH3DCYfygsICc4XIoq1j
 qM3fG5Z9Y4yvK6f1FQKjCdpeJlTOomknKDBkWCjTQsIz1adOuFV2sEv6bQrAM1TjA2/9
 0/DlquLJF7kMclvQO58DE08K4iCLtlauLadTF2lBiFSVCcRArn3m3kfvxdpaAfUVb2Oz
 /sFg==
X-Gm-Message-State: APjAAAWCL540IsGVelbLZ2bD2LOOUtjz+2lzmwDpo+C3c1ZMSUkme7VK
 ncPzzQzGiu0NEtaThnqyN3UqRVWs
X-Google-Smtp-Source: APXvYqzTduCbC/Y9irM2w0sZ7+BjhNhf4QeUZWyVk/z6F1ftbS8aEjEE1/RE9sIi2yBdj/OdcTFvNw==
X-Received: by 2002:a05:600c:294a:: with SMTP id
 n10mr7305968wmd.11.1580927888463; 
 Wed, 05 Feb 2020 10:38:08 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:08 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 04/29] nvme-fc nvmet_fc nvme_fcloop: adapt code to changed
 names in api header
Date: Wed,  5 Feb 2020 10:37:28 -0800
Message-Id: <20200205183753.25959-5-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103810_463918_BB13B708 
X-CRM114-Status: GOOD (  22.70  )
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

deal with following naming changes in the header:
  nvmefc_tgt_ls_req -> nvmefc_ls_rsp
  nvmefc_tgt_ls_req.nvmet_fc_private -> nvmefc_ls_rsp.nvme_fc_private

Change calling sequence to nvmet_fc_rcv_ls_req() for hosthandle.

Add stubs for new interfaces:
host/fc.c: nvme_fc_rcv_ls_req()
target/fc.c: nvmet_fc_invalidate_host()

Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/nvme/host/fc.c       | 35 ++++++++++++++++++++
 drivers/nvme/target/fc.c     | 77 ++++++++++++++++++++++++++++++++------------
 drivers/nvme/target/fcloop.c | 20 ++++++------
 3 files changed, 102 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5a70ac395d53..f8f79cd88769 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1465,6 +1465,41 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
 		kfree(lsop);
 }
 
+/**
+ * nvme_fc_rcv_ls_req - transport entry point called by an LLDD
+ *                       upon the reception of a NVME LS request.
+ *
+ * The nvme-fc layer will copy payload to an internal structure for
+ * processing.  As such, upon completion of the routine, the LLDD may
+ * immediately free/reuse the LS request buffer passed in the call.
+ *
+ * If this routine returns error, the LLDD should abort the exchange.
+ *
+ * @remoteport: pointer to the (registered) remote port that the LS
+ *              was received from. The remoteport is associated with
+ *              a specific localport.
+ * @lsrsp:      pointer to a nvmefc_ls_rsp response structure to be
+ *              used to reference the exchange corresponding to the LS
+ *              when issuing an ls response.
+ * @lsreqbuf:   pointer to the buffer containing the LS Request
+ * @lsreqbuf_len: length, in bytes, of the received LS request
+ */
+int
+nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
+			struct nvmefc_ls_rsp *lsrsp,
+			void *lsreqbuf, u32 lsreqbuf_len)
+{
+	struct nvme_fc_rport *rport = remoteport_to_rport(portptr);
+	struct nvme_fc_lport *lport = rport->lport;
+
+	/* validate there's a routine to transmit a response */
+	if (!lport->ops->xmt_ls_rsp)
+		return(-EINVAL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_fc_rcv_ls_req);
+
 
 /* *********************** NVME Ctrl Routines **************************** */
 
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a8ceb7721640..aac7869a70bb 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -28,7 +28,7 @@ struct nvmet_fc_tgtport;
 struct nvmet_fc_tgt_assoc;
 
 struct nvmet_fc_ls_iod {
-	struct nvmefc_tgt_ls_req	*lsreq;
+	struct nvmefc_ls_rsp		*lsrsp;
 	struct nvmefc_tgt_fcp_req	*fcpreq;	/* only if RS */
 
 	struct list_head		ls_list;	/* tgtport->ls_list */
@@ -1146,6 +1146,42 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 }
 
+/**
+ * nvmet_fc_invalidate_host - transport entry point called by an LLDD
+ *                       to remove references to a hosthandle for LS's.
+ *
+ * The nvmet-fc layer ensures that any references to the hosthandle
+ * on the targetport are forgotten (set to NULL).  The LLDD will
+ * typically call this when a login with a remote host port has been
+ * lost, thus LS's for the remote host port are no longer possible.
+ *
+ * If an LS request is outstanding to the targetport/hosthandle (or
+ * issued concurrently with the call to invalidate the host), the
+ * LLDD is responsible for terminating/aborting the LS and completing
+ * the LS request. It is recommended that these terminations/aborts
+ * occur after calling to invalidate the host handle to avoid additional
+ * retries by the nvmet-fc transport. The nvmet-fc transport may
+ * continue to reference host handle while it cleans up outstanding
+ * NVME associations. The nvmet-fc transport will call the
+ * ops->host_release() callback to notify the LLDD that all references
+ * are complete and the related host handle can be recovered.
+ * Note: if there are no references, the callback may be called before
+ * the invalidate host call returns.
+ *
+ * @target_port: pointer to the (registered) target port that a prior
+ *              LS was received on and which supplied the transport the
+ *              hosthandle.
+ * @hosthandle: the handle (pointer) that represents the host port
+ *              that no longer has connectivity and that LS's should
+ *              no longer be directed to.
+ */
+void
+nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
+			void *hosthandle)
+{
+}
+EXPORT_SYMBOL_GPL(nvmet_fc_invalidate_host);
+
 /*
  * nvmet layer has called to terminate an association
  */
@@ -1371,7 +1407,7 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 		dev_err(tgtport->dev,
 			"Create Association LS failed: %s\n",
 			validation_errors[ret]);
-		iod->lsreq->rsplen = nvmet_fc_format_rjt(acc,
+		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
 				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
 				FCNVME_RJT_RC_LOGIC,
 				FCNVME_RJT_EXP_NONE, 0);
@@ -1384,7 +1420,7 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 
 	/* format a response */
 
-	iod->lsreq->rsplen = sizeof(*acc);
+	iod->lsrsp->rsplen = sizeof(*acc);
 
 	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
 			fcnvme_lsdesc_len(
@@ -1462,7 +1498,7 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 		dev_err(tgtport->dev,
 			"Create Connection LS failed: %s\n",
 			validation_errors[ret]);
-		iod->lsreq->rsplen = nvmet_fc_format_rjt(acc,
+		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
 				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
 				(ret == VERR_NO_ASSOC) ?
 					FCNVME_RJT_RC_INV_ASSOC :
@@ -1477,7 +1513,7 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 
 	/* format a response */
 
-	iod->lsreq->rsplen = sizeof(*acc);
+	iod->lsrsp->rsplen = sizeof(*acc);
 
 	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
 			fcnvme_lsdesc_len(sizeof(struct fcnvme_ls_cr_conn_acc)),
@@ -1542,7 +1578,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 		dev_err(tgtport->dev,
 			"Disconnect LS failed: %s\n",
 			validation_errors[ret]);
-		iod->lsreq->rsplen = nvmet_fc_format_rjt(acc,
+		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
 				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
 				(ret == VERR_NO_ASSOC) ?
 					FCNVME_RJT_RC_INV_ASSOC :
@@ -1555,7 +1591,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 
 	/* format a response */
 
-	iod->lsreq->rsplen = sizeof(*acc);
+	iod->lsrsp->rsplen = sizeof(*acc);
 
 	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
 			fcnvme_lsdesc_len(
@@ -1577,9 +1613,9 @@ static void nvmet_fc_fcp_nvme_cmd_done(struct nvmet_req *nvme_req);
 static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops;
 
 static void
-nvmet_fc_xmt_ls_rsp_done(struct nvmefc_tgt_ls_req *lsreq)
+nvmet_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
 {
-	struct nvmet_fc_ls_iod *iod = lsreq->nvmet_fc_private;
+	struct nvmet_fc_ls_iod *iod = lsrsp->nvme_fc_private;
 	struct nvmet_fc_tgtport *tgtport = iod->tgtport;
 
 	fc_dma_sync_single_for_cpu(tgtport->dev, iod->rspdma,
@@ -1597,9 +1633,9 @@ nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 	fc_dma_sync_single_for_device(tgtport->dev, iod->rspdma,
 				  NVME_FC_MAX_LS_BUFFER_SIZE, DMA_TO_DEVICE);
 
-	ret = tgtport->ops->xmt_ls_rsp(&tgtport->fc_target_port, iod->lsreq);
+	ret = tgtport->ops->xmt_ls_rsp(&tgtport->fc_target_port, iod->lsrsp);
 	if (ret)
-		nvmet_fc_xmt_ls_rsp_done(iod->lsreq);
+		nvmet_fc_xmt_ls_rsp_done(iod->lsrsp);
 }
 
 /*
@@ -1612,12 +1648,12 @@ nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
 	struct fcnvme_ls_rqst_w0 *w0 =
 			(struct fcnvme_ls_rqst_w0 *)iod->rqstbuf;
 
-	iod->lsreq->nvmet_fc_private = iod;
-	iod->lsreq->rspbuf = iod->rspbuf;
-	iod->lsreq->rspdma = iod->rspdma;
-	iod->lsreq->done = nvmet_fc_xmt_ls_rsp_done;
+	iod->lsrsp->nvme_fc_private = iod;
+	iod->lsrsp->rspbuf = iod->rspbuf;
+	iod->lsrsp->rspdma = iod->rspdma;
+	iod->lsrsp->done = nvmet_fc_xmt_ls_rsp_done;
 	/* Be preventative. handlers will later set to valid length */
-	iod->lsreq->rsplen = 0;
+	iod->lsrsp->rsplen = 0;
 
 	iod->assoc = NULL;
 
@@ -1640,7 +1676,7 @@ nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
 		nvmet_fc_ls_disconnect(tgtport, iod);
 		break;
 	default:
-		iod->lsreq->rsplen = nvmet_fc_format_rjt(iod->rspbuf,
+		iod->lsrsp->rsplen = nvmet_fc_format_rjt(iod->rspbuf,
 				NVME_FC_MAX_LS_BUFFER_SIZE, w0->ls_cmd,
 				FCNVME_RJT_RC_INVAL, FCNVME_RJT_EXP_NONE, 0);
 	}
@@ -1674,14 +1710,15 @@ nvmet_fc_handle_ls_rqst_work(struct work_struct *work)
  *
  * @target_port: pointer to the (registered) target port the LS was
  *              received on.
- * @lsreq:      pointer to a lsreq request structure to be used to reference
+ * @lsrsp:      pointer to a lsrsp structure to be used to reference
  *              the exchange corresponding to the LS.
  * @lsreqbuf:   pointer to the buffer containing the LS Request
  * @lsreqbuf_len: length, in bytes, of the received LS request
  */
 int
 nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
-			struct nvmefc_tgt_ls_req *lsreq,
+			void *hosthandle,
+			struct nvmefc_ls_rsp *lsrsp,
 			void *lsreqbuf, u32 lsreqbuf_len)
 {
 	struct nvmet_fc_tgtport *tgtport = targetport_to_tgtport(target_port);
@@ -1699,7 +1736,7 @@ nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
 		return -ENOENT;
 	}
 
-	iod->lsreq = lsreq;
+	iod->lsrsp = lsrsp;
 	iod->fcpreq = NULL;
 	memcpy(iod->rqstbuf, lsreqbuf, lsreqbuf_len);
 	iod->rqstdatalen = lsreqbuf_len;
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 1c50af6219f3..130932a5db0c 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -227,7 +227,7 @@ struct fcloop_lsreq {
 	struct fcloop_tport		*tport;
 	struct nvmefc_ls_req		*lsreq;
 	struct work_struct		work;
-	struct nvmefc_tgt_ls_req	tgt_ls_req;
+	struct nvmefc_ls_rsp		ls_rsp;
 	int				status;
 };
 
@@ -265,9 +265,9 @@ struct fcloop_ini_fcpreq {
 };
 
 static inline struct fcloop_lsreq *
-tgt_ls_req_to_lsreq(struct nvmefc_tgt_ls_req *tgt_lsreq)
+ls_rsp_to_lsreq(struct nvmefc_ls_rsp *lsrsp)
 {
-	return container_of(tgt_lsreq, struct fcloop_lsreq, tgt_ls_req);
+	return container_of(lsrsp, struct fcloop_lsreq, ls_rsp);
 }
 
 static inline struct fcloop_fcpreq *
@@ -330,7 +330,7 @@ fcloop_ls_req(struct nvme_fc_local_port *localport,
 
 	tls_req->status = 0;
 	tls_req->tport = rport->targetport->private;
-	ret = nvmet_fc_rcv_ls_req(rport->targetport, &tls_req->tgt_ls_req,
+	ret = nvmet_fc_rcv_ls_req(rport->targetport, NULL, &tls_req->ls_rsp,
 				 lsreq->rqstaddr, lsreq->rqstlen);
 
 	return ret;
@@ -338,15 +338,15 @@ fcloop_ls_req(struct nvme_fc_local_port *localport,
 
 static int
 fcloop_xmt_ls_rsp(struct nvmet_fc_target_port *tport,
-			struct nvmefc_tgt_ls_req *tgt_lsreq)
+			struct nvmefc_ls_rsp *lsrsp)
 {
-	struct fcloop_lsreq *tls_req = tgt_ls_req_to_lsreq(tgt_lsreq);
+	struct fcloop_lsreq *tls_req = ls_rsp_to_lsreq(lsrsp);
 	struct nvmefc_ls_req *lsreq = tls_req->lsreq;
 
-	memcpy(lsreq->rspaddr, tgt_lsreq->rspbuf,
-		((lsreq->rsplen < tgt_lsreq->rsplen) ?
-				lsreq->rsplen : tgt_lsreq->rsplen));
-	tgt_lsreq->done(tgt_lsreq);
+	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
+		((lsreq->rsplen < lsrsp->rsplen) ?
+				lsreq->rsplen : lsrsp->rsplen));
+	lsrsp->done(lsrsp);
 
 	schedule_work(&tls_req->work);
 
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
