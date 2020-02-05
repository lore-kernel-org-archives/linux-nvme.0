Return-Path: <SRS0=kk+z=3Z=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_DBL_ABUSE_MALW,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2B6C352A3
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:44:05 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D65F2072B
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Feb 2020 18:44:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="itcLO8+H";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHFmndKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D65F2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=zaeNl8dvAdTBdBYonBLPnT9pK+9WIWuEhFy689DHkDA=; b=itcLO8+H1afNhiV/BkblEv6C7B
	DkWEPJZycFYj/fnLditoBwHsDtOwZrXen42MpNsBZmN/Iviv/ELZ1rsRsSbF+OaBN2QUhWRv0DtNE
	IMSEkBRU7T6OXFTT71lit0p6YgJExxKwUgXvhs25w1P4AlnoHgTeqbfTwxytB+rautiOLhi0bfYfA
	VIrkZFmEbVvprfH/mRRstzoZ775eBck/qEDjiPlZ08Ps1B+Mi8ZeYTpTkPBjeRImvjbLSmmexkZZh
	tjgehlItzG2Wh47queS8iO1YNtONhdaR1F8yeMawnGQmDOBrB5Ld+agGFt+wK2QTKxLRzK0Zjz/hS
	ltIpoKgw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1izPeb-0000ky-RM; Wed, 05 Feb 2020 18:44:01 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1izPZQ-0003xV-61
 for linux-nvme@lists.infradead.org; Wed, 05 Feb 2020 18:38:55 +0000
Received: by mail-wr1-x444.google.com with SMTP id w12so4040066wrt.2
 for <linux-nvme@lists.infradead.org>; Wed, 05 Feb 2020 10:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bTLL6lkBnzw3up3+JAphPWW88i3mCKjASJ0DV9JFPPI=;
 b=JHFmndKlr7gYQWZ84zNfjTW/4YKAR+WYEdtDp+JBjIgKqF/kE3BIEfUHlTpYSyJj0d
 rIeP9M3P755A5P+m7tuS+NRS833pvsLl6cwRGKUVcD3RRc4cnJCRgF3oKDiNBdcs76DD
 Hz4N3gAOnOxSiSUABEEMRYZoT76U0srwX/AcHITPM3L/7g4GFHISM+2pI+SAwAg7wnOK
 jSLIMI6yvZC/t9+5ZDA6ytLfJsBQQnd+RWm/w69GDfUr+NozpcqRN/GmANDO12Ua8fwg
 o/iNVbsjuueJfFSPJ+S+k3arkmJktIGp9HoM5n46Q3hYlMyh1gOq0Tx1n5/5fSpFtZiW
 z10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bTLL6lkBnzw3up3+JAphPWW88i3mCKjASJ0DV9JFPPI=;
 b=gZBgcknbTOLXJIReG9e5fzzyt0WFciD62VJD+WC286zvlb992TrtfRDAwi8Q6svj8F
 SMNL8IWbxm+owDi1LYVTp1UmGEArJaBuTndh4vuxRtiFdqBQIuSRjjDgxmhi/LHLfu9L
 24Pc0eCTeqff4WHfe8oXWj5xKQ35Bc94slDfptilEBqOLxqR6Alty+Xdd0khkqn3op1D
 tAtANfR7/SxxqDb/3B9dJGhNPVUGYCjj75F8FhVttj/81/aczoZvPdARVK1tmHcVVuww
 gDWbRNWflyczclAKW+AM5uaBphqx+Xb1yy9wizj5yYe3H6vz6RZ2i3lXv2Rdznbaz4ug
 Q18w==
X-Gm-Message-State: APjAAAWgoJntiv0AV3NCqWdolXRLtu7kiaqWUh2oltxHjuw0UvWto8hU
 kx/WUl5DOfvJvfTprsKZFS20OfaR
X-Google-Smtp-Source: APXvYqxizYRhRVPtt4EE8jAH22+WPtBxUnqz1YRRuS1N9GOOgyacpMqcqMMYQgskK31+/6Uui8ghXA==
X-Received: by 2002:adf:f182:: with SMTP id h2mr29249138wro.364.1580927918460; 
 Wed, 05 Feb 2020 10:38:38 -0800 (PST)
Received: from os42.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a22sm490319wmd.20.2020.02.05.10.38.36
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 05 Feb 2020 10:38:38 -0800 (PST)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 23/29] lpfc: Refactor NVME LS receive handling
Date: Wed,  5 Feb 2020 10:37:47 -0800
Message-Id: <20200205183753.25959-24-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <20200205183753.25959-1-jsmart2021@gmail.com>
References: <20200205183753.25959-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200205_103840_661734_EA0B4DA6 
X-CRM114-Status: GOOD (  23.71  )
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
Cc: James Smart <jsmart2021@gmail.com>, Paul Ely <paul.ely@broadcom.com>,
 martin.petersen@oracle.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In preparation for supporting both intiator mode and target mode
receiving NVME LS's, commonize the existing NVME LS request receive
handling found in the base driver and in the nvmet side.

Using the original lpfc_nvmet_unsol_ls_event() and
lpfc_nvme_unsol_ls_buffer() routines as a templates, commonize the
reception of an NVME LS request. The common routine will validate the LS
request, that it was received from a logged-in node, and allocate a
lpfc_async_xchg_ctx that is used to manage the LS request. The role of
the port is then inspected to determine which handler is to receive the
LS - nvme or nvmet. As such, the nvmet handler is tied back in. A handler
is created in nvme and is stubbed out.

Signed-off-by: Paul Ely <paul.ely@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>
---
 drivers/scsi/lpfc/lpfc_crtn.h  |   6 +-
 drivers/scsi/lpfc/lpfc_nvme.c  |  19 +++++
 drivers/scsi/lpfc/lpfc_nvme.h  |   5 ++
 drivers/scsi/lpfc/lpfc_nvmet.c | 163 ++++++++++-------------------------------
 drivers/scsi/lpfc/lpfc_sli.c   | 121 +++++++++++++++++++++++++++++-
 5 files changed, 184 insertions(+), 130 deletions(-)

diff --git a/drivers/scsi/lpfc/lpfc_crtn.h b/drivers/scsi/lpfc/lpfc_crtn.h
index 9cd7767636d3..928e40fcf544 100644
--- a/drivers/scsi/lpfc/lpfc_crtn.h
+++ b/drivers/scsi/lpfc/lpfc_crtn.h
@@ -564,8 +564,10 @@ void lpfc_nvme_update_localport(struct lpfc_vport *vport);
 int lpfc_nvmet_create_targetport(struct lpfc_hba *phba);
 int lpfc_nvmet_update_targetport(struct lpfc_hba *phba);
 void lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba);
-void lpfc_nvmet_unsol_ls_event(struct lpfc_hba *phba,
-			struct lpfc_sli_ring *pring, struct lpfc_iocbq *piocb);
+int lpfc_nvme_handle_lsreq(struct lpfc_hba *phba,
+			struct lpfc_async_xchg_ctx *axchg);
+int lpfc_nvmet_handle_lsreq(struct lpfc_hba *phba,
+			struct lpfc_async_xchg_ctx *axchg);
 void lpfc_nvmet_unsol_fcp_event(struct lpfc_hba *phba, uint32_t idx,
 				struct rqb_dmabuf *nvmebuf, uint64_t isr_ts,
 				uint8_t cqflag);
diff --git a/drivers/scsi/lpfc/lpfc_nvme.c b/drivers/scsi/lpfc/lpfc_nvme.c
index 21f2282b26ba..daded70ce7b6 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.c
+++ b/drivers/scsi/lpfc/lpfc_nvme.c
@@ -391,6 +391,25 @@ lpfc_nvme_remoteport_delete(struct nvme_fc_remote_port *remoteport)
 	return;
 }
 
+/**
+ * lpfc_nvme_handle_lsreq - Process an unsolicited NVME LS request
+ * @phba: pointer to lpfc hba data structure.
+ * @axchg: pointer to exchange context for the NVME LS request
+ *
+ * This routine is used for processing an asychronously received NVME LS
+ * request. Any remaining validation is done and the LS is then forwarded
+ * to the nvme-fc transport via nvme_fc_rcv_ls_req().
+ *
+ * Returns 0 if LS was handled and delivered to the transport
+ * Returns 1 if LS failed to be handled and should be dropped
+ */
+int
+lpfc_nvme_handle_lsreq(struct lpfc_hba *phba,
+			struct lpfc_async_xchg_ctx *axchg)
+{
+	return 1;
+}
+
 static void
 lpfc_nvme_cmpl_gen_req(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 		       struct lpfc_wcqe_complete *wcqe)
diff --git a/drivers/scsi/lpfc/lpfc_nvme.h b/drivers/scsi/lpfc/lpfc_nvme.h
index c5706c950625..7525b12b06c8 100644
--- a/drivers/scsi/lpfc/lpfc_nvme.h
+++ b/drivers/scsi/lpfc/lpfc_nvme.h
@@ -189,6 +189,7 @@ struct lpfc_async_xchg_ctx {
 	} hdlrctx;
 	struct list_head list;
 	struct lpfc_hba *phba;
+	struct lpfc_nodelist *ndlp;
 	struct nvmefc_ls_req *ls_req;
 	struct nvmefc_ls_rsp ls_rsp;
 	struct lpfc_iocbq *wqeq;
@@ -203,6 +204,7 @@ struct lpfc_async_xchg_ctx {
 	uint16_t idx;
 	uint16_t state;
 	uint16_t flag;
+	void *payload;
 	struct rqb_dmabuf *rqb_buffer;
 	struct lpfc_nvmet_ctxbuf *ctxbuf;
 	struct lpfc_sli4_hdw_queue *hdwq;
@@ -225,3 +227,6 @@ struct lpfc_async_xchg_ctx {
 /* routines found in lpfc_nvme.c */
 
 /* routines found in lpfc_nvmet.c */
+int lpfc_nvme_unsol_ls_issue_abort(struct lpfc_hba *phba,
+			struct lpfc_async_xchg_ctx *ctxp, uint32_t sid,
+			uint16_t xri);
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 28db056cf5af..e6895c719683 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -63,9 +63,6 @@ static int lpfc_nvmet_sol_fcp_issue_abort(struct lpfc_hba *,
 static int lpfc_nvmet_unsol_fcp_issue_abort(struct lpfc_hba *,
 					    struct lpfc_async_xchg_ctx *,
 					    uint32_t, uint16_t);
-static int lpfc_nvmet_unsol_ls_issue_abort(struct lpfc_hba *,
-					   struct lpfc_async_xchg_ctx *,
-					   uint32_t, uint16_t);
 static void lpfc_nvmet_wqfull_flush(struct lpfc_hba *, struct lpfc_queue *,
 				    struct lpfc_async_xchg_ctx *);
 static void lpfc_nvmet_fcp_rqst_defer_work(struct work_struct *);
@@ -867,7 +864,7 @@ lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtport,
 				ctxp->oxid);
 		lpfc_in_buf_free(phba, &nvmebuf->dbuf);
 		atomic_inc(&nvmep->xmt_ls_abort);
-		lpfc_nvmet_unsol_ls_issue_abort(phba, ctxp,
+		lpfc_nvme_unsol_ls_issue_abort(phba, ctxp,
 						ctxp->sid, ctxp->oxid);
 		return -ENOMEM;
 	}
@@ -910,7 +907,7 @@ lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtport,
 
 	lpfc_in_buf_free(phba, &nvmebuf->dbuf);
 	atomic_inc(&nvmep->xmt_ls_abort);
-	lpfc_nvmet_unsol_ls_issue_abort(phba, ctxp, ctxp->sid, ctxp->oxid);
+	lpfc_nvme_unsol_ls_issue_abort(phba, ctxp, ctxp->sid, ctxp->oxid);
 	return -ENXIO;
 }
 
@@ -1923,107 +1920,49 @@ lpfc_nvmet_destroy_targetport(struct lpfc_hba *phba)
 }
 
 /**
- * lpfc_nvmet_unsol_ls_buffer - Process an unsolicited event data buffer
+ * lpfc_nvmet_handle_lsreq - Process an NVME LS request
  * @phba: pointer to lpfc hba data structure.
- * @pring: pointer to a SLI ring.
- * @nvmebuf: pointer to lpfc nvme command HBQ data structure.
+ * @axchg: pointer to exchange context for the NVME LS request
  *
- * This routine is used for processing the WQE associated with a unsolicited
- * event. It first determines whether there is an existing ndlp that matches
- * the DID from the unsolicited WQE. If not, it will create a new one with
- * the DID from the unsolicited WQE. The ELS command from the unsolicited
- * WQE is then used to invoke the proper routine and to set up proper state
- * of the discovery state machine.
- **/
-static void
-lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
-			   struct hbq_dmabuf *nvmebuf)
+ * This routine is used for processing an asychronously received NVME LS
+ * request. Any remaining validation is done and the LS is then forwarded
+ * to the nvmet-fc transport via nvmet_fc_rcv_ls_req().
+ *
+ * The calling sequence should be: nvmet_fc_rcv_ls_req() -> (processing)
+ * -> lpfc_nvmet_xmt_ls_rsp/cmp -> req->done.
+ * lpfc_nvme_xmt_ls_rsp_cmp should free the allocated axchg.
+ *
+ * Returns 0 if LS was handled and delivered to the transport
+ * Returns 1 if LS failed to be handled and should be dropped
+ */
+int
+lpfc_nvmet_handle_lsreq(struct lpfc_hba *phba,
+			struct lpfc_async_xchg_ctx *axchg)
 {
 #if (IS_ENABLED(CONFIG_NVME_TARGET_FC))
-	struct lpfc_nvmet_tgtport *tgtp;
-	struct fc_frame_header *fc_hdr;
-	struct lpfc_async_xchg_ctx *ctxp;
-	uint32_t *payload;
-	uint32_t size, oxid, sid, rc;
-
-
-	if (!nvmebuf || !phba->targetport) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
-				"6154 LS Drop IO\n");
-		oxid = 0;
-		size = 0;
-		sid = 0;
-		ctxp = NULL;
-		goto dropit;
-	}
-
-	fc_hdr = (struct fc_frame_header *)(nvmebuf->hbuf.virt);
-	oxid = be16_to_cpu(fc_hdr->fh_ox_id);
-
-	tgtp = (struct lpfc_nvmet_tgtport *)phba->targetport->private;
-	payload = (uint32_t *)(nvmebuf->dbuf.virt);
-	size = bf_get(lpfc_rcqe_length,  &nvmebuf->cq_event.cqe.rcqe_cmpl);
-	sid = sli4_sid_from_fc_hdr(fc_hdr);
-
-	ctxp = kzalloc(sizeof(struct lpfc_async_xchg_ctx), GFP_ATOMIC);
-	if (ctxp == NULL) {
-		atomic_inc(&tgtp->rcv_ls_req_drop);
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
-				"6155 LS Drop IO x%x: Alloc\n",
-				oxid);
-dropit:
-		lpfc_nvmeio_data(phba, "NVMET LS  DROP: "
-				 "xri x%x sz %d from %06x\n",
-				 oxid, size, sid);
-		lpfc_in_buf_free(phba, &nvmebuf->dbuf);
-		return;
-	}
-	ctxp->phba = phba;
-	ctxp->size = size;
-	ctxp->oxid = oxid;
-	ctxp->sid = sid;
-	ctxp->wqeq = NULL;
-	ctxp->state = LPFC_NVME_STE_LS_RCV;
-	ctxp->entry_cnt = 1;
-	ctxp->rqb_buffer = (void *)nvmebuf;
-	ctxp->hdwq = &phba->sli4_hba.hdwq[0];
+	struct lpfc_nvmet_tgtport *tgtp = phba->targetport->private;
+	uint32_t *payload = axchg->payload;
+	int rc;
 
-	lpfc_nvmeio_data(phba, "NVMET LS   RCV: xri x%x sz %d from %06x\n",
-			 oxid, size, sid);
-	/*
-	 * The calling sequence should be:
-	 * nvmet_fc_rcv_ls_req -> lpfc_nvmet_xmt_ls_rsp/cmp ->_req->done
-	 * lpfc_nvmet_xmt_ls_rsp_cmp should free the allocated ctxp.
-	 */
 	atomic_inc(&tgtp->rcv_ls_req_in);
-	rc = nvmet_fc_rcv_ls_req(phba->targetport, NULL, &ctxp->ls_rsp,
-				 payload, size);
+
+	rc = nvmet_fc_rcv_ls_req(phba->targetport, NULL, &axchg->ls_rsp,
+				 axchg->payload, axchg->size);
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
 			"6037 NVMET Unsol rcv: sz %d rc %d: %08x %08x %08x "
-			"%08x %08x %08x\n", size, rc,
+			"%08x %08x %08x\n", axchg->size, rc,
 			*payload, *(payload+1), *(payload+2),
 			*(payload+3), *(payload+4), *(payload+5));
 
-	if (rc == 0) {
+	if (!rc) {
 		atomic_inc(&tgtp->rcv_ls_req_out);
-		return;
+		return 0;
 	}
 
-	lpfc_nvmeio_data(phba, "NVMET LS  DROP: xri x%x sz %d from %06x\n",
-			 oxid, size, sid);
-
 	atomic_inc(&tgtp->rcv_ls_req_drop);
-	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
-			"6156 LS Drop IO x%x: nvmet_fc_rcv_ls_req %d\n",
-			ctxp->oxid, rc);
-
-	/* We assume a rcv'ed cmd ALWAYs fits into 1 buffer */
-	lpfc_in_buf_free(phba, &nvmebuf->dbuf);
-
-	atomic_inc(&tgtp->xmt_ls_abort);
-	lpfc_nvmet_unsol_ls_issue_abort(phba, ctxp, sid, oxid);
 #endif
+	return 1;
 }
 
 static void
@@ -2368,40 +2307,6 @@ lpfc_nvmet_unsol_fcp_buffer(struct lpfc_hba *phba,
 }
 
 /**
- * lpfc_nvmet_unsol_ls_event - Process an unsolicited event from an nvme nport
- * @phba: pointer to lpfc hba data structure.
- * @pring: pointer to a SLI ring.
- * @nvmebuf: pointer to received nvme data structure.
- *
- * This routine is used to process an unsolicited event received from a SLI
- * (Service Level Interface) ring. The actual processing of the data buffer
- * associated with the unsolicited event is done by invoking the routine
- * lpfc_nvmet_unsol_ls_buffer() after properly set up the buffer from the
- * SLI RQ on which the unsolicited event was received.
- **/
-void
-lpfc_nvmet_unsol_ls_event(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
-			  struct lpfc_iocbq *piocb)
-{
-	struct lpfc_dmabuf *d_buf;
-	struct hbq_dmabuf *nvmebuf;
-
-	d_buf = piocb->context2;
-	nvmebuf = container_of(d_buf, struct hbq_dmabuf, dbuf);
-
-	if (!nvmebuf) {
-		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_IOERR,
-				"3015 LS Drop IO\n");
-		return;
-	}
-	if (phba->nvmet_support == 0) {
-		lpfc_in_buf_free(phba, &nvmebuf->dbuf);
-		return;
-	}
-	lpfc_nvmet_unsol_ls_buffer(phba, pring, nvmebuf);
-}
-
-/**
  * lpfc_nvmet_unsol_fcp_event - Process an unsolicited event from an nvme nport
  * @phba: pointer to lpfc hba data structure.
  * @idx: relative index of MRQ vector
@@ -3404,8 +3309,16 @@ lpfc_nvmet_unsol_fcp_issue_abort(struct lpfc_hba *phba,
 	return 1;
 }
 
-static int
-lpfc_nvmet_unsol_ls_issue_abort(struct lpfc_hba *phba,
+/**
+ * lpfc_nvme_unsol_ls_issue_abort - issue ABTS on an exchange received
+ *        via async frame receive where the frame is not handled.
+ * @phba: pointer to adapter structure
+ * @ctxp: pointer to the asynchronously received received sequence
+ * @sid: address of the remote port to send the ABTS to
+ * @xri: oxid value to for the ABTS (other side's exchange id).
+ **/
+int
+lpfc_nvme_unsol_ls_issue_abort(struct lpfc_hba *phba,
 				struct lpfc_async_xchg_ctx *ctxp,
 				uint32_t sid, uint16_t xri)
 {
diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 23f034dfd3e2..0d167e200d8f 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -2800,6 +2800,121 @@ lpfc_sli_get_buff(struct lpfc_hba *phba,
 }
 
 /**
+ * lpfc_nvme_unsol_ls_handler - Process an unsolicited event data buffer
+ *                              containing a NVME LS request.
+ * @phba: pointer to lpfc hba data structure.
+ * @piocb: pointer to the iocbq struct representing the sequence starting
+ *        frame.
+ *
+ * This routine initially validates the NVME LS, validates there is a login
+ * with the port that sent the LS, and then calls the appropriate nvme host
+ * or target LS request handler.
+ **/
+static void
+lpfc_nvme_unsol_ls_handler(struct lpfc_hba *phba, struct lpfc_iocbq *piocb)
+{
+	struct lpfc_nodelist *ndlp;
+	struct lpfc_dmabuf *d_buf;
+	struct hbq_dmabuf *nvmebuf;
+	struct fc_frame_header *fc_hdr;
+	struct lpfc_async_xchg_ctx *axchg = NULL;
+	char *failwhy = NULL;
+	uint32_t oxid, sid, did, fctl, size;
+	int ret;
+
+	d_buf = piocb->context2;
+
+	nvmebuf = container_of(d_buf, struct hbq_dmabuf, dbuf);
+	fc_hdr = nvmebuf->hbuf.virt;
+	oxid = be16_to_cpu(fc_hdr->fh_ox_id);
+	sid = sli4_sid_from_fc_hdr(fc_hdr);
+	did = sli4_did_from_fc_hdr(fc_hdr);
+	fctl = (fc_hdr->fh_f_ctl[0] << 16 |
+		fc_hdr->fh_f_ctl[1] << 8 |
+		fc_hdr->fh_f_ctl[2]);
+	size = bf_get(lpfc_rcqe_length, &nvmebuf->cq_event.cqe.rcqe_cmpl);
+
+	lpfc_nvmeio_data(phba, "NVME LS    RCV: xri x%x sz %d from %06x\n",
+			 oxid, size, sid);
+
+	if (phba->pport->load_flag & FC_UNLOADING) {
+		failwhy = "Driver Unloading";
+	} else if (!(phba->cfg_enable_fc4_type & LPFC_ENABLE_NVME)) {
+		failwhy = "NVME FC4 Disabled";
+	} else if (!phba->nvmet_support && !phba->pport->localport) {
+		failwhy = "No Localport";
+	} else if (phba->nvmet_support && !phba->targetport) {
+		failwhy = "No Targetport";
+	} else if (unlikely(fc_hdr->fh_r_ctl != FC_RCTL_ELS4_REQ)) {
+		failwhy = "Bad NVME LS R_CTL";
+	} else if (unlikely((fctl & 0x00FF0000) !=
+			(FC_FC_FIRST_SEQ | FC_FC_END_SEQ | FC_FC_SEQ_INIT))) {
+		failwhy = "Bad NVME LS F_CTL";
+	} else {
+		axchg = kzalloc(sizeof(*axchg), GFP_ATOMIC);
+		if (!axchg)
+			failwhy = "No CTX memory";
+	}
+
+	if (unlikely(failwhy)) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC | LOG_NVME_IOERR,
+				"6154 Drop NVME LS: SID %06X OXID x%X: %s\n",
+				sid, oxid, failwhy);
+		goto out_fail;
+	}
+
+	/* validate the source of the LS is logged in */
+	ndlp = lpfc_findnode_did(phba->pport, sid);
+	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp) ||
+	    ((ndlp->nlp_state != NLP_STE_UNMAPPED_NODE) &&
+	     (ndlp->nlp_state != NLP_STE_MAPPED_NODE))) {
+		lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC,
+				"6216 NVME Unsol rcv: No ndlp: "
+				"NPort_ID x%x oxid x%x\n",
+				sid, oxid);
+		goto out_fail;
+	}
+
+	axchg->phba = phba;
+	axchg->ndlp = ndlp;
+	axchg->size = size;
+	axchg->oxid = oxid;
+	axchg->sid = sid;
+	axchg->wqeq = NULL;
+	axchg->state = LPFC_NVME_STE_LS_RCV;
+	axchg->entry_cnt = 1;
+	axchg->rqb_buffer = (void *)nvmebuf;
+	axchg->hdwq = &phba->sli4_hba.hdwq[0];
+	axchg->payload = nvmebuf->dbuf.virt;
+	INIT_LIST_HEAD(&axchg->list);
+
+	if (phba->nvmet_support)
+		ret = lpfc_nvmet_handle_lsreq(phba, axchg);
+	else
+		ret = lpfc_nvme_handle_lsreq(phba, axchg);
+
+	/* if zero, LS was successfully handled. If non-zero, LS not handled */
+	if (!ret)
+		return;
+
+	lpfc_printf_log(phba, KERN_ERR, LOG_NVME_DISC | LOG_NVME_IOERR,
+			"6155 Drop NVME LS from DID %06X: SID %06X OXID x%X "
+			"NVMe%s handler failed %d\n",
+			did, sid, oxid,
+			(phba->nvmet_support) ? "T" : "I", ret);
+
+out_fail:
+	kfree(axchg);
+
+	/* recycle receive buffer */
+	lpfc_in_buf_free(phba, &nvmebuf->dbuf);
+
+	/* If start of new exchange, abort it */
+	if (fctl & FC_FC_FIRST_SEQ && !(fctl & FC_FC_EX_CTX))
+		lpfc_nvme_unsol_ls_issue_abort(phba, axchg, sid, oxid);
+}
+
+/**
  * lpfc_complete_unsol_iocb - Complete an unsolicited sequence
  * @phba: Pointer to HBA context object.
  * @pring: Pointer to driver SLI ring object.
@@ -2820,7 +2935,7 @@ lpfc_complete_unsol_iocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 
 	switch (fch_type) {
 	case FC_TYPE_NVME:
-		lpfc_nvmet_unsol_ls_event(phba, pring, saveq);
+		lpfc_nvme_unsol_ls_handler(phba, saveq);
 		return 1;
 	default:
 		break;
@@ -13996,8 +14111,8 @@ lpfc_sli4_nvmet_handle_rcqe(struct lpfc_hba *phba, struct lpfc_queue *cq,
 
 		/* Just some basic sanity checks on FCP Command frame */
 		fctl = (fc_hdr->fh_f_ctl[0] << 16 |
-		fc_hdr->fh_f_ctl[1] << 8 |
-		fc_hdr->fh_f_ctl[2]);
+			fc_hdr->fh_f_ctl[1] << 8 |
+			fc_hdr->fh_f_ctl[2]);
 		if (((fctl &
 		    (FC_FC_FIRST_SEQ | FC_FC_END_SEQ | FC_FC_SEQ_INIT)) !=
 		    (FC_FC_FIRST_SEQ | FC_FC_END_SEQ | FC_FC_SEQ_INIT)) ||
-- 
2.13.7


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
